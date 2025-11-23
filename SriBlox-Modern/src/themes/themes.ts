import { Theme } from "../types";

// Thème Sorbet (Orca original) - Gradient Rose/Violet/Bleu pastel
export const sorbetTheme: Theme = {
	name: "Sorbet",
	colors: {
		background: Color3.fromRGB(24, 24, 24), // #181818
		surface: Color3.fromRGB(36, 36, 36), // #242424
		surfaceVariant: Color3.fromRGB(42, 42, 46),
		primary: Color3.fromRGB(198, 66, 142), // #C6428E - Rose vif
		primaryVariant: Color3.fromRGB(154, 63, 229), // #9a3fe5 - Violet
		secondary: Color3.fromRGB(72, 79, 215), // #484fd7 - Bleu
		accent: Color3.fromRGB(154, 63, 229), // Violet mix
		text: Color3.fromRGB(255, 255, 255),
		textSecondary: Color3.fromRGB(180, 180, 200),
		success: Color3.fromRGB(72, 220, 140),
		warning: Color3.fromRGB(255, 196, 0),
		error: Color3.fromRGB(255, 92, 110),
		border: Color3.fromRGB(198, 66, 142),
		borderLight: Color3.fromRGB(154, 63, 229),
		outline: Color3.fromRGB(60, 60, 70),
		onSurface: Color3.fromRGB(255, 255, 255),
		onSurfaceVariant: Color3.fromRGB(220, 220, 240),
		onPrimary: Color3.fromRGB(255, 255, 255),
		onSecondary: Color3.fromRGB(255, 255, 255),
	},
	gradients: {
		primary: [Color3.fromRGB(198, 66, 142), Color3.fromRGB(72, 79, 215)], // Rose → Bleu
		card: [Color3.fromRGB(36, 36, 36), Color3.fromRGB(42, 42, 46)],
		accent: [Color3.fromRGB(198, 66, 142), Color3.fromRGB(154, 63, 229)], // Rose → Violet
	},
	blur: {
		enabled: true,
		intensity: 28,
	},
};

// Thème Sombre Moderne (Style Orca avec gradients)
export const darkTheme: Theme = {
	name: "Dark",
	colors: {
		background: Color3.fromRGB(12, 14, 22),
		surface: Color3.fromRGB(20, 23, 35),
		surfaceVariant: Color3.fromRGB(28, 32, 45),
		primary: Color3.fromRGB(88, 134, 255),
		primaryVariant: Color3.fromRGB(65, 105, 225),
		secondary: Color3.fromRGB(120, 140, 255),
		accent: Color3.fromRGB(138, 180, 255),
		text: Color3.fromRGB(235, 238, 250),
		textSecondary: Color3.fromRGB(160, 170, 200),
		success: Color3.fromRGB(72, 220, 140),
		warning: Color3.fromRGB(255, 184, 72),
		error: Color3.fromRGB(255, 92, 110),
		border: Color3.fromRGB(60, 70, 100),
		borderLight: Color3.fromRGB(40, 48, 70),
		outline: Color3.fromRGB(60, 70, 100),
		onSurface: Color3.fromRGB(235, 238, 250),
		onSurfaceVariant: Color3.fromRGB(160, 170, 200),
		onPrimary: Color3.fromRGB(255, 255, 255),
		onSecondary: Color3.fromRGB(255, 255, 255),
	},
	gradients: {
		primary: [Color3.fromRGB(88, 134, 255), Color3.fromRGB(138, 92, 246)],
		card: [Color3.fromRGB(20, 23, 35), Color3.fromRGB(28, 32, 45)],
		accent: [Color3.fromRGB(72, 220, 140), Color3.fromRGB(88, 134, 255)],
	},
	blur: {
		enabled: true,
		intensity: 32,
	},
};

// Thème Clair Moderne (Style macOS Big Sur)
export const lightTheme: Theme = {
	name: "Light",
	colors: {
		background: Color3.fromRGB(245, 247, 252),
		surface: Color3.fromRGB(255, 255, 255),
		surfaceVariant: Color3.fromRGB(248, 250, 255),
		primary: Color3.fromRGB(0, 122, 255),
		primaryVariant: Color3.fromRGB(10, 132, 255),
		secondary: Color3.fromRGB(88, 86, 214),
		accent: Color3.fromRGB(52, 199, 89),
		text: Color3.fromRGB(28, 32, 45),
		textSecondary: Color3.fromRGB(100, 110, 140),
		success: Color3.fromRGB(52, 199, 89),
		warning: Color3.fromRGB(255, 159, 10),
		error: Color3.fromRGB(255, 69, 58),
		border: Color3.fromRGB(200, 210, 230),
		borderLight: Color3.fromRGB(220, 225, 240),
		outline: Color3.fromRGB(200, 210, 230),
		onSurface: Color3.fromRGB(28, 32, 45),
		onSurfaceVariant: Color3.fromRGB(100, 110, 140),
		onPrimary: Color3.fromRGB(255, 255, 255),
		onSecondary: Color3.fromRGB(255, 255, 255),
	},
	gradients: {
		primary: [Color3.fromRGB(0, 122, 255), Color3.fromRGB(88, 86, 214)],
		card: [Color3.fromRGB(255, 255, 255), Color3.fromRGB(248, 250, 255)],
		accent: [Color3.fromRGB(52, 199, 89), Color3.fromRGB(0, 122, 255)],
	},
	blur: {
		enabled: true,
		intensity: 24,
	},
};

