import { Phases, Plugin } from "@rbxts/planck-runservice";

import { scheduler } from "shared/scheduler";

function helloWorld(): void {
	print("Hello, World!");
}

scheduler.addSystem(helloWorld, Phases.Update);
