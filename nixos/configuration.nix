{ config, pkgs, ... }:

{
    imports = [
        /etc/nixos/hardware-configuration.nix
    ];

    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "nixos"; # Define your hostname.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    
    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
    
    # Enable networking
    networking.networkmanager.enable = true;
    
    # Set your time zone.
    time.timeZone = "Africa/Johannesburg";
    
    # Select internationalisation properties.
    i18n.defaultLocale = "en_GB.UTF-8";
    
    # Enable the X11 windowing system.
    services.xserver.enable = true;
    
    # Enable the Cinnamon Desktop Environment.
    services.xserver.displayManager.lightdm.enable = true;
    #services.xserver.desktopManager.cinnamon.enable = true;
    
    programs.zsh.enable = true;
    
    # Configure keymap in X11
    services.xserver = {
        layout = "za";
        xkbVariant = "";

        windowManager.i3 = {
            enable = true;
            extraPackages = with pkgs; [
                dmenu
                i3status
                i3lock
                i3blocks
          ];
        };
    };

    # Enable CUPS to print documents.
    services.printing.enable = true;

    # Bluetooth
    services.blueman.enable = true;
    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;

    # Enable sound with pipewire.
    sound.enable = true;
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        # If you want to use JACK applications, uncomment this
        #jack.enable = true;
        
        # use the example session manager (no others are packaged yet so this is enabled by default,
        # no need to redefine it in your config for now)
        #media-session.enable = true;
    };

    # Enable touchpad support (enabled default in most desktopManager).
    # services.xserver.libinput.enable = true;
    
    users.defaultUserShell = pkgs.zsh;
    
    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.karel = {
        isNormalUser = true;
        description = "Karel Schwab";
        extraGroups = [ "networkmanager" "wheel" ];
        packages = with pkgs; [
            neovim
            brave
            go
            rustup
            alacritty
        ];
    };

    programs.neovim.defaultEditor = true;
    
    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;
    
    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
        vim
        wget
        stow
        zsh
        tmux
        git
        lxappearance
        xclip
        xsel
        unzip
        gcc
        clang
        gdb
        file
        ripgrep
        fzf
        nodejs
        fd
        networkmanagerapplet
        feh
        pavucontrol
        alsa-utils
        spotify
        playerctl
    ];
    
    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };
    
    # List services that you want to enable:
    
    # Enable the OpenSSH daemon.
    # services.openssh.enable = true;
    
    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = true;
    
    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "23.11";
}
