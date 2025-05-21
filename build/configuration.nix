{ pkgs, lib, ... }:

{
  system.stateVersion = "24.11";
  services.openssh.enable = true;
  i18n.defaultLocale = "en_US.UTF-8";
  networking.hostName = "nixos-s905x";

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs = {
    config.allowUnfree = true;
    localSystem.system = "x86_64-linux";
    crossSystem.system = "aarch64-linux";
  };

  users.users.yuki = {
    isNormalUser = true;
    description = "Aku Admin";
    password = "atomik";
    packages = with pkgs; [ git ];
    extraGroups = [
      "whell"
      "networkmanager"
    ];
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    consoleLogLevel = lib.mkDefault 7;
    loader = {
      grub.enable = false;
      generic-extlinux-compatible.enable = true;
      generic-extlinux-compatible.configurationLimit = 3;
    };
  };

  hardware.deviceTree = {
    enable = true;
    name = "meson-gxl-s905x-p212.dtb";
  };

  sdImage = {
    compressImage = false;
    postBuildCommands = ''
      # https://github.com/NixOS/nixpkgs/blob/master/pkgs/misc/uboot/default.nix#L290
      dd if=${pkgs.ubootLibreTechCC}/u-boot.gxl.sd.bin of=$img conv=fsync,notrunc bs=512 seek=1 skip=1
      dd if=${pkgs.ubootLibreTechCC}/u-boot.gxl.sd.bin of=$img conv=fsync,notrunc bs=1 count=444
    '';
  };
}
