import Roact from "@rbxts/roact";
import { hooked } from "@rbxts/roact-hooked";
import { Theme } from "../types";

interface TopBarProps {
	theme: Theme;
	onMenuToggle: () => void;
}

export const TopBar = hooked<TopBarProps>((props) => {
	return (
		<frame
			Size={new UDim2(1, 0, 0, 64)}
			BackgroundColor3={props.theme.colors.surface}
			BackgroundTransparency={0.3}
			BorderSizePixel={0}
		>
			{/* Blur effect */}
			<frame
				Size={UDim2.fromScale(1, 1)}
				BackgroundColor3={props.theme.colors.background}
				BackgroundTransparency={0.2}
				BorderSizePixel={0}
				ZIndex={-1}
			>
				<uigradient
					Transparency={
						new NumberSequence([new NumberSequenceKeypoint(0, 0.7), new NumberSequenceKeypoint(1, 0.9)])
					}
					Rotation={90}
				/>
			</frame>

			{/* Menu button */}
			<textbutton
				Size={new UDim2(0, 48, 0, 48)}
				Position={new UDim2(0, 8, 0.5, 0)}
				AnchorPoint={new Vector2(0, 0.5)}
				BackgroundColor3={props.theme.colors.primary}
				BackgroundTransparency={0.85}
				Text="☰"
				TextColor3={props.theme.colors.primary}
				Font={Enum.Font.GothamBold}
				TextSize={24}
				Event={{
					MouseButton1Click: props.onMenuToggle,
				}}
			>
				<uicorner CornerRadius={new UDim(0, 12)} />
			</textbutton>

			{/* Title */}
			<textlabel
				Size={new UDim2(0, 200, 0, 32)}
				Position={new UDim2(0, 64, 0.5, 0)}
				AnchorPoint={new Vector2(0, 0.5)}
				BackgroundTransparency={1}
				Text="SriBlox Modern"
				TextColor3={props.theme.colors.text}
				Font={Enum.Font.GothamBold}
				TextSize={20}
				TextXAlignment={Enum.TextXAlignment.Left}
			/>

			{/* Version badge */}
			<frame
				Size={new UDim2(0, 60, 0, 24)}
				Position={new UDim2(0, 270, 0.5, 0)}
				AnchorPoint={new Vector2(0, 0.5)}
				BackgroundColor3={props.theme.colors.accent}
				BackgroundTransparency={0.85}
				BorderSizePixel={0}
			>
				<uicorner CornerRadius={new UDim(0, 6)} />
				<textlabel
					Size={UDim2.fromScale(1, 1)}
					BackgroundTransparency={1}
					Text="v2.0"
					TextColor3={props.theme.colors.accent}
					Font={Enum.Font.GothamBold}
					TextSize={12}
				/>
			</frame>

			{/* Bottom border */}
			<frame
				Size={new UDim2(1, 0, 0, 2)}
				Position={new UDim2(0, 0, 1, 0)}
				BackgroundColor3={props.theme.colors.border}
				BackgroundTransparency={0.5}
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
					Transparency={new NumberSequence([new NumberSequenceKeypoint(0, 0.9), new NumberSequenceKeypoint(0.5, 0.3), new NumberSequenceKeypoint(1, 0.9)])}
				/>
			</frame>
		</frame>
	);
});
