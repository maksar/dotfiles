{
  extras = hackage: {
    packages = {
      "Hclip" = (((hackage.Hclip)."3.0.0.4").revisions).default;
      gamgee = ./gamgee.nix;
    };
  };
  resolver = "lts-15.14";
  modules = [ ({ lib, ... }: { packages = { }; }) { packages = { }; } ];
}
