import { getInstanceAtPath } from "@rbxts/flamework-meta-utils";
import { TestRunner } from "@rbxts/runit";

const testRunner = new TestRunner(getInstanceAtPath("src/tests")!);
testRunner.run({ colors: true }).await();