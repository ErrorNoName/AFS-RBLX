import { AppState } from "../types";
import { Action, ActionType } from "./actions";

// État initial
const initialState: AppState = {
	search: {
		query: "",
		results: [],
		loading: false,
		error: undefined,
		page: 1,
		totalPages: 1,
	},
	ui: {
		visible: false,
		currentTheme: "dark",
		searchBarFocused: false,
	},
};

// Reducer principal
export const rootReducer = (state: AppState = initialState, action: Action): AppState => {
	switch (action.type) {
		case ActionType.SET_SEARCH_QUERY:
			return {
				...state,
				search: { ...state.search, query: action.query },
			};

		case ActionType.SET_SEARCH_RESULTS:
			return {
				...state,
				search: {
					...state.search,
					results: action.results,
					totalPages: action.totalPages,
					loading: false,
					error: undefined,
				},
			};

		case ActionType.SET_LOADING:
			return {
				...state,
				search: { ...state.search, loading: action.loading },
			};

		case ActionType.SET_ERROR:
			return {
				...state,
				search: {
					...state.search,
					error: action.errorMessage,
					loading: false,
				},
			};

		case ActionType.SET_CURRENT_PAGE:
			return {
				...state,
				search: { ...state.search, page: action.page },
			};

		case ActionType.TOGGLE_VISIBILITY:
			return {
				...state,
				ui: { ...state.ui, visible: !state.ui.visible },
			};

		case ActionType.SET_THEME:
			return {
				...state,
				ui: { ...state.ui, currentTheme: action.theme.name },
			};

		case ActionType.SET_THEME_SELECTOR_OPEN:
			// Nous utilisons searchBarFocused pour simuler themeSelectorOpen
			return {
				...state,
				ui: { ...state.ui, searchBarFocused: action.open },
			};

		default:
			return state;
	}
};
