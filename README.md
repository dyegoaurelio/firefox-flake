# firefox-flake

### using `nix-build` to compile Firefox

```sh
nix-build -E 'with import <nixpkgs> {}; callPackage ./firefox-build.nix {}'
```

you may adjust `firefox-build.nix` to point to your local `mozilla-central` repo


### flake dev env

```sh
nix develop . --impure

```
