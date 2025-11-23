import Roact from "@rbxts/roact";
import { hooked, useState } from "@rbxts/roact-hooked";
import { Theme, Script } from "../types";

interface ScriptCardProps {
	scriptData: Script;
	theme: Theme;
	index: number;
}

export const ScriptCard = hooked<ScriptCardProps>((props) => {
	const [isHovered, setIsHovered] = useState(false);
	const [isPressed, setIsPressed] = useState(false);

	const handleRun = () => {
		const scriptUrl = `https://scriptblox.com/raw/${props.scriptData.slug}`;
		print(`[SriBlox] Executing script: ${props.scriptData.title}`);
		
		// Use getfenv to access executor globals
		const env = getfenv(0) as unknown as { loadstring?: unknown; [key: string]: unknown };
		const gameAny = game as unknown as { HttpGet?: unknown; [key: string]: unknown };
		
		const success = pcall(() => {
			const load = env.loadstring;
			const httpGet = gameAny.HttpGet;
			if (load !== undefined && httpGet !== undefined) {
				((load as (code: string) => (() => void))((httpGet as (game: unknown, url: string) => string)(game, scriptUrl)))();
			}
		});

		if (success[0]) {
			print(`[SriBlox] ✓ Script executed successfully`);
		} else {
			warn(`[SriBlox] ✗ Failed to execute: ${success[1]}`);
		}
	};

	const handleCopy = () => {
		const scriptUrl = `https://scriptblox.com/raw/${props.scriptData.slug}`;
		const env = getfenv(0) as unknown as { setclipboard?: unknown; [key: string]: unknown };
		const clipboard = env.setclipboard;
		if (clipboard !== undefined) {
			((clipboard as (text: string) => void)(scriptUrl));
		}
		print(`[SriBlox] Copied to clipboard: ${scriptUrl}`);
	};

	// Calculate card scale based on hover/press state
	const cardScale = isHovered && !isPressed ? 1.05 : 1.0;
	const shadowTransparency = isHovered ? 0.6 : 0.85;

	return (
		<frame
			Size={new UDim2(0, 280, 0, 180)}
			BackgroundTransparency={1}
			LayoutOrder={props.index}
		>
			{/* Shadow/Glow effect */}
			<frame
				Size={new UDim2(cardScale, 12, cardScale, 12)}
				Position={UDim2.fromScale(0.5, 0.5)}
				AnchorPoint={new Vector2(0.5, 0.5)}
				BackgroundColor3={props.theme.colors.primary}
				BackgroundTransparency={shadowTransparency}
				BorderSizePixel={0}
				ZIndex={0}
			>
				<uicorner CornerRadius={new UDim(0, 18)} />
				<uigradient
					Color={
						new ColorSequence([
							new ColorSequenceKeypoint(0, props.theme.colors.primary),
							new ColorSequenceKeypoint(1, props.theme.colors.accent),
						])
					}
					Rotation={45}
				/>
			</frame>

			{/* Main card */}
			<frame
				Size={new UDim2(cardScale, 0, cardScale, 0)}
				Position={UDim2.fromScale(0.5, 0.5)}
				AnchorPoint={new Vector2(0.5, 0.5)}
				BackgroundColor3={props.theme.colors.surface}
				BackgroundTransparency={0.1}
				BorderSizePixel={0}
			>
				<uicorner CornerRadius={new UDim(0, 16)} />

				{/* Card gradient background */}
				<frame
					Size={UDim2.fromScale(1, 1)}
					BackgroundTransparency={1}
					BorderSizePixel={0}
					ZIndex={1}
				>
					<uigradient
						Color={
							new ColorSequence([
								new ColorSequenceKeypoint(0, props.theme.colors.surface),
								new ColorSequenceKeypoint(1, props.theme.colors.surfaceVariant),
							])
						}
						Rotation={135}
					/>
				</frame>

				{/* Shine effect on hover */}
				{isHovered && (
					<frame
						Size={UDim2.fromScale(1, 1)}
						BackgroundColor3={Color3.fromRGB(255, 255, 255)}
						BackgroundTransparency={0.92}
						BorderSizePixel={0}
						ZIndex={2}
					>
						<uicorner CornerRadius={new UDim(0, 16)} />
						<uigradient
							Transparency={
								new NumberSequence([new NumberSequenceKeypoint(0, 0.7), new NumberSequenceKeypoint(1, 1)])
							}
							Offset={new Vector2(-0.5, -0.5)}
							Rotation={45}
						/>
					</frame>
				)}

				{/* Border highlight on hover */}
				<uistroke
					Color={isHovered ? props.theme.colors.primary : props.theme.colors.border}
					Thickness={isHovered ? 2 : 1}
					Transparency={isHovered ? 0.3 : 0.7}
				>
					<uigradient
						Color={
							new ColorSequence([
								new ColorSequenceKeypoint(0, props.theme.colors.primary),
								new ColorSequenceKeypoint(0.5, props.theme.colors.accent),
								new ColorSequenceKeypoint(1, props.theme.colors.primary),
							])
						}
						Rotation={45}
					/>
				</uistroke>

				{/* Content */}
				<frame Size={UDim2.fromScale(1, 1)} BackgroundTransparency={1} ZIndex={3}>
					{/* Game badge */}
					<frame
						Size={new UDim2(0, 120, 0, 24)}
						Position={new UDim2(0, 12, 0, 12)}
						BackgroundColor3={props.theme.colors.primary}
						BackgroundTransparency={0.85}
						BorderSizePixel={0}
					>
						<uicorner CornerRadius={new UDim(0, 6)} />
						<textlabel
							Size={UDim2.fromScale(1, 1)}
							BackgroundTransparency={1}
							Text={props.scriptData.game?.name || "Universal"}
							TextColor3={props.theme.colors.primary}
							Font={Enum.Font.GothamBold}
							TextSize={11}
							TextTruncate={Enum.TextTruncate.AtEnd}
						/>
					</frame>

					{/* Title */}
					<textlabel
						Size={new UDim2(1, -24, 0, 60)}
						Position={new UDim2(0, 12, 0, 46)}
						BackgroundTransparency={1}
						Text={props.scriptData.title}
						TextColor3={props.theme.colors.text}
						Font={Enum.Font.GothamBold}
						TextSize={16}
						TextXAlignment={Enum.TextXAlignment.Left}
						TextYAlignment={Enum.TextYAlignment.Top}
						TextWrapped={true}
						TextTruncate={Enum.TextTruncate.AtEnd}
					/>

					{/* Stats */}
					<frame
						Size={new UDim2(1, -24, 0, 20)}
						Position={new UDim2(0, 12, 0, 110)}
						BackgroundTransparency={1}
					>
						<textlabel
							Size={new UDim2(0.5, -4, 1, 0)}
							BackgroundTransparency={1}
							Text={`👁️ ${props.scriptData.views || 0}`}
							TextColor3={props.theme.colors.textSecondary}
							Font={Enum.Font.Gotham}
							TextSize={12}
							TextXAlignment={Enum.TextXAlignment.Left}
						/>

						<textlabel
							Size={new UDim2(0.5, -4, 1, 0)}
							Position={new UDim2(0.5, 4, 0, 0)}
							BackgroundTransparency={1}
							Text={`⭐ ${(props.scriptData as any).likeCount || 0}`}
							TextColor3={props.theme.colors.textSecondary}
							Font={Enum.Font.Gotham}
							TextSize={12}
							TextXAlignment={Enum.TextXAlignment.Left}
						/>
					</frame>

					{/* Action buttons */}
					<frame
						Size={new UDim2(1, -24, 0, 32)}
						Position={new UDim2(0, 12, 1, -44)}
						BackgroundTransparency={1}
					>
						<textbutton
							Size={new UDim2(0.6, -4, 1, 0)}
							BackgroundColor3={props.theme.colors.primary}
							BackgroundTransparency={0.2}
							Text="▶ Run"
							TextColor3={props.theme.colors.onPrimary}
							Font={Enum.Font.GothamBold}
							TextSize={14}
							Event={{
								MouseButton1Click: handleRun,
							}}
						>
							<uicorner CornerRadius={new UDim(0, 8)} />
						</textbutton>

						<textbutton
							Size={new UDim2(0.4, -4, 1, 0)}
							Position={new UDim2(0.6, 4, 0, 0)}
							BackgroundColor3={props.theme.colors.surfaceVariant}
							BackgroundTransparency={0.3}
							Text="📋"
							TextColor3={props.theme.colors.text}
							Font={Enum.Font.GothamBold}
							TextSize={16}
							Event={{
								MouseButton1Click: handleCopy,
							}}
						>
							<uicorner CornerRadius={new UDim(0, 8)} />
						</textbutton>
					</frame>
				</frame>

				{/* Invisible button for hover detection */}
				<textbutton
					Size={UDim2.fromScale(1, 1)}
					BackgroundTransparency={1}
					Text=""
					ZIndex={10}
					Event={{
						MouseEnter: () => setIsHovered(true),
						MouseLeave: () => {
							setIsHovered(false);
							setIsPressed(false);
						},
						MouseButton1Down: () => setIsPressed(true),
						MouseButton1Up: () => setIsPressed(false),
					}}
				/>
			</frame>
		</frame>
	);
});
