import { Flamework } from "@flamework/core";
import Log from "@rbxts/log";

import { GAME_NAME } from "shared/constants";
import { setupLogger } from "shared/functions/setup-logger";
import { start } from "shared/start";

function bootstrap(): void {
	setupLogger();

	Log.Info(`${GAME_NAME} client version: ${game.PlaceVersion}`);

	Flamework.addPaths("src/client");
	start();

	Log.Info("Flamework ignite!");
	Flamework.ignite();
}

bootstrap();
