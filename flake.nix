{
  description = "A collection of my Nix flake templates for various projects";

  outputs = { self, nixpkgs, ... }@inputs: {
    templates = {

      roblox-ts-project = {
        path = ./templates/roblox-ts-project;
        description = ''
          Minimal starting project for nix-based Roblox TypeScript development
        '';
      };
    };
  };
}