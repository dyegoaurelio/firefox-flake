# firefox-flake

### using `nix-build` to compile Firefox

```sh
nix-build -E 'with import <nixpkgs> {}; callPackage ./firefox-build.nix {}'
```

you may adjust `firefox-build.nix` to point to your local `mozilla-central` repo


### flake dev env

```sh
nix develop .

```

firefox [gecko dev](https://github.com/mozilla/gecko-dev/) commit that works with this env : `ce3c5a535c756991ba7c0ee398f929516be20517`

nix derivation commands to run after getting into dev shell,  `cd` into firefox folder and checking out to appropriate commit:

```sh
# patchPhase # optional (to apply nix patches)
configurePhase
buildPhase
```

