import { HttpService } from "@rbxts/services";
import { Script, SearchResponse, ScriptDetailResponse } from "../types";

const BASE_URL = "https://scriptblox.com/api/script";

export class ScriptBloxService {
	/**
	 * Rechercher des scripts sur ScriptBlox
	 */
	public static searchScripts(query: string, page: number = 1, maxResults: number = 12): Promise<SearchResponse> {
		return new Promise((resolve, reject) => {
			const encodedQuery = HttpService.UrlEncode(query);
			const url = `${BASE_URL}/search?q=${encodedQuery}&mode=free&max=${maxResults}&page=${page}`;

			try {
				// Utiliser game:HttpGet comme dans le code Lua fonctionnel
				const gameAny = game as unknown as { HttpGet?: (game: unknown, url: string) => string };
				const httpGet = gameAny.HttpGet;
				
				if (!httpGet) {
					reject("HttpGet not available");
					return;
				}

				const response = (httpGet as (game: unknown, url: string) => string)(game, url);
				const data = HttpService.JSONDecode(response) as SearchResponse;
				
				// Vérifier que la structure est correcte
				if (!data.result || !data.result.scripts) {
					reject("Invalid response structure from API");
					return;
				}
				
				resolve(data);
			} catch (error) {
				reject(`Search failed: ${error}`);
			}
		});
	}

	/**
	 * Récupérer le code d'un script par son slug
	 */
	public static getScriptCode(slug: string): Promise<string> {
		return new Promise((resolve, reject) => {
			const url = `${BASE_URL}/${slug}`;

			try {
				// Utiliser game:HttpGet
				const gameAny = game as unknown as { HttpGet?: (game: unknown, url: string) => string };
				const httpGet = gameAny.HttpGet;
				
				if (!httpGet) {
					reject("HttpGet not available");
					return;
				}

				const response = (httpGet as (game: unknown, url: string) => string)(game, url);
				const data = HttpService.JSONDecode(response) as ScriptDetailResponse;
				
				if (data.script && data.script.script) {
					resolve(data.script.script);
				} else {
					reject("Script code not found");
				}
			} catch (error) {
				reject(`Failed to fetch script: ${error}`);
			}
		});
	}

	/**
	 * Exécuter un script
	 */
	public static executeScript(slug: string): Promise<void> {
		return new Promise((resolve, reject) => {
			this.getScriptCode(slug)
				.then((code) => {
					try {
						if (loadstring) {
							const loadedFunc = loadstring(code);
							if (loadedFunc) {
								loadedFunc();
								resolve();
							} else {
								reject("Failed to load script");
							}
						} else {
							reject("loadstring not available");
						}
					} catch (error) {
						reject(`Execution failed: ${error}`);
					}
				})
				.catch(reject);
		});
	}

	/**
	 * Copie l'URL d'un script dans le presse-papier
	 */
	static copyScriptUrl(slug: string): void {
		const url = `https://scriptblox.com/script/${slug}`;
		
		// setclipboard (fonctionne uniquement dans les executors)
		const setClipFunc = (setclipboard as ((text: string) => void) | undefined);
		if (setClipFunc) {
			setClipFunc(url);
		} else {
			warn("setclipboard not available - URL: " + url);
		}
	}

	/**
	 * Formater un nombre (1200 -> 1.2K)
	 */
	public static formatNumber(num?: number): string {
		if (!num) return "0";
		if (num >= 1000000) return `${math.floor(num / 100000) / 10}M`;
		if (num >= 1000) return `${math.floor(num / 100) / 10}K`;
		return tostring(num);
	}

	/**
	 * Formater une date (YYYY-MM-DD -> DD/MM/YYYY)
	 */
	public static formatDate(dateString?: string): string {
		if (!dateString) return "";
		
		const [year, month, day] = dateString.match("(%d+)%-(%d+)%-(%d+)") as LuaTuple<[string, string, string]>;
		if (year && month && day) {
			return `${day}/${month}/${year}`;
		}
		
		return dateString;
	}
}
