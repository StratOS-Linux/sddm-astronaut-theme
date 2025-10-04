{
  description = "SDDM Astronaut theme (StratOS version) as a flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    stratos-fonts.url = "github:stratos-linux/stratos-fonts";
  };

  outputs = { self, nixpkgs, stratos-fonts }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      packages.${system}.default = pkgs.stdenv.mkDerivation {
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

      nixosModules.sddm-theme = { config, pkgs, ... }: {
        config = {
          services.displayManager.sddm = {
            enable = true;
            wayland.enable = true;
            theme = "sddm-astronaut-theme";
          };

          # Install theme + fonts globally
          fonts.packages = [ stratos-fonts.packages.${system}.default ];
          environment.systemPackages = [
            self.packages.${system}.default
            stratos-fonts.packages.${system}.default # this probably isn't necessary
            pkgs.kdePackages.qtmultimedia
          ];

          # Ensure global fonts are available to Fontconfig
          fonts.fontDir.enable = true;
        };
      };
    };
}
