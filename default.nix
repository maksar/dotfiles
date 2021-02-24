let
  nix-pre-commit-hooks = import (builtins.fetchTarball
    "https://github.com/cachix/pre-commit-hooks.nix/tarball/master");
in {
  pre-commit-check = nix-pre-commit-hooks.run {
    src = ./.;
    # If your hooks are intrusive, avoid running on each commit with a default_states like this:
    # default_stages = ["manual" "push"];
    hooks = { nixfmt.enable = true; };
  };
}
