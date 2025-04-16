{
  pkgs ? import <nixpkgs> {},
}:
let
  stdenv = pkgs.stdenv;
  fs = pkgs.lib.fileset;
  sourceFiles = ./dyndns.sh;
in 
fs.trace sourceFiles
stdenv.mkDerivation {
  name = "dyndns";
  src = fs.toSource {
    root = ./.;
    fileset = sourceFiles;
  };
  dontPatch = true;
  dontConfigure = true;
  dontBuild = true;
  dontFixup = true;
  installPhase = ''
    runHook preInstall
    mkdir $out
    cp dyndns.sh $out
    runHook postInstall
  '';
}
