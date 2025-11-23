import Rodux from "@rbxts/rodux";
import { rootReducer } from "./reducer";
import { AppState } from "../types";

// Création du store Rodux
export const store = new Rodux.Store<AppState, any>(rootReducer);

// Type pour le dispatch
export type StoreDispatch = typeof store.dispatch;

// Export du store configuré
export default store;
