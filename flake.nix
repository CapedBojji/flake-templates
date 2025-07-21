{
  description = "A collection of my Nix flake templates for various projects";

  outputs = { self, nixpkgs, ... }@inputs: {
    templates = {

      rbx-package = {
        path = ./templates/roblox/packages/typescript;
        description = ''
          A template for creating Roblox packages using TypeScript.
          This template includes a development environment with tools like Rojo, Bun, run-in-roblox, and Lune.
          It is designed to help you quickly set up a Roblox package with TypeScript support.
        '';
      };
    };
  };
}