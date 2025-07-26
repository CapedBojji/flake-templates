{
  description = "A collection of my Nix flake templates for various projects";

  outputs = { self, nixpkgs, ... }@inputs: {
    templates = {

      rbxts-package = {
        path = ./templates/roblox/packages/typescript;
        description = ''
          A template for creating Roblox packages using TypeScript.
          This template includes a development environment with tools like Rojo, Bun, run-in-roblox, and Lune.
          It is designed to help you quickly set up a Roblox package with TypeScript support.
        '';
      };

      rbxts-ecs = {
        path = ./templates/roblox/game/ecs/typescript;
        description = ''
          A template for creating Roblox games using TypeScript with ECS (Entity Component System) architecture.
          This template provides a complete development environment with Rojo, pnpm, Node.js v24, run-in-roblox, and Lune.
          It includes a structured project layout optimized for scalable game development with client/server/shared architecture.
          Perfect for building complex Roblox experiences with maintainable, component-based design patterns.
        '';
      };
    };
  };
}