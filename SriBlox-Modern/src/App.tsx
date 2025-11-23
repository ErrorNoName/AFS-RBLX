import Roact from "@rbxts/roact";
import { hooked, useState, useEffect } from "@rbxts/roact-hooked";
import store from "./store/store";
import { setSearchQuery, setSearchResults, setLoading, setError, toggleVisibility } from "./store/actions";
import { ScriptBloxService } from "./services/scriptblox.service";
import { SearchBar } from "./components/SearchBar";
import { ScriptCard } from "./components/ScriptCard";
import SplashScreen from "./components/SplashScreen";
import BottomNavbar from "./components/BottomNavbar";
import { sorbetTheme } from "./themes/themes";
import { Script } from "./types";

const UserInputService = game.GetService("UserInputService");
const TweenService = game.GetService("TweenService");

const AppContent = hooked(() => {
	const [currentTheme] = useState(sorbetTheme); // Thème Sorbet par défaut
	const [searchQuery, setSearchQueryState] = useState("");
	const [isVisible, setIsVisible] = useState(false);
	const [showSplash, setShowSplash] = useState(true);
	const [isLoading, setIsLoadingState] = useState(false);
	const [scripts, setScripts] = useState<Script[]>([]);
	const [currentPage, setCurrentPage] = useState<"scripts" | "favorites" | "history" | "settings">("scripts");

	// F6 toggle visibility
	useEffect(() => {
		const connection = UserInputService.InputBegan.Connect((input, gameProcessed) => {
			if (!gameProcessed && input.KeyCode === Enum.KeyCode.F6) {
				setIsVisible(!isVisible);
				store.dispatch(toggleVisibility());
			}
		});
		return () => connection.Disconnect();
	}, [isVisible]);

	// Handle search
	const handleSearch = (query: string) => {
		if (query === "") return;
		setSearchQueryState(query);
		setIsLoadingState(true);
		store.dispatch(setLoading(true));
		store.dispatch(setSearchQuery(query));

		ScriptBloxService.searchScripts(query, 1, 24) // 24 scripts pour grid 4x6
			.then((response) => {
				setScripts(response.result.scripts);
				setIsLoadingState(false);
				store.dispatch(setSearchResults(response.result.scripts, response.result.totalPages));
			})
			.catch((err) => {
				setIsLoadingState(false);
				store.dispatch(setError(tostring(err)));
			});
	};

	// Splash screen complete callback
	const handleSplashComplete = () => {
		setShowSplash(false);
		setIsVisible(true); // Auto-show après splash
	};

	// Show splash screen
	if (showSplash) {
		return <SplashScreen theme={currentTheme} onComplete={handleSplashComplete} />;
	}

	return (
		<screengui
			Key="SriBloxModern"
			ResetOnSpawn={false}
			ZIndexBehavior={Enum.ZIndexBehavior.Sibling}
			IgnoreGuiInset={true}
			Enabled={isVisible}
		>
			{/* Background overlay avec gradient */}
			<frame
				Size={UDim2.fromScale(1, 1)}
				BackgroundColor3={currentTheme.colors.background}
				BackgroundTransparency={0}
				BorderSizePixel={0}
			>
				<uigradient
					Color={new ColorSequence([
						new ColorSequenceKeypoint(0, currentTheme.gradients.primary[0]),
						new ColorSequenceKeypoint(1, currentTheme.gradients.primary[1]),
					])}
					Transparency={new NumberSequence([
						new NumberSequenceKeypoint(0, 0.92),
						new NumberSequenceKeypoint(1, 0.96),
					])}
					Rotation={135}
				/>
			</frame>

			{/* Main content container */}
			<frame
				Size={UDim2.fromScale(1, 1)}
				BackgroundTransparency={1}
				BorderSizePixel={0}
			>
				{/* Top header avec titre */}
				<frame
					Size={new UDim2(1, 0, 0, 80)}
					Position={UDim2.fromOffset(0, 0)}
					BackgroundColor3={currentTheme.colors.surface}
					BackgroundTransparency={0.7}
					BorderSizePixel={0}
				>
					<uigradient
						Transparency={new NumberSequence([
							new NumberSequenceKeypoint(0, 0.85),
							new NumberSequenceKeypoint(1, 1),
						])}
						Rotation={90}
					/>

					{/* Gradient bottom border */}
					<frame
						Size={new UDim2(1, 0, 0, 2)}
						Position={new UDim2(0, 0, 1, 0)}
						BackgroundColor3={currentTheme.colors.primary}
						BorderSizePixel={0}
					>
						<uigradient
							Color={new ColorSequence([
								new ColorSequenceKeypoint(0, currentTheme.colors.primary),
								new ColorSequenceKeypoint(0.5, currentTheme.colors.primaryVariant),
								new ColorSequenceKeypoint(1, currentTheme.colors.secondary),
							])}
							Rotation={90}
						/>
					</frame>

					{/* Logo text */}
					<textlabel
						Size={UDim2.fromOffset(200, 40)}
						Position={UDim2.fromOffset(32, 20)}
						BackgroundTransparency={1}
						Text="SriBlox"
						Font={Enum.Font.GothamBold}
						TextSize={32}
						TextColor3={Color3.fromRGB(255, 255, 255)}
						TextXAlignment={Enum.TextXAlignment.Left}
					>
						<uigradient
							Color={new ColorSequence([
								new ColorSequenceKeypoint(0, currentTheme.colors.primary),
								new ColorSequenceKeypoint(0.5, currentTheme.colors.primaryVariant),
								new ColorSequenceKeypoint(1, currentTheme.colors.secondary),
							])}
							Rotation={0}
						/>
					</textlabel>

					{/* Version badge */}
					<frame
						Size={UDim2.fromOffset(60, 24)}
						Position={UDim2.fromOffset(240, 28)}
						BackgroundColor3={currentTheme.colors.primaryVariant}
						BackgroundTransparency={0.2}
						BorderSizePixel={0}
					>
						<uicorner CornerRadius={new UDim(0, 6)} />
						<textlabel
							Size={UDim2.fromScale(1, 1)}
							BackgroundTransparency={1}
							Text="v2.0"
							Font={Enum.Font.GothamBold}
							TextSize={12}
							TextColor3={Color3.fromRGB(255, 255, 255)}
						/>
					</frame>
				</frame>

				{/* Search bar area */}
				<frame
					Size={new UDim2(1, 0, 0, 80)}
					Position={UDim2.fromOffset(0, 80)}
					BackgroundTransparency={1}
					BorderSizePixel={0}
				>
					<SearchBar
						theme={currentTheme}
						onSearch={handleSearch}
						onSettingsClick={() => setCurrentPage("settings")}
						placeholder="Search scripts on ScriptBlox..."
					/>
				</frame>

				{/* Content area (scripts grid) */}
				<scrollingframe
					Size={new UDim2(1, 0, 1, -240)} // -240 pour header (160) + navbar (80)
					Position={UDim2.fromOffset(0, 160)}
					BackgroundTransparency={1}
					BorderSizePixel={0}
					ScrollBarThickness={6}
					ScrollBarImageColor3={currentTheme.colors.primaryVariant}
					CanvasSize={UDim2.fromOffset(0, 0)}
					AutomaticCanvasSize={Enum.AutomaticSize.Y}
				>
					{/* Grid layout */}
					<uigridlayout
						CellSize={UDim2.fromOffset(280, 200)} // Cartes 280x200
						CellPadding={UDim2.fromOffset(20, 20)}
						HorizontalAlignment={Enum.HorizontalAlignment.Center}
						VerticalAlignment={Enum.VerticalAlignment.Top}
						SortOrder={Enum.SortOrder.LayoutOrder}
						StartCorner={Enum.StartCorner.TopLeft}
					/>
					<uipadding
						PaddingTop={new UDim(0, 24)}
						PaddingBottom={new UDim(0, 24)}
						PaddingLeft={new UDim(0, 24)}
						PaddingRight={new UDim(0, 24)}
					/>

					{/* Loading state */}
					{isLoading && (
						<frame
							Key="LoadingCard"
							Size={UDim2.fromOffset(280, 200)}
							BackgroundColor3={currentTheme.colors.surface}
							BackgroundTransparency={0.05}
							BorderSizePixel={0}
							LayoutOrder={0}
						>
							<uicorner CornerRadius={new UDim(0, 12)} />
							<textlabel
								Size={UDim2.fromScale(1, 1)}
								BackgroundTransparency={1}
								Text="🔄 Loading..."
								Font={Enum.Font.GothamBold}
								TextSize={24}
								TextColor3={currentTheme.colors.primaryVariant}
							/>
						</frame>
					)}

					{/* No results */}
					{!isLoading && scripts.size() === 0 && searchQuery !== "" && (
						<frame
							Key="NoResultsCard"
							Size={UDim2.fromOffset(280, 200)}
							BackgroundColor3={currentTheme.colors.surface}
							BackgroundTransparency={0.05}
							BorderSizePixel={0}
							LayoutOrder={0}
						>
							<uicorner CornerRadius={new UDim(0, 12)} />
							<textlabel
								Size={UDim2.fromScale(1, 1)}
								BackgroundTransparency={1}
								Text="🔍 No results found"
								Font={Enum.Font.GothamBold}
								TextSize={20}
								TextColor3={currentTheme.colors.textSecondary}
							/>
						</frame>
					)}

					{/* Welcome screen */}
					{!isLoading && scripts.size() === 0 && searchQuery === "" && (
						<frame
							Key="WelcomeCard"
							Size={UDim2.fromOffset(600, 320)}
							Position={UDim2.fromScale(0.5, 0.3)}
							AnchorPoint={new Vector2(0.5, 0)}
							BackgroundColor3={currentTheme.colors.surface}
							BackgroundTransparency={0.02}
							BorderSizePixel={0}
							LayoutOrder={0}
						>
							<uicorner CornerRadius={new UDim(0, 16)} />
							<uistroke Color={currentTheme.colors.primary} Thickness={2} Transparency={0.5}>
								<uigradient
									Color={new ColorSequence([
										new ColorSequenceKeypoint(0, currentTheme.colors.primary),
										new ColorSequenceKeypoint(0.5, currentTheme.colors.primaryVariant),
										new ColorSequenceKeypoint(1, currentTheme.colors.secondary),
									])}
									Rotation={45}
								/>
							</uistroke>

							<textlabel
								Size={new UDim2(1, -60, 0, 60)}
								Position={UDim2.fromOffset(30, 30)}
								BackgroundTransparency={1}
								Text="Welcome to SriBlox Modern"
								Font={Enum.Font.GothamBold}
								TextSize={28}
								TextColor3={Color3.fromRGB(255, 255, 255)}
								TextXAlignment={Enum.TextXAlignment.Left}
							>
								<uigradient
									Color={new ColorSequence([
										new ColorSequenceKeypoint(0, currentTheme.colors.primary),
										new ColorSequenceKeypoint(1, currentTheme.colors.secondary),
									])}
									Rotation={0}
								/>
							</textlabel>

							<textlabel
								Size={new UDim2(1, -60, 0, 140)}
								Position={UDim2.fromOffset(30, 100)}
								BackgroundTransparency={1}
								Text="• Search for scripts using the search bar above\n• Press F6 to toggle this interface\n• Browse thousands of Roblox scripts\n• Click Run to execute scripts instantly"
								Font={Enum.Font.Gotham}
								TextSize={16}
								TextColor3={currentTheme.colors.textSecondary}
								TextXAlignment={Enum.TextXAlignment.Left}
								TextYAlignment={Enum.TextYAlignment.Top}
								TextWrapped={true}
								LineHeight={1.5}
							/>

							<frame
								Size={UDim2.fromOffset(200, 40)}
								Position={new UDim2(0.5, -100, 1, -70)}
								BackgroundColor3={currentTheme.colors.primaryVariant}
								BackgroundTransparency={0.1}
								BorderSizePixel={0}
							>
								<uicorner CornerRadius={new UDim(0, 10)} />
								<textlabel
									Size={UDim2.fromScale(1, 1)}
									BackgroundTransparency={1}
									Text="Ready to explore!"
									Font={Enum.Font.GothamBold}
									TextSize={18}
									TextColor3={Color3.fromRGB(255, 255, 255)}
								/>
							</frame>
						</frame>
					)}

					{/* Script cards */}
					{!isLoading &&
						scripts.map((scr, idx) => (
							<ScriptCard Key={scr._id} scriptData={scr} theme={currentTheme} index={idx} />
						))}
				</scrollingframe>

				{/* Bottom Navbar */}
				<BottomNavbar
					theme={currentTheme}
					isVisible={isVisible}
					currentPage={currentPage}
					onPageChange={(page) => setCurrentPage(page)}
				/>
			</frame>
		</screengui>
	);
});

export = hooked(() => {
	return <AppContent />;
});
