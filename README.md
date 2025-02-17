# firefox-flake

### flake dev env

```sh
nix develop . --impure

```

firefox [gecko dev](https://github.com/mozilla/gecko-dev/) commit that works with this env : `b91083eec3c510fa1b5337471401a04c5eb86f84`

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

