{
  config,
  inputs,
  ...
}: {
  flake = {
    modules = {
      nixos =
        config.flake.lib.loadModulesRecursively
        {
          inherit inputs;
          src = ../nixos;
        };
    };
  };
}
