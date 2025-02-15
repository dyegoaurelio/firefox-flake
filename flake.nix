{
  description = "A flake for building Firefox";

  outputs = { self, nixpkgs }: {

    defaultPackage.x86_64-linux =
      with import nixpkgs { system = "x86_64-linux"; };
      callPackage ./firefox-build.nix { };

  };
}