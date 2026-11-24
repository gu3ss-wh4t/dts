# Notes

## Linux

*Some basic fixes:*

    ```sh
    # use libayatana-appindicator to display icons (systray)
    env XDG_CURRENT_DESKTOP=Unity

    # proxy all traffic via happ or incy
    ALL_PROXY="socks5://127.0.0.1:10808 

    # disable amixer auto mute mode to switch audio port on a PC mostly
    alsamixer
    # f6 -> select a card
    # use right arrow to find the mode
    # down arrow to disable it
    # esc to exit

    # <https://4pda.to/forum/index.php?showtopic=990302&st=3900#entry120084235>
    su
    echo "options snd-intel-dspcfg dsp_driver=1" > /etc/modprobe.d/alsa.conf

    # create a /home config for snapper
    sudo snapper -c home create-config /home
    # there is a custom alias within .bashrc for snapping /home - snaphome
    sudo snapper -c home create
    ```

### Theming

    ```sh
    paru -S material-black-colors-theme
    ls /usr/share/themes ~/.themes 2>/dev/null
    gsettings set org.gnome.desktop.interface gtk-theme 'Material-Black-Plum-3.38'
    ```

/home/asc11/.var/app/org.kde.dolphin/data/color-schemes/ - For dolphin themes

### Applications

*Default app-list install:*

    ```sh
    # Base packages
    paru -Suy stow
    git clone https://github.com/gu3ss-wh4t/dats
    paru -Sy --noconfirm 7zip bat eza fastfetch keepassxc lazygit neovim starship tealdeer wikiman yazi zoxide visual-studio-code-bin happ-desktop-bin helium-browser-bin telegram-desktop ttf-cascadia-code-nerd montserrat-ttf ttf-joypixels ttf-fantasque-nerd

    # Dux shell v2.0 at the time of 30.10.26 cachyos's repo missing:
    paru -S dux-greeter-bin dux-files-bin dux-calendar-bin dux-search-bin

    # Flatpak dolphin version works fine outside the KDE environment
    # Except icon theming...
    proxy flatpak install flathub org.kde.dolphin # proxyfy flatpak as it's unable in russia LOL
    ```

*Plymouth packages*:
`paru -S plymouth-theme-cuts-alt-git plymouth-theme-hexa-retro-git plymouth-theme-square-git plymouth-theme-colorful-loop-git`
`sudo plymouth-set-default-theme` - show default theme
`sudo plymouth-set-default-theme -l` - list themes
`sudo plymouth-set-default-theme -R theme-name`: set a theme

To stow a pacman conf: ```sudo stow -t /etc -S pacman```

#### YouTube & Music Web Apps

`grep -ril "YouTube Music" ~/.local/share/applications/` - check app name
`Mod+Alt+Y hotkey-overlay-title="YouTube" { spawn "gtk-launch" "chrome-agimnkijcaahngcdmfeangaknmldooml-Default"; }` - add bind

#### Stremio

Get *aur/stremio*
Copy a *desktop* file to local dir via:
`cp /usr/share/applications/com.stremio.stremio.desktop ~/.local/share/applications/`
Change exec lines in the local desktop file to:

    ```sh
    Exec=env XDG_CURRENT_DESKTOP=Unity env QT_QPA_PLATFORM=xcb stremio %f ALL_PROXY="socks5://127.0.0.1:1080"
    TryExec=env XDG_CURRENT_DESKTOP=Unity QT_QPA_PLATFORM=xcb stremio ALL_PROXY="socks5://127.0.0.1:1080"

     # niri+noctalia cachyos doesnt open some apps by default
    env QT_QPA_PLATFORM=xcb stremio %f
    ```

### DuxShell

#### Plugins

- **Web Search plugin**:
    Custom search:
    URL - `https://www.openstreetmap.org/search?q=%s`
    ID - `openstreetmap`
    Keyword - `osm`
- **Emoji & Unicode Launcher**
- **Screenshot+**
- **

### KDE Plasma 6 Stuff

