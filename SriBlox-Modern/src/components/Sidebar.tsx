import Roact from "@rbxts/roact";
import { hooked, useState } from "@rbxts/roact-hooked";
import { Theme } from "../types";

interface SidebarProps {
	theme: Theme;
	isOpen: boolean;
	onClose: () => void;
}

interface NavButtonProps {
	icon: string;
	label: string;
	isActive?: boolean;
	onClick: () => void;
	theme: Theme;
}

const NavButton = hooked<NavButtonProps>((props) => {
	const [isHovered, setIsHovered] = useState(false);

	return (
		<textbutton
			Size={new UDim2(1, -16, 0, 48)}
			Position={new UDim2(0, 8, 0, 0)}
			BackgroundColor3={
				props.isActive
					? props.theme.colors.primary
					: isHovered
					? props.theme.colors.surfaceVariant
					: Color3.fromRGB(0, 0, 0)
			}
			BackgroundTransparency={props.isActive ? 0.7 : isHovered ? 0.9 : 1}
			BorderSizePixel={0}
			Text=""
			Event={{
				MouseEnter: () => setIsHovered(true),
				MouseLeave: () => setIsHovered(false),
				MouseButton1Click: props.onClick,
			}}
		>
			<uicorner CornerRadius={new UDim(0, 12)} />

			<textlabel
				Size={new UDim2(0, 32, 0, 32)}
				Position={new UDim2(0, 12, 0.5, 0)}
				AnchorPoint={new Vector2(0, 0.5)}
				BackgroundTransparency={1}
				Text={props.icon}
				TextColor3={props.isActive ? props.theme.colors.primary : props.theme.colors.text}
				Font={Enum.Font.GothamBold}
				TextSize={24}
			/>

			<textlabel
				Size={new UDim2(1, -56, 1, 0)}
				Position={new UDim2(0, 52, 0, 0)}
				BackgroundTransparency={1}
				Text={props.label}
				TextColor3={props.isActive ? props.theme.colors.primary : props.theme.colors.text}
				Font={props.isActive ? Enum.Font.GothamBold : Enum.Font.Gotham}
				TextSize={15}
				TextXAlignment={Enum.TextXAlignment.Left}
			/>
		</textbutton>
	);
});

export const Sidebar = hooked<SidebarProps>((props) => {
	const [currentPage, setCurrentPage] = useState("Scripts");

	return (
		<frame
			Size={new UDim2(0, 240, 1, 0)}
			Position={new UDim2(0, props.isOpen ? 0 : -240, 0, 0)}
			BackgroundColor3={props.theme.colors.background}
			BackgroundTransparency={0.05}
			BorderSizePixel={0}
		>
			{/* Header */}
			<frame Size={new UDim2(1, 0, 0, 80)} BackgroundTransparency={1}>
				<textlabel
					Size={new UDim2(1, -48, 0, 36)}
					Position={new UDim2(0, 16, 0, 22)}
					BackgroundTransparency={1}
					Text="SriBlox"
					TextColor3={props.theme.colors.text}
					Font={Enum.Font.GothamBold}
					TextSize={28}
					TextXAlignment={Enum.TextXAlignment.Left}
				>
					<uigradient
						Color={
							new ColorSequence([
								new ColorSequenceKeypoint(0, props.theme.colors.primary),
								new ColorSequenceKeypoint(1, props.theme.colors.accent),
							])
						}
					/>
				</textlabel>

				<textbutton
					Size={new UDim2(0, 32, 0, 32)}
					Position={new UDim2(1, -44, 0, 24)}
					BackgroundColor3={props.theme.colors.error}
					BackgroundTransparency={0.8}
					Text="×"
					TextColor3={props.theme.colors.error}
					Font={Enum.Font.GothamBold}
					TextSize={28}
					Event={{
						MouseButton1Click: props.onClose,
					}}
				>
					<uicorner CornerRadius={new UDim(0, 8)} />
				</textbutton>
			</frame>

			{/* Navigation */}
			<scrollingframe
				Size={new UDim2(1, 0, 1, -80)}
				Position={new UDim2(0, 0, 0, 80)}
				BackgroundTransparency={1}
				BorderSizePixel={0}
				ScrollBarThickness={4}
				ScrollBarImageColor3={props.theme.colors.primary}
				CanvasSize={new UDim2(0, 0, 0, 300)}
			>
				<uilistlayout Padding={new UDim(0, 8)} SortOrder={Enum.SortOrder.LayoutOrder} />

				<NavButton
					icon="🔍"
					label="Scripts"
					isActive={currentPage === "Scripts"}
					onClick={() => setCurrentPage("Scripts")}
					theme={props.theme}
				/>

				<NavButton
					icon="⭐"
					label="Favorites"
					isActive={currentPage === "Favorites"}
					onClick={() => setCurrentPage("Favorites")}
					theme={props.theme}
				/>

				<NavButton
					icon="📜"
					label="History"
					isActive={currentPage === "History"}
					onClick={() => setCurrentPage("History")}
					theme={props.theme}
				/>

				<NavButton
					icon="⚙️"
					label="Settings"
					isActive={currentPage === "Settings"}
					onClick={() => setCurrentPage("Settings")}
					theme={props.theme}
				/>
			</scrollingframe>

			{/* Divider */}
			<frame
				Size={new UDim2(0, 2, 1, 0)}
				Position={new UDim2(1, 0, 0, 0)}
				BackgroundColor3={props.theme.colors.border}
				BackgroundTransparency={0.7}
				BorderSizePixel={0}
			>
				<uigradient
					Color={
						new ColorSequence([
							new ColorSequenceKeypoint(0, props.theme.colors.primary),
							new ColorSequenceKeypoint(0.5, props.theme.colors.accent),
							new ColorSequenceKeypoint(1, props.theme.colors.primary),
						])
					}
					Rotation={90}
					Transparency={new NumberSequence([new NumberSequenceKeypoint(0, 0.9), new NumberSequenceKeypoint(0.5, 0.3), new NumberSequenceKeypoint(1, 0.9)])}
				/>
			</frame>
		</frame>
	);
});
