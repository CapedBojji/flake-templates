import jabby, { obtain_client } from "@rbxts/jabby";
import { ContextActionService, RunService } from "@rbxts/services";

import { world as world_ } from "./world";

export function start(): void {
	if (RunService.IsClient()) {
		const client = obtain_client();

		const createWidget = (_: string, state: Enum.UserInputState): void => {
			if (state !== Enum.UserInputState.Begin) {
				return;
			}

			client.spawn_app(client.apps.home);
		};

		ContextActionService.BindAction("Open Jabby Home", createWidget, false, Enum.KeyCode.F4);
	}

	jabby.register({
		name: "World",
		applet: jabby.applets.world,
		configuration: {
			world: world_,
		},
	});
}