// Thème Coloré (Style Discord/Gaming avec néons)
export const colorfulTheme: Theme = {
	name: "Colorful",
	colors: {
		background: Color3.fromRGB(44, 27, 66),
		surface: Color3.fromRGB(58, 38, 84),
		surfaceVariant: Color3.fromRGB(70, 48, 100),
		primary: Color3.fromRGB(162, 89, 255),
		primaryVariant: Color3.fromRGB(138, 68, 234),
		secondary: Color3.fromRGB(255, 107, 237),
		accent: Color3.fromRGB(89, 242, 255),
		text: Color3.fromRGB(250, 245, 255),
		textSecondary: Color3.fromRGB(200, 190, 220),
		success: Color3.fromRGB(87, 242, 135),
		warning: Color3.fromRGB(255, 202, 40),
		error: Color3.fromRGB(255, 85, 127),
		border: Color3.fromRGB(120, 80, 160),
		borderLight: Color3.fromRGB(90, 60, 130),
		outline: Color3.fromRGB(120, 80, 160),
		onSurface: Color3.fromRGB(250, 245, 255),
		onSurfaceVariant: Color3.fromRGB(200, 190, 220),
		onPrimary: Color3.fromRGB(255, 255, 255),
		onSecondary: Color3.fromRGB(255, 255, 255),
	},
	gradients: {
		primary: [Color3.fromRGB(162, 89, 255), Color3.fromRGB(255, 107, 237)],
		card: [Color3.fromRGB(58, 38, 84), Color3.fromRGB(70, 48, 100)],
		accent: [Color3.fromRGB(89, 242, 255), Color3.fromRGB(162, 89, 255)],
	},
	blur: {
		enabled: true,
		intensity: 40,
	},
};

// Thème Cyberpunk (Nouveauté - style futuriste)
export const cyberpunkTheme: Theme = {
	name: "Cyberpunk",
	colors: {
		background: Color3.fromRGB(10, 10, 15),
		surface: Color3.fromRGB(18, 18, 25),
		surfaceVariant: Color3.fromRGB(25, 25, 35),
		primary: Color3.fromRGB(0, 255, 255),
		primaryVariant: Color3.fromRGB(0, 200, 255),
		secondary: Color3.fromRGB(255, 0, 255),
		accent: Color3.fromRGB(255, 255, 0),
		text: Color3.fromRGB(240, 255, 255),
		textSecondary: Color3.fromRGB(180, 200, 220),
		success: Color3.fromRGB(0, 255, 128),
		warning: Color3.fromRGB(255, 200, 0),
		error: Color3.fromRGB(255, 0, 100),
		border: Color3.fromRGB(0, 200, 200),
		borderLight: Color3.fromRGB(0, 150, 150),
		outline: Color3.fromRGB(0, 200, 200),
		onSurface: Color3.fromRGB(240, 255, 255),
		onSurfaceVariant: Color3.fromRGB(180, 200, 220),
		onPrimary: Color3.fromRGB(0, 0, 0),
		onSecondary: Color3.fromRGB(0, 0, 0),
	},
	gradients: {
		primary: [Color3.fromRGB(0, 255, 255), Color3.fromRGB(255, 0, 255)],
		card: [Color3.fromRGB(18, 18, 25), Color3.fromRGB(25, 25, 35)],
		accent: [Color3.fromRGB(255, 0, 255), Color3.fromRGB(255, 255, 0)],
	},
	blur: {
		enabled: true,
		intensity: 48,
	},
};

export const themes: Record<string, Theme> = {
	sorbet: sorbetTheme, // Thème par défaut
	dark: darkTheme,
	light: lightTheme,
	colorful: colorfulTheme,
	cyberpunk: cyberpunkTheme,
};

export const defaultTheme = sorbetTheme; // Sorbet par défaut
