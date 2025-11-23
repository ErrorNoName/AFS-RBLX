import Roact from "@rbxts/roact";
import { hooked, useEffect, useState } from "@rbxts/roact-hooked";
import { TweenService } from "@rbxts/services";
import { Theme } from "../types";

interface SplashScreenProps {
	theme: Theme;
	onComplete: () => void;
}

/**
 * Splash Screen avec animation fade-in/out et progress bar
 * Style Orca moderne avec gradient Sorbet
 */
const SplashScreen = hooked<SplashScreenProps>((props) => {
	const { theme, onComplete } = props;
	const [progress, setProgress] = useState(0);
	const [isVisible, setIsVisible] = useState(true);

	useEffect(() => {
		// Animation de chargement (0% → 100% en 1.5s)
		const startTime = tick();
		const duration = 1.5;

		const connection = game.GetService("RunService").RenderStepped.Connect(() => {
			const elapsed = tick() - startTime;
			const currentProgress = math.min(elapsed / duration, 1);
			setProgress(currentProgress);

			// Fin du chargement à 100%
			if (currentProgress >= 1) {
				wait(0.3); // Pause à 100%
				setIsVisible(false);
				
				// Fade out puis callback
				wait(0.5);
				onComplete();
			}
		});

		return () => {
			connection.Disconnect();
		};
	}, []);

	if (!isVisible) {
		return <></>;
	}

	// Calculer la couleur du gradient en fonction du progress
	const getProgressColor = () => {
		if (progress < 0.5) {
			// Rose → Violet
			return theme.colors.primary.Lerp(theme.colors.primaryVariant, progress * 2);
		} else {
			// Violet → Bleu
			return theme.colors.primaryVariant.Lerp(theme.colors.secondary, (progress - 0.5) * 2);
		}
	};

	return (
		<frame
			Key="SplashScreen"
			Size={UDim2.fromScale(1, 1)}
			BackgroundColor3={theme.colors.background}
			BorderSizePixel={0}
			ZIndex={1000}
		>
			{/* Gradient background */}
			<uigradient
				Color={new ColorSequence([
					new ColorSequenceKeypoint(0, theme.gradients.primary[0]),
					new ColorSequenceKeypoint(1, theme.gradients.primary[1]),
				])}
				Rotation={135}
				Transparency={new NumberSequence([new NumberSequenceKeypoint(0, 0.85), new NumberSequenceKeypoint(1, 0.95)])}
			/>

			{/* Logo container */}
			<frame
				Size={UDim2.fromOffset(480, 320)}
				Position={UDim2.fromScale(0.5, 0.45)}
				AnchorPoint={new Vector2(0.5, 0.5)}
				BackgroundColor3={theme.colors.surface}
				BackgroundTransparency={0.05}
				BorderSizePixel={0}
			>
				<uicorner CornerRadius={new UDim(0, 24)} />

				{/* Gradient border */}
				<uistroke
					Color={getProgressColor()}
					Thickness={2}
					Transparency={0.3}
				>
					<uigradient
						Color={new ColorSequence([
							new ColorSequenceKeypoint(0, theme.gradients.primary[0]),
							new ColorSequenceKeypoint(0.5, theme.colors.primaryVariant),
							new ColorSequenceKeypoint(1, theme.gradients.primary[1]),
						])}
						Rotation={45}
					/>
				</uistroke>

				{/* Glow effect */}
				<imagelabel
					Size={new UDim2(1, 80, 1, 80)}
					Position={UDim2.fromOffset(-40, -40)}
					BackgroundTransparency={1}
					Image="rbxasset://textures/ui/GuiImagePlaceholder.png"
					ImageColor3={getProgressColor()}
					ImageTransparency={0.7}
					ZIndex={-1}
				>
					<uigradient
						Color={new ColorSequence(getProgressColor())}
						Transparency={new NumberSequence([new NumberSequenceKeypoint(0, 0.9), new NumberSequenceKeypoint(1, 1)])}
					/>
				</imagelabel>

				{/* Logo text */}
				<textlabel
					Size={new UDim2(1, -80, 0, 80)}
					Position={UDim2.fromOffset(40, 40)}
					BackgroundTransparency={1}
					Text="SriBlox"
					Font={Enum.Font.GothamBold}
					TextSize={56}
					TextColor3={Color3.fromRGB(255, 255, 255)}
					TextXAlignment={Enum.TextXAlignment.Left}
				>
					<uigradient
						Color={new ColorSequence([
							new ColorSequenceKeypoint(0, theme.gradients.primary[0]),
							new ColorSequenceKeypoint(0.5, theme.colors.primaryVariant),
							new ColorSequenceKeypoint(1, theme.gradients.primary[1]),
						])}
						Rotation={0}
					/>
				</textlabel>

				{/* Subtitle */}
				<textlabel
					Size={new UDim2(1, -80, 0, 32)}
					Position={UDim2.fromOffset(40, 130)}
					BackgroundTransparency={1}
					Text="Modern Script Hub"
					Font={Enum.Font.Gotham}
					TextSize={20}
					TextColor3={theme.colors.textSecondary}
					TextXAlignment={Enum.TextXAlignment.Left}
				/>

				{/* Loading text */}
				<textlabel
					Size={new UDim2(1, -80, 0, 24)}
					Position={UDim2.fromOffset(40, 180)}
					BackgroundTransparency={1}
					Text={`Loading... ${math.floor(progress * 100)}%`}
					Font={Enum.Font.GothamMedium}
					TextSize={16}
					TextColor3={theme.colors.text}
					TextXAlignment={Enum.TextXAlignment.Left}
				/>

				{/* Progress bar background */}
				<frame
					Size={new UDim2(1, -80, 0, 6)}
					Position={UDim2.fromOffset(40, 220)}
					BackgroundColor3={theme.colors.outline}
					BackgroundTransparency={0.3}
					BorderSizePixel={0}
				>
					<uicorner CornerRadius={new UDim(1, 0)} />

					{/* Progress bar fill */}
					<frame
						Size={UDim2.fromScale(progress, 1)}
						BackgroundColor3={getProgressColor()}
						BorderSizePixel={0}
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
				</frame>

				{/* Version badge */}
				<frame
					Size={UDim2.fromOffset(80, 28)}
					Position={new UDim2(1, -120, 1, -68)}
					BackgroundColor3={getProgressColor()}
					BackgroundTransparency={0.1}
					BorderSizePixel={0}
				>
					<uicorner CornerRadius={new UDim(0, 8)} />

					<textlabel
						Size={UDim2.fromScale(1, 1)}
						BackgroundTransparency={1}
						Text="v2.0"
						Font={Enum.Font.GothamBold}
						TextSize={14}
						TextColor3={Color3.fromRGB(255, 255, 255)}
					/>
				</frame>
			</frame>

			{/* Powered by text */}
			<textlabel
				Size={UDim2.fromOffset(300, 24)}
				Position={new UDim2(0.5, 0, 1, -40)}
				AnchorPoint={new Vector2(0.5, 0)}
				BackgroundTransparency={1}
				Text="Powered by ScriptBlox API"
				Font={Enum.Font.Gotham}
				TextSize={13}
				TextColor3={theme.colors.textSecondary}
				TextTransparency={0.4}
			/>
		</frame>
	);
});

export default SplashScreen;
