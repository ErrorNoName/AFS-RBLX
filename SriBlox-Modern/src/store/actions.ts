import { Script, Theme } from "../types";

// Action types
export const enum ActionType {
	// Search actions
	SET_SEARCH_QUERY = "SET_SEARCH_QUERY",
	SET_SEARCH_RESULTS = "SET_SEARCH_RESULTS",
	SET_LOADING = "SET_LOADING",
	SET_ERROR = "SET_ERROR",
	SET_CURRENT_PAGE = "SET_CURRENT_PAGE",
	
	// UI actions
	TOGGLE_VISIBILITY = "TOGGLE_VISIBILITY",
	SET_THEME = "SET_THEME",
	SET_THEME_SELECTOR_OPEN = "SET_THEME_SELECTOR_OPEN",
}

// Action creators
export interface SetSearchQueryAction {
	type: ActionType.SET_SEARCH_QUERY;
	query: string;
}

export interface SetSearchResultsAction {
	type: ActionType.SET_SEARCH_RESULTS;
	results: Script[];
	totalPages: number;
}

export interface SetLoadingAction {
	type: ActionType.SET_LOADING;
	loading: boolean;
}

export interface SetErrorAction {
	type: ActionType.SET_ERROR;
	errorMessage: string | undefined;
}

export interface SetCurrentPageAction {
	type: ActionType.SET_CURRENT_PAGE;
	page: number;
}

export interface ToggleVisibilityAction {
	type: ActionType.TOGGLE_VISIBILITY;
}

export interface SetThemeAction {
	type: ActionType.SET_THEME;
	theme: Theme;
}

export interface SetThemeSelectorOpenAction {
	type: ActionType.SET_THEME_SELECTOR_OPEN;
	open: boolean;
}

// Union type pour toutes les actions
export type Action =
	| SetSearchQueryAction
	| SetSearchResultsAction
	| SetLoadingAction
	| SetErrorAction
	| SetCurrentPageAction
	| ToggleVisibilityAction
	| SetThemeAction
	| SetThemeSelectorOpenAction;

// Action creators functions
export const setSearchQuery = (query: string): SetSearchQueryAction => ({
	type: ActionType.SET_SEARCH_QUERY,
	query,
});

export const setSearchResults = (results: Script[], totalPages: number): SetSearchResultsAction => ({
	type: ActionType.SET_SEARCH_RESULTS,
	results,
	totalPages,
});

export const setLoading = (loading: boolean): SetLoadingAction => ({
	type: ActionType.SET_LOADING,
	loading,
});

export const setError = (errorMessage: string | undefined): SetErrorAction => ({
	type: ActionType.SET_ERROR,
	errorMessage,
});

export const setCurrentPage = (page: number): SetCurrentPageAction => ({
	type: ActionType.SET_CURRENT_PAGE,
	page,
});

export const toggleVisibility = (): ToggleVisibilityAction => ({
	type: ActionType.TOGGLE_VISIBILITY,
});

export const setTheme = (theme: Theme): SetThemeAction => ({
	type: ActionType.SET_THEME,
	theme,
});

export const setThemeSelectorOpen = (open: boolean): SetThemeSelectorOpenAction => ({
	type: ActionType.SET_THEME_SELECTOR_OPEN,
	open,
});
