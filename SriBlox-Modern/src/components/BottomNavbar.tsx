import Roact from "@rbxts/roact";
import { hooked, useState, useEffect } from "@rbxts/roact-hooked";
import { TweenService, RunService } from "@rbxts/services";
import { Theme } from "../types";

interface BottomNavbarProps {
	theme: Theme;
	isVisible: boolean;
	currentPage: "scripts" | "favorites" | "history" | "settings";
	onPageChange: (page: "scripts" | "favorites" | "history" | "settings") => void;
}

interface NavTab {
	id: "scripts" | "favorites" | "history" | "settings";
	icon: string;
	label: string;
}

const NAV_TABS: NavTab[] = [
	{ id: "scripts", icon: "rbxassetid://10723434711", label: "Scripts" },      // Search/magnifying glass
	{ id: "favorites", icon: "rbxassetid://10723407389", label: "Favorites" },  // Star
	{ id: "history", icon: "rbxassetid://10723415766", label: "History" },      // Clock/History
	{ id: "settings", icon: "rbxassetid://10734896206", label: "Settings" },    // Settings gear
];

// Positions EXACTES de l'indicateur pour chaque tab (en pixels absolus)
const INDICATOR_POSITIONS: Record<"scripts" | "favorites" | "history" | "settings", number> = {
	scripts: 200,      // Tab 1: position X = 200px
	favorites: 0,  // Tab 2: position X = 0px
	history: 100,    // Tab 3: position X = 100px
	settings: 300,   // Tab 4: position X = 300px
};

/**
 * Bottom Navbar style Orca AMÉLIORÉ
 * Barre de navigation 400x56 en bas centrée avec animations TweenService réelles
 */
