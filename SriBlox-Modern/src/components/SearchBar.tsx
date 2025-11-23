import Roact from "@rbxts/roact";
import { hooked, useState, useEffect, useMemo } from "@rbxts/roact-hooked";
import { SingleMotor, Spring } from "@rbxts/flipper";
import { Theme } from "../types";

interface SearchBarProps {
	theme: Theme;
	placeholder: string;
	onSearch: (query: string) => void;
	onSettingsClick: () => void;
}

/**
 * Barre de recherche moderne avec animations Flipper
 * - Focus effects avec transitions fluides
 * - Icon animÃ©e
 * - Bouton paramÃ¨tres intÃ©grÃ©
 */
export const SearchBar = hooked<SearchBarProps>((props) => {
	const { theme, onSearch, onSettingsClick, placeholder } = props;
	
	const [query, setQuery] = useState("");
	const [focused, setFocused] = useState(false);
	
	// Motors pour animations fluides
	const borderColorMotor = useMemo(() => new SingleMotor(0), []);
	const scaleMotor = useMemo(() => new SingleMotor(1), []);
	const glowMotor = useMemo(() => new SingleMotor(0), []);
	
	const [borderProgress, setBorderProgress] = useState(0);
	const [scale, setScale] = useState(1);
	const [glowIntensity, setGlowIntensity] = useState(0);

	// Animation au focus
	useEffect(() => {
		borderColorMotor.onStep(setBorderProgress);
		scaleMotor.onStep(setScale);
		glowMotor.onStep(setGlowIntensity);

		if (focused) {
			borderColorMotor.setGoal(new Spring(1, { frequency: 3, dampingRatio: 0.8 }));
			scaleMotor.setGoal(new Spring(1.02, { frequency: 4 }));
			glowMotor.setGoal(new Spring(1, { frequency: 3 }));
		} else {
			borderColorMotor.setGoal(new Spring(0, { frequency: 3 }));
			scaleMotor.setGoal(new Spring(1, { frequency: 4 }));
			glowMotor.setGoal(new Spring(0, { frequency: 3 }));
		}

		return () => {
			borderColorMotor.destroy();
			scaleMotor.destroy();
			glowMotor.destroy();
		};
	}, [focused]);

	// Interpoler les couleurs
	const borderColor = theme.colors.border.Lerp(theme.colors.primary, borderProgress);
	const iconColor = theme.colors.textSecondary.Lerp(theme.colors.primary, borderProgress);

	return (
		<frame
			Size={new UDim2(0, 560, 0, 48)}
			Position={UDim2.fromScale(0.5, 0.12)}
			AnchorPoint={new Vector2(0.5, 0)}
			BackgroundColor3={theme.colors.surface}
			BackgroundTransparency={0.1}
			BorderSizePixel={0}
		>
			<uicorner CornerRadius={new UDim(0, 14)} />
			
			{/* Border animÃ©e */}
			<uistroke
				Color={borderColor}
				Thickness={2}
				Transparency={0.2}
			/>

			{/* Glow effect au focus */}
			

			{/* Shadow subtile */}
			<uistroke
				Color={Color3.fromRGB(0, 0, 0)}
				Thickness={1}
				Transparency={0.9}
				ApplyStrokeMode={Enum.ApplyStrokeMode.Border}
			/>

			{/* Icon de recherche animÃ©e */}
			<imagelabel
				Size={new UDim2(0, 24, 0, 24)}
				Position={new UDim2(0, 16, 0.5, 0)}
				AnchorPoint={new Vector2(0, 0.5)}
				BackgroundTransparency={1}
				Image="rbxassetid://7733960981"
				ImageColor3={iconColor}
				ImageTransparency={0}
			/>

			{/* TextBox de recherche */}
			<textbox
				Size={new UDim2(1, -100, 1, -12)}
				Position={new UDim2(0, 50, 0, 6)}
				BackgroundTransparency={1}
				Text={query}
				PlaceholderText="Search ScriptBlox scripts..."
				PlaceholderColor3={theme.colors.textSecondary}
				TextColor3={theme.colors.text}
				Font={Enum.Font.GothamSemibold}
				TextSize={18}
				TextXAlignment={Enum.TextXAlignment.Left}
				ClearTextOnFocus={false}
				Event={{
					Focused: () => setFocused(true),
					FocusLost: (rbx, enterPressed) => {
						setFocused(false);
						if (enterPressed && query.size() > 0) {
							onSearch(query);
						}
					},
				}}
				Change={{
					Text: (rbx) => setQuery(rbx.Text),
				}}
			/>

			{/* Bouton paramÃ¨tres moderne */}
			<textbutton
				Size={new UDim2(0, 36, 0, 36)}
				Position={new UDim2(1, -44, 0.5, 0)}
				AnchorPoint={new Vector2(0, 0.5)}
				BackgroundColor3={theme.colors.surfaceVariant}
				BackgroundTransparency={0}
			Text="âš™"
			TextColor3={theme.colors.primary}
			TextSize={20}
			Font={Enum.Font.GothamBold}
			AutoButtonColor={false}
			Event={{
				MouseButton1Click: onSettingsClick,
					MouseEnter: (rbx) => {
						// Hover effect
						const tween = game.GetService("TweenService").Create(
							rbx,
							new TweenInfo(0.2, Enum.EasingStyle.Quint),
							{ BackgroundColor3: theme.colors.primary }
						);
						tween.Play();
					},
					MouseLeave: (rbx) => {
						const tween = game.GetService("TweenService").Create(
							rbx,
							new TweenInfo(0.2, Enum.EasingStyle.Quint),
							{ BackgroundColor3: theme.colors.surfaceVariant }
						);
						tween.Play();
					},
				}}
			>
				<uicorner CornerRadius={new UDim(0, 10)} />
			</textbutton>
		</frame>
	);
});
