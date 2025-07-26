import { Scheduler } from "@rbxts/planck";
import PlanckJabby from "@rbxts/planck-jabby";
import { Plugin as PlanckRunservice } from "@rbxts/planck-runservice";

import { world } from "./world";

export const scheduler = new Scheduler(world);

scheduler.addPlugin(new PlanckJabby());
scheduler.addPlugin(new PlanckRunservice());
