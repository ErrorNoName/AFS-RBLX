import Roact from "@rbxts/roact";
import { hooked } from "@rbxts/roact-hooked";

interface AcrylicProps {
	transparency?: number;
	blurSize?: number;
	tintColor?: Color3;
	tintTransparency?: number;
	children?: Roact.Element | Roact.Element[];
}

/**
 * Composant Acrylic - Effet de flou backdrop moderne (style Windows 11 / macOS)
 * Crée un fond semi-transparent avec effet de flou pour un look premium
 */
export const Acrylic = hooked<AcrylicProps>((props) => {
	const {
		transparency = 0.3,
		blurSize = 24,
		tintColor = Color3.fromRGB(20, 23, 35),
		tintTransparency = 0.4,
		children,
	} = props;

	// Version simplifiée - affiche directement les children sans layers complexes
	return (
		<frame
			Size={UDim2.fromScale(1, 1)}
			BackgroundColor3={tintColor}
			BackgroundTransparency={tintTransparency}
			BorderSizePixel={0}
		>
			{children}
		</frame>
	);
});
