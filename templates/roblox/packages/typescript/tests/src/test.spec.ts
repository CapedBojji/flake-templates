import { Assert, Fact } from "@rbxts/runit";
import { hello } from "../../src";

class MyPackageTest {
  @Fact
  public basicAssert(): void {
    Assert.equal(hello("World"), "Hello, World!");
  }
}

export = MyPackageTest;