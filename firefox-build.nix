{
  mozillaCentralPath,
  pkgs ? import <nixpkgs> {},
  _extraPatches ? [],
  _extraBuildInputs ? [],
  _extraConfigureFlags ? []
}:
  with pkgs;
  callPackage ./common.nix rec {
    pname = "firefox-devedition";
    version = "135.0b9";
    applicationName = "Mozilla Firefox Developer Edition";
    requireSigning = false;
    branding = "browser/branding/aurora";
    src = fetchGit {
      url = mozillaCentralPath;
    };

    meta = {
      changelog = "https://www.mozilla.org/en-US/firefox/${lib.versions.majorMinor version}beta/releasenotes/";
      description = "Web browser built from Firefox Developer Edition source tree";
      homepage = "http://www.mozilla.com/en-US/firefox/";
      maintainers = with lib.maintainers; [ jopejoe1 ];
      platforms = lib.platforms.unix;
      broken = stdenv.buildPlatform.is32bit;
      maxSilent = 14400;
      license = lib.licenses.mpl20;
      mainProgram = "firefox";
    };

    tests = {
      inherit (nixosTests) firefox-devedition;
    };
    extraConfigureFlags = _extraConfigureFlags;
    extraPatches = _extraPatches;
    extraBuildInputs = _extraBuildInputs;
  }