{
  description = "A flake for building Firefox";
  inputs.nixpkgs = {
    url = "github:NixOS/nixpkgs/9855e2d3f265add064386d5db7b66b0d18a9977a";
  };
  outputs = { self, nixpkgs }: {

    defaultPackage.x86_64-linux =
    let
      pkgs =  import nixpkgs { system = "x86_64-linux"; };
      in
      pkgs.callPackage (import ./firefox-build.nix {
        pkgs = pkgs;
        mozillaCentralPath = "file:///home/dyego/coding/random/mozilla-central";
        _extraPatches = [
          ./fix-mach-ide-vscode.diff
        ];
        _extraConfigureFlags = [
          "--disable-bootstrap"
        ];
        _extraBuildInputs = [
          pkgs.python312Packages.ninja
          pkgs.gdb
        ];
      }){};

  };
}