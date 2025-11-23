// Types pour SriBlox Modern

export interface ScriptOwner {
	username: string;
	avatar?: string;
	verified?: boolean;
}

export interface ScriptGame {
	name: string;
	imageUrl?: string;
}

export type ScriptTag = 
	| "VERIFIED" 
	| "REVIEW" 
	| "CREATOR" 
	| "UNIVERSAL" 
	| "KEY" 
	| "PATCHED" 
	| "TRENDING";

export type ScriptType = "free" | "paid" | "universal";

export interface Script {
	_id: string;
	slug: string;
	title: string;
	features?: string;
	owner?: ScriptOwner;
	game?: ScriptGame;
	tags?: ScriptTag[];
	type?: ScriptType;
	views?: number;
	likes?: number;
	dislikes?: number;
	createdAt?: string;
	updatedAt?: string;
	verified?: boolean;
	key?: boolean;
}

export interface SearchResponse {
	result: {
		scripts: Script[];
		totalPages: number;
		currentPage: number;
	};
}

export interface ScriptDetailResponse {
	script: {
		script: string; // Le code Lua du script
	};
}

export interface Theme {
	name: string;
	colors: {
		background: Color3;
		surface: Color3;
		surfaceVariant: Color3;
		primary: Color3;
		primaryVariant: Color3;
		secondary: Color3;
		accent: Color3;
		text: Color3;
		textSecondary: Color3;
		success: Color3;
		warning: Color3;
		error: Color3;
		border: Color3;
		borderLight: Color3;
		outline: Color3;
		onSurface: Color3;
		onSurfaceVariant: Color3;
		onPrimary: Color3;
		onSecondary: Color3;
	};
	gradients: {
		primary: [Color3, Color3];
		card: [Color3, Color3];
		accent: [Color3, Color3];
	};
	blur: {
		enabled: boolean;
		intensity: number;
	};
}

export interface AppState {
	search: {
		query: string;
		results: Script[];
		loading: boolean;
		error?: string;
		page: number;
		totalPages: number;
	};
	ui: {
		visible: boolean;
		currentTheme: string;
		searchBarFocused: boolean;
	};
}
