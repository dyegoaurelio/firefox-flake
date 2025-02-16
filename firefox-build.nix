{
  mozillaCentralPath ? null,
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
    src =  if mozillaCentralPath == null then
      fetchurl {
      url = "mirror://mozilla/devedition/releases/${version}/source/firefox-${version}.source.tar.xz";
      sha512 = "bf09f999b347492b841a26fcbcfb4d37e5f74528a05ffab47572dcaae01cb43e70baf58e83cc5153498a6a6ad2cb69507b628fba840090c91f4dbca62717a435";
    } else
      fetchGit {
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