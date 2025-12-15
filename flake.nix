{
  description = "SDDM Astronaut theme (StratOS version) as a flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    stratos-fonts.url = "github:stratos-linux/stratos-fonts";
  };

  outputs = { self, nixpkgs, stratos-fonts }:
    {
      packages.x86_64-linux.default =
        let
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
        in
          pkgs.stdenv.mkDerivation {
            pname = "sddm-astronaut-theme";
            version = "unstable";

            src = ./.;

            installPhase = ''
          mkdir -p $out/share/sddm/themes
          cp -r usr/share/sddm/themes/sddm-astronaut-theme \
                $out/share/sddm/themes/
        '';

            meta = with pkgs.lib; {
              description = "Custom SDDM Astronaut theme (StratOS fork)";
              license = licenses.gpl3;
              maintainers = [ "zstg" ];
              platforms = platforms.linux;
            };
          };

      nixosModules.default = { config, lib, pkgs, ... }: {
        imports = [
          stratos-fonts.nixosModules.default
        ];

        config = {
          fonts.fontconfig.enable = true;

          services.displayManager.sddm = {
            enable = lib.mkDefault true;
            wayland.enable = lib.mkDefault false;

            theme = "sddm-astronaut-theme";
            themePackages = [
              self.packages.${pkgs.system}.default
            ];
          };

          environment.systemPackages = [
            pkgs.kdePackages.qtmultimedia
          ];
        };
      };

    };
}