const BottomNavbar = hooked<BottomNavbarProps>((props) => {
	const { theme, isVisible, currentPage, onPageChange } = props;
	const [hoveredTab, setHoveredTab] = useState<string | undefined>(undefined);
	const [indicatorPosition, setIndicatorPosition] = useState(0);
	const [navbarYOffset, setNavbarYOffset] = useState(100); // Commence caché (en dessous)

	// Couleur du gradient en fonction de la tab active
	const getAccentColor = () => {
		// Déterminer la couleur selon la page active
		if (currentPage === "scripts") return theme.colors.primary; // Rose - Scripts
		if (currentPage === "favorites") return theme.colors.primaryVariant; // Violet - Favorites
		if (currentPage === "history") return theme.colors.secondary; // Bleu - History
		return theme.colors.accent; // Mix - Settings
	};

	// Animer la navbar slide up/down quand isVisible change
	useEffect(() => {
		const targetY = isVisible ? -20 : 100; // -20px visible, 100px caché
		const startY = navbarYOffset;
		const distance = targetY - startY;
		const duration = 0.6; // Animation plus longue pour effet spring
		const startTime = tick();

		const connection = RunService.RenderStepped.Connect(() => {
			const elapsed = tick() - startTime;
			const progress = math.min(elapsed / duration, 1);

			// Spring easing - bounce effect comme Orca
			// Formula: 1 - (1-x)^4 * cos(x * PI * 2.5)
			const eased = 1 - math.pow(1 - progress, 4) * math.cos(progress * math.pi * 2.5);
			const currentY = startY + distance * eased;

			setNavbarYOffset(currentY);

			if (progress >= 1) {
				connection.Disconnect();
			}
		});

		return () => {
			connection.Disconnect();
		};
	}, [isVisible]);

	// Animer l'indicateur quand la page change
	useEffect(() => {
		// Récupérer la position EXACTE depuis le dictionnaire
		const targetX = INDICATOR_POSITIONS[currentPage];

		// DEBUG: Afficher les valeurs
		print(`[BottomNavbar] Page: ${currentPage}, TargetX: ${targetX}px (position absolue)`);

		// Animation smooth avec interpolation manuelle
		const startX = indicatorPosition;
		const distance = targetX - startX;
		const duration = 0.35;
		const startTime = tick();

		const connection = RunService.RenderStepped.Connect(() => {
			const elapsed = tick() - startTime;
			const progress = math.min(elapsed / duration, 1);

			// Easing Quint Out (1 - (1-x)^5 pour smooth deceleration)
			const eased = 1 - math.pow(1 - progress, 5);
			const currentX = startX + distance * eased;

			setIndicatorPosition(currentX);

			if (progress >= 1) {
				connection.Disconnect();
			}
		});

		return () => {
			connection.Disconnect();
		};
	}, [currentPage]);

	return (
		<frame
			Key="BottomNavbar"
			Size={UDim2.fromOffset(400, 56)}
			Position={new UDim2(0.5, 0, 1, navbarYOffset)} // Position Y animée avec spring
			AnchorPoint={new Vector2(0.5, 1)}
			BackgroundColor3={theme.colors.surface}
			BackgroundTransparency={0.05}
			BorderSizePixel={0}
			ZIndex={100}
		>
			<uicorner CornerRadius={new UDim(0, 12)} />

			{/* Gradient border */}
			<uistroke Color={getAccentColor()} Thickness={1.5} Transparency={0.3}>
				<uigradient
					Color={new ColorSequence([
						new ColorSequenceKeypoint(0, theme.gradients.primary[0]),
						new ColorSequenceKeypoint(0.5, theme.colors.primaryVariant),
						new ColorSequenceKeypoint(1, theme.gradients.primary[1]),
					])}
					Rotation={90}
				/>
			</uistroke>

			{/* Glow underglow */}
			<frame
				Size={new UDim2(1, 60, 0, 80)}
				Position={UDim2.fromOffset(-30, -20)}
				BackgroundColor3={getAccentColor()}
				BackgroundTransparency={0.85}
				BorderSizePixel={0}
				ZIndex={-1}
			>
				<uigradient
					Color={new ColorSequence([
						new ColorSequenceKeypoint(0, theme.gradients.primary[0]),
						new ColorSequenceKeypoint(1, theme.gradients.primary[1]),
					])}
					Transparency={new NumberSequence([
						new NumberSequenceKeypoint(0, 0.85),
						new NumberSequenceKeypoint(1, 1),
					])}
					Rotation={0}
				/>
				<uicorner CornerRadius={new UDim(0, 16)} />
			</frame>

			{/* Active indicator bar (animated) - POSITION ABSOLUE PIXEL-PERFECT */}
			<frame
				Size={UDim2.fromOffset(100, 4)}
				Position={UDim2.fromOffset(indicatorPosition, 52)} // Position X animée en pixels + Y=52 pour être en bas
				AnchorPoint={new Vector2(0, 0)}
				BackgroundColor3={getAccentColor()}
				BorderSizePixel={0}
				ZIndex={3}
			>
				<uicorner CornerRadius={new UDim(1, 0)} />
				<uigradient
					Color={new ColorSequence([
						new ColorSequenceKeypoint(0, theme.gradients.primary[0]),
						new ColorSequenceKeypoint(0.5, theme.colors.primaryVariant),
						new ColorSequenceKeypoint(1, theme.gradients.primary[1]),
					])}
					Rotation={0}
				/>
			</frame>

			{/* Tabs container */}
			<frame
				Size={UDim2.fromScale(1, 1)}
				BackgroundTransparency={1}
			>
				<uilistlayout
					FillDirection={Enum.FillDirection.Horizontal}
					HorizontalAlignment={Enum.HorizontalAlignment.Center}
					VerticalAlignment={Enum.VerticalAlignment.Center}
					Padding={new UDim(0, 0)}
				/>

				{NAV_TABS.map((tab) => {
					const isActive = currentPage === tab.id;
					const isHovered = hoveredTab === tab.id;

					return (
						<textbutton
							Key={tab.id}
							Size={UDim2.fromOffset(100, 56)}
							BackgroundColor3={isActive ? getAccentColor() : theme.colors.surface}
							BackgroundTransparency={isActive ? 0.85 : isHovered ? 0.9 : 1}
							BorderSizePixel={0}
							Text=""
							Event={{
								MouseButton1Click: () => onPageChange(tab.id),
								MouseEnter: () => setHoveredTab(tab.id),
								MouseLeave: () => setHoveredTab(undefined),
							}}
						>
							<uicorner CornerRadius={new UDim(0, 8)} />

							{/* Icon - ImageLabel avec logo blanc */}
							<imagelabel
								Image={tab.icon}
								Size={UDim2.fromOffset(24, 24)}
								Position={UDim2.fromScale(0.5, 0.3)}
								AnchorPoint={new Vector2(0.5, 0.5)}
								BackgroundTransparency={1}
								ImageColor3={isActive ? getAccentColor() : Color3.fromRGB(255, 255, 255)}
								ImageTransparency={isActive ? 0 : isHovered ? 0.2 : 0.4}
							/>

							{/* Label */}
							<textlabel
								Size={new UDim2(1, 0, 0, 16)}
								Position={UDim2.fromScale(0.5, 0.75)}
								AnchorPoint={new Vector2(0.5, 0.5)}
								BackgroundTransparency={1}
								Text={tab.label}
								Font={isActive ? Enum.Font.GothamBold : Enum.Font.Gotham}
								TextSize={11}
								TextColor3={isActive ? getAccentColor() : theme.colors.textSecondary}
								TextTransparency={isActive ? 0 : isHovered ? 0.3 : 0.5}
							/>

							{/* Active glow */}
							{isActive && (
								<frame
									Size={UDim2.fromScale(1, 1)}
									BackgroundColor3={getAccentColor()}
									BackgroundTransparency={0.92}
									BorderSizePixel={0}
									ZIndex={-1}
								>
									<uicorner CornerRadius={new UDim(0, 8)} />
								</frame>
							)}
						</textbutton>
					);
				})}
			</frame>
		</frame>
	);
});

export default BottomNavbar;
