{ pkgs, ... }:

{
  system.stateVersion = "24.11";
  nixpkgs.config.allowUnfree = true;
  networking.hostName = "nixos-s905x";

  users.users.yuki = {
    isNormalUser = true;
    description = "Aku Admin";
    password = "atomik";
    packages = with pkgs; [ ];
    extraGroups = [
      "whell"
      "networkmanager"
    ];
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      grub.enable = false;
      generic-extlinux-compatible.enable = true;
      # generic-extlinux-compatible.configurationLimit = 1;
    };
  };

  hardware.deviceTree = {
    enable = true;
    name = "meson-gxl-s905x-p212.dtb";
  };

  services.openssh.enable = true;
}
