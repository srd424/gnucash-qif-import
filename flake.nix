{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
#    gnucashfl.url = "/vol/home-ssd/steved-ssd-data/src/nixos/gnucash54";
    gnucashfl.url = "github:srd424/gnucash54-nix";
  };

  outputs = { self, nixpkgs, gnucashfl }: let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
#      gnucash = gnucashfl.packages.x86_64-linux.gnucash;
      pymodule = gnucashfl.packages.x86_64-linux.pymodule;
    in {

    packages.x86_64-linux.import = pkgs.python3Packages.buildPythonApplication rec {
      pname = "gnucash-qif-import";
      version = "0.1";
      src = ./src;
      format = "other";
      propagatedBuildInputs = [ pymodule ];
      installPhase = ''
        mkdir -p $out/bin
        cp qif.py import.py $out/bin
      '';
    };
    packages.x86_64-linux.default = self.packages.x86_64-linux.import;

  };
}

# vim: set ts=2 sw=2 et sta:
