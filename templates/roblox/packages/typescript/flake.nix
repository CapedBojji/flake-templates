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
                  packages = [ pkgs.python3 pkgs.firefox run-in-roblox ];

                  enterShell = ''
                    echo ""
                    echo "██████╗  ██████╗ ████████╗"
                    echo "██╔══██╗██╔═══██╗╚══██╔══╝"
                    echo "██████╔╝██║   ██║   ██║   "
                    echo "██╔══██╗██║   ██║   ██║   "
                    echo "██████╔╝╚██████╔╝   ██║   "
                    echo "╚═════╝  ╚═════╝    ╚═╝   "
                    echo ""
                    echo "  █████╗ ████████╗ ██████╗ ███████╗"
                    echo " ██╔══██╗╚══██╔══╝██╔═══██╗╚══███╔╝"
                    echo " ███████║   ██║   ██║   ██║  ███╔╝ "
                    echo " ██╔══██║   ██║   ██║   ██║ ███╔╝  "
                    echo " ██║  ██║   ██║   ╚██████╔╝███████╗"
                    echo " ╚═╝  ╚═╝   ╚═╝    ╚═════╝ ╚══════╝"
                    echo ""
                    echo "🤖 Amazon A to Z Shift Picker Bot 🤖"
                    echo ""
                    echo "📋 Ready to hunt for those shifts!"
                    echo "💪 Automated shift grabbing at your service"
                    echo ""
                    echo "🔧 Development Environment:"
                    echo "  • Python 3   - Bot runtime"
                    echo "  • Firefox     - Web automation"
                    echo ""
                    echo "⚡ Let's secure those shifts! ⚡"
                    echo ""
                  '';
                }
              ];
            };
          });
    };
}
