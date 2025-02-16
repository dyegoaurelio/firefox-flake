{
  description = "A flake for building Firefox";

  outputs = { self, nixpkgs }: {

    defaultPackage.x86_64-linux =
    let
      pkgs =  import nixpkgs { system = "x86_64-linux"; };
      in
      pkgs.callPackage (import ./firefox-build.nix {
        pkgs = pkgs;
        _extraPatches = [
          ./fix-mach-ide-vscode.diff
        ];
        _extraConfigureFlags = [
          "--disable-bootstrap"
        ];
      }){};

  };
}