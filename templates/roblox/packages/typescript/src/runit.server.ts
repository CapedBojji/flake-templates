import { TestRunner } from "@rbxts/runit";
import { ServerScriptService } from "@rbxts/services";

const testRunner = new TestRunner(ServerScriptService.FindFirstChild("Tests") as Folder);

testRunner.run();