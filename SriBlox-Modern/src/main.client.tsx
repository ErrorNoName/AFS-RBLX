import Roact from "@rbxts/roact";
import App from "./App";

const Players = game.GetService("Players");
const LocalPlayer = Players.LocalPlayer;
const PlayerGui = LocalPlayer.WaitForChild("PlayerGui") as PlayerGui;

/**
 * Point d'entrée de SriBlox Modern
 * Monte l'application dans PlayerGui
 */
const tree = Roact.mount(<App />, PlayerGui, "SriBloxModern");

print("SriBlox Modern v2.0 loaded! Press F6 to toggle.");

// Cleanup au démontage
game.GetService("RunService").Heartbeat.Connect(() => {
	// L'application tourne
});
