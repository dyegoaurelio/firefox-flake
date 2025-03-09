{
  description = "A flake for building Firefox";
  inputs.nixpkgs = {
    url = "github:NixOS/nixpkgs/9855e2d3f265add064386d5db7b66b0d18a9977a";
  };
   inputs.nixpkgs-24-11 = {
    url = "github:NixOS/nixpkgs/16df1b33546abf4d55ee2b895606edd4e0e3612f";
  };
  outputs = { self, nixpkgs, nixpkgs-24-11 }: {

    defaultPackage.x86_64-linux =
    let
      pkgs =  import nixpkgs { system = "x86_64-linux"; };
      pkgs-24-11 =  import nixpkgs-24-11 { system = "x86_64-linux"; };

      devPkgs = [
          pkgs.gdb
          pkgs-24-11.seer
      ];


      custom-scripts = pkgs.stdenv.mkDerivation {

        # name of our derivation
        name = "custom-scripts";

        # sources that will be used for our derivation.
        src = ./scripts;

        # see https://nixos.org/nixpkgs/manual/#ssec-install-phase
        # $src is defined as the location of our `src` attribute above
        installPhase = ''
         # Create a directory at the output path
          mkdir -p $out/bin

          # Copy scripts into the bin directory and make them executable
          cp -v $src/* $out/bin/
          chmod +x $out/bin/*
        '';
        buildInputs =  devPkgs ++ [
        ];
      };

      in
      pkgs.callPackage (import ./firefox-build.nix {
        pkgs = pkgs;
        # mozillaCentralPath = "file:///home/dyego/coding/random/mozilla-central";
        _extraPatches = [
          ./fix-mach-ide-vscode.diff
        ];
        _extraConfigureFlags = [
          "--disable-bootstrap"
        ];
        _extraBuildInputs =  devPkgs ++ [
          pkgs.python312Packages.ninja
          custom-scripts
        ];
      }){};

  };
}