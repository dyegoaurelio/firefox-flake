# firefox-flake

### flake dev env

```sh
nix develop . --impure

```

firefox [gecko dev](https://github.com/mozilla/gecko-dev/) commit that works with this env : `ce3c5a535c756991ba7c0ee398f929516be20517`

nix derivation commands to run after getting into dev shell,  `cd` into firefox folder and checking out to appropriate commit:

```sh
# patchPhase # optional (apply mach ide vscode fix)
configurePhase
buildPhase
```

### using `nix build` to compile Firefox

1. make sure to adjust the `src` path in `firefox-build.nix`

```sh
nix build . --impure
```

