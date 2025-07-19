{
  inputs = {
    nixpkgs.url = "github:cachix/devenv-nixpkgs/rolling";
    systems.url = "github:nix-systems/default";
    devenv.url = "github:cachix/devenv";
    devenv.inputs.nixpkgs.follows = "nixpkgs";
  };

  nixConfig = {
    extra-trusted-public-keys = "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=";
    extra-substituters = "https://devenv.cachix.org";
  };

  outputs = { self, nixpkgs, devenv, systems, ... } @ inputs:
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
          in
          {
            default = devenv.lib.mkShell {
              inherit inputs pkgs;
              modules = [
                {
                  # https://devenv.sh/reference/options/
                  packages = [ pkgs.rojo pkgs.nodejs_24 pkgs.pnpm_9];

                  enterShell = ''
                    echo ""
                    echo "██████╗  ██████╗ ██████╗ ██╗      ██████╗ ██╗  ██╗"
                    echo "██╔══██╗██╔═══██╗██╔══██╗██║     ██╔═══██╗╚██╗██╔╝"
                    echo "██████╔╝██║   ██║██████╔╝██║     ██║   ██║ ╚███╔╝ "
                    echo "██╔══██╗██║   ██║██╔══██╗██║     ██║   ██║ ██╔██╗ "
                    echo "██║  ██║╚██████╔╝██████╔╝███████╗╚██████╔╝██╔╝ ██╗"
                    echo "╚═╝  ╚═╝ ╚═════╝ ╚═════╝ ╚══════╝ ╚═════╝ ╚═╝  ╚═╝"
                    echo ""
                    echo "🎮 Welcome to the Roblox TypeScript Development Shell! 🎮"
                    echo ""
                    echo "📦 Available tools:"
                    echo "  • rojo      - Roblox project management"
                    echo "  • node.js   - JavaScript runtime (v24)"
                    echo "  • pnpm      - Fast package manager (v9)"
                    echo ""
                    echo "🚀 Happy coding!"
                    echo ""
                  '';
                }
              ];
            };
          });
    };
}
