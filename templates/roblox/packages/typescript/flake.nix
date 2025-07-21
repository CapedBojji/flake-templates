{
  inputs = {
    nixpkgs.url = "github:cachix/devenv-nixpkgs/rolling";
    systems.url = "github:nix-systems/default";
    devenv.url = "github:cachix/devenv";
    devenv.inputs.nixpkgs.follows = "nixpkgs";
    custom-packages = {
      url = "github:CapedBojji/custom-nixpkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  nixConfig = {
    extra-trusted-public-keys = "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=";
    extra-substituters = "https://devenv.cachix.org";
  };

  outputs = { self, nixpkgs, devenv, systems, custom-packages, ... } @ inputs:
    let
      forEachSystem = nixpkgs.lib.genAttrs (import systems);
    in
    {
      packages = forEachSystem (system: {
        devenv-up = self.devShells.${system}.default.config.procfileScript;
        devenv-test = self.devShells.${system}.default.config.test;
      });

      devShells = forEachSystem
        (system:
          let
            pkgs = nixpkgs.legacyPackages.${system};
            run-in-roblox = custom-packages.packages.${system}.run-in-roblox;
          in
          {
            default = devenv.lib.mkShell {
              inherit inputs pkgs;
              modules = [
                {
                  # https://devenv.sh/reference/options/
                  packages = [ pkgs.rojo pkgs.bun run-in-roblox pkgs.lune ];

                  enterShell = ''
                    echo ""
                    echo "🎮 Welcome to the Roblox TypeScript Development Environment! 🎮"
                    echo ""
                    echo "This environment is configured for Roblox-TS package development."
                    echo ""
                    echo "📦 Available packages:"
                    echo "  • rojo          - Roblox project management and sync tool"
                    echo "  • bun           - Fast JavaScript runtime and package manager"
                    echo "  • run-in-roblox - Custom tool for running code in Roblox Studio"
                    echo "  • lune          - Luau scripting runtime for automation and tooling"
                    echo ""
                    echo "🚀 Ready to build awesome Roblox experiences with TypeScript!"
                    echo ""
                  '';
                }
              ];
            };
          });
    };
}
