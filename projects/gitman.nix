# TODO remove
{ config, lib, pkgs, ... }:
with pkgs;
let
  gitmanFolder = "${config.projectsFolder}/gitman";
  gitman = import gitmanFolder { };
  gitmanDocker = stdenv.mkDerivation {
    name = "gitman-docker";
    src = gitmanFolder;
    dontUnpack = true;
    installPhase = ''
      mkdir $out
      cp ${(import "${gitmanFolder}/docker.nix" { }).outPath} $out/
    '';
  };
in
{

  environment.systemPackages = [
    gitman
    gitmanDocker
  ];

  environment.extraInit = ''
    set -o allexport;
    source ${gitmanFolder}/.env;
    set +o allexport;
  '';
}