**Global Theme** - Vivid-Magna-Dark Global 6
**Colors** - Dark&Purple (stow kde)
**Window Decorations** - Infinity-Dark-Aurorae-6
**Icons** - Slot-Dark-Icons
**Cursors** - Flatbed Cursors original Black
**Splash Screen** - Rem
**Login Screen (SDDM)** - Where is my SDDM theme?
**Font** - Montserrat Alternates

> IgnorePkg = ttf-montserrat should be added to pacman.conf in order to exclude aur-font updates to montserrat-ttf, which is an alternative font from a core lib.

## Netis NX31

WRT router page - <https://openwrt.org/toh/netis/nx31>
Local WRT files route: */home/asc11/Documents/NetisNX31/*

1. Login to a router via ssh and create a backup.
2. Create a */backup* dir inside the */tmp* just in case.
3. Load WRT files to a router's /tmp:*uboot, preloader and sysupgrade*
4. Download tftp server like *dnsmasq*
5. Connect a router directly and set a static IP
6.

**Router:**

    ```sh
    # Web Interface credentials
    ssh admin@192.168.1.1 

    # Backup
    cat /dev/mtd0 | gzip -1 -c > /tmp/backup/mtd0_spi0.0.bin.gz
    cat /dev/mtd1 | gzip -1 -c > /tmp/backup/mtd1_BL2.bin.gz
    cat /dev/mtd2 | gzip -1 -c > /tmp/backup/mtd2_u-boot-env.bin.gz
    cat /dev/mtd3 | gzip -1 -c > /tmp/backup/mtd3_Factory.bin.gz
    cat /dev/mtd4 | gzip -1 -c > /tmp/backup/mtd4_FIP.bin.gz
    cat /dev/mtd5 | gzip -1 -c > /tmp/backup/mtd5_ubi.bin.gz
    ```

**All host(CachyOS):**

-O is needed as there is no sftp server installed on a router.
Also, u need to download each file separately.

    ```sh
    # Download backup files
    scp -O admin@192.168.1.1:/tmp/backup/mtd0_spi0.0.bin.gz /home/asc11/Documents/NetisNX31/backup/
    scp -O admin@192.168.1.1:/tmp/backup/mtd1_BL2.bin.gz /home/asc11/Documents/NetisNX31/backup/
    scp -O admin@192.168.1.1:/tmp/backup/mtd2_u-boot-env.bin.gz /home/asc11/Documents/NetisNX31/backup/
    scp -O admin@192.168.1.1:/tmp/backup/mtd3_Factory.bin.gz /home/asc11/Documents/NetisNX31/backup/
    scp -O admin@192.168.1.1:/tmp/backup/mtd4_FIP.bin.gz /home/asc11/Documents/NetisNX31/backup/
    scp -O admin@192.168.1.1:/tmp/backup/mtd5_ubi.bin.gz /home/asc11/Documents/NetisNX31/backup/

    # Load WRT files to a router
    scp -O ./bl31-uboot.fip admin@192.168.1.1:/tmp/
    scp -O ./preloader.bin admin@192.168.1.1:/tmp/
    scp -O ./squashfs-sysupgrade.itb admin@192.168.1.1:/tmp/

    # Get TFTP server
    sudo pacman -S dnsmasq

    # Set static IP
    nmcli connection show
    # Set the IP and Netmask
    sudo nmcli connection modify "Wired connection 1" ipv4.addresses 192.168.1.254/24
    # Set the method to manual so it doesn't try to use DHCP
    sudo nmcli connection modify "Wired connection 1" ipv4.method manual
    # Apply the changes by restarting the connection
    sudo nmcli connection up "Wired connection 1"
    ip addr show # should now show inet 192.168.1.254/24

    ip link # identify an interface name for the next command
    # Start TFTP server
    sudo dnsmasq --no-daemon --port=0 --interface=eno1 --bind-interfaces --enable-tftp --tftp-root=/home/asc11/Documents/NetisNX31/

    # Revert static IP
    sudo nmcli connection modify "Wired connection 1" ipv4.method auto ipv4.addresses ""
    sudo nmcli connection down "Wired connection 1"
    sudo nmcli connection up "Wired connection 1"

    ```
