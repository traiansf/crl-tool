let

  sources = import ./sources.nix;
  project = (import ./default.nix) { inherit sources; };
  pkgs = import sources.nixpkgs { };
in

# See https://docs.haskellstack.org/en/stable/nix_integration/#using-a-custom-shellnix-file
{ ghc }:

pkgs.haskell.lib.buildStackProject {
  inherit ghc;
  name = "haskell-stack-nix";
  # System dependencies needed at compilation time
  buildInputs = [
    pkgs.zlib
  ] ++ [project.devTools.kore-libs] ;
}
