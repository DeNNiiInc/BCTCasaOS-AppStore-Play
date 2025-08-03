#!/usr/bin/bash

# Check if the script is run as root
if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as root." 1>&2
    exit 1
fi

clear
echo '
   _____                 ____   _____   _   _               ____  _
  / ____|               / __ \ / ____| | \ | |             |  _ \(_)
 | |     __ _ ___  __ _| |  | | (___   |  \| | _____      _| |_) |_  ___
 | |    / _` / __|/ _` | |  | |\___ \  | . ` |/ _ \ \ /\ / /  _ <| |/ _ \
 | |___| (_| \__ \ (_| | |__| |____) | | |\  |  __/\ V  V /| |_) | |  __/
  \_____\__,_|___/\__,_|\____/|_____/  |_| \_|\___| \_/\_/ |____/|_|\___|

 By: clueless little brother, pig brother, Cp0204 @ CasaOS Club

 Welcome to the CasaOS Newbie Helper Script
 bash <(wget -qO- https://play.cuse.eu.org/casaos_newbie.sh)
'

chenge_linuxmirrors() {
    echo "> Change system software sources"
    bash <(curl -sSL https://linuxmirrors.cn/main.sh)
}

# Update system software
update_softwares() {
    echo "> Update system software"
    apt update && apt -y upgrade
    if [ $? -eq 0 ]; then
        echo "System software updated."
    else
        echo "Warning: An error occurred while updating software!"
    fi

    # Define the array of packages to install
    packages=("sudo" "curl" "procps")

    # Check if any packages need to be installed
    need_install=false
    for package in "${packages[@]}"; do
        if ! dpkg -l | grep -q "^ii  $package"; then
            need_install=true
            break
        fi
    done

    # Ask user to install packages
    if $need_install; then
        echo "> The following common packages will be installed (if not already present)"
        echo "- curl (for network transfer)"
        echo "- sudo (for privilege management)"
        echo "- procps (for viewing process information)"
        read -p "Continue? (Y/n): " choice
        [[ -z "${INPUT}" ]] && INPUT=Y
        case "$choice" in
        [Yy] | [Yy][Ee][Ss])
            # Install packages and handle exceptions
            for package in "${packages[@]}"; do
                # Check if package is already installed
                if dpkg -l | grep -q "^ii  $package"; then
                    echo "$package is already installed, skipping"
                else
                    echo "Installing $package..."
                    apt-get install -y "$package"
                fi
            done
            # Check if packages were installed successfully
            for package in "${packages[@]}"; do
                if dpkg -l | grep -q "^ii  $package"; then
                    echo "$package installed successfully."
                else
                    echo "Warning: $package installation failed!"
                fi
            done
            ;;
        n | N) exit 0 ;;
        *) echo "Invalid input, please try again." && update_softwares ;;
        esac
    else
        echo "> All common packages are already installed."
    fi
}

# Define function to install CasaOS
install_casaos() {
    echo "> Install CasaOS"
    # Install CasaOS (confirm user choice)
    read -p "CasaOS installation script will be executed, continue? [Y/n]: " choice
    [[ -z "${choice}" ]] && choice=Y
    if [ "$choice" = "y" -o "$choice" = "Y" ]; then
        echo "Starting CasaOS installation..."
        sudo bash -c "$(wget -qO- https://play.cuse.eu.org/get_casaos.sh)"
    else
        echo "CasaOS installation cancelled."
    fi
}

# Define function to configure IPv6
configure_ipv6() {
    echo "> Configure IPv6"
    # Check if IPv6 is enabled
    ipv6_enabled=$(/sbin/sysctl -n net.ipv6.conf.all.disable_ipv6)
    if [ "$ipv6_enabled" -ne 0 ]; then
        echo "IPv6 is not enabled, please check network configuration."
        exit 1
    fi
    # Get NAS IPv6 subnet
    ipv6_subnet=$(ip -6 route show | grep -v "fe80" | /usr/bin/awk '{ print $1 }' | head -n 1)
    if [ -z "$ipv6_subnet" ]; then
        echo "Failed to obtain IPv6 subnet, please specify manually."
        exit 3
    fi
    echo "Detected IPv6 subnet: $ipv6_subnet"
    # Edit Docker config file
    docker_config="/etc/docker/daemon.json"
    # Check if daemon.json exists, if not create an empty config file
    if [ ! -f "$docker_config" ]; then
        echo "{}" >$docker_config # Create an empty JSON file
        echo "daemon.json not found, created empty file."
    fi
    # Backup original config file, use date/time for multiple backups
    backup_file="${docker_config}-backup-$(date +'%Y-%m-%d_%H-%M-%S')"
    cp $docker_config $backup_file
    echo "Current config backed up to $backup_file"
    # Update config
    echo "Updating Docker IPv6 configuration..."
    /usr/bin/jq '. + {ipv6: true, "fixed-cidr-v6": "'$ipv6_subnet'", experimental: true, ip6tables: true}' $docker_config >"${docker_config}.tmp" && mv "${docker_config}.tmp" $docker_config
    if [ $? -ne 0 ]; then
        echo "Failed to update config, please ensure jq is installed."
        exit 4
    fi
    # Restart Docker service, adjust as needed for your NAS
    echo "Restarting Docker service..."
    sudo systemctl restart docker
    if [ $? -eq 0 ]; then
        echo "Docker service restarted successfully."
    else
        echo "Docker service restart failed, please restart manually."
        exit 5
    fi
    echo "Configuration complete. Please run 'docker network inspect bridge' to verify docker configuration."
}

# Define function to disable auto-sleep
disable_autosleep() {
    echo "Disable auto-sleep"
    # Ask user whether to disable auto-sleep
    read -p "Do you want to disable Debian auto-sleep? (y/n) " user_choice
    if [ "$user_choice" = "y" -o "$user_choice" = "Y" ]; then
        echo "Disabling Debian auto-sleep, please wait..."

        # Backup /etc/systemd/logind.conf
        sudo cp /etc/systemd/logind.conf /etc/systemd/logind.conf.bak
        if [ $? -eq 0 ]; then
            echo "File backed up as /etc/systemd/logind.conf.bak."
        else
            echo "Warning: Failed to backup /etc/systemd/logind.conf!"
        fi

        # Modify login manager config to disable auto-sleep
        for config_line in 'HandleLidSwitch=ignore' 'HandleLidSwitchDocked=ignore' 'HandleLidSwitchExternalPower=ignore' 'IdleAction=ignore' 'IdleActionSec=0'; do
            echo $config_line | sudo tee -a /etc/systemd/logind.conf
        done
        if [ $? -eq 0 ]; then
            echo "Login manager config file modified successfully."

            # Verify config applied
            for config_check in 'HandleLidSwitch=ignore' 'HandleLidSwitchDocked=ignore' 'HandleLidSwitchExternalPower=ignore' 'IdleAction=ignore' 'IdleActionSec=0'; do
                grep_result=$(grep -x "$config_check" /etc/systemd/logind.conf)
                if [ -z "$grep_result" ]; then
                    echo "Warning: '$config_check' not found in /etc/systemd/logind.conf, please check manually."
                fi
            done
        else
            echo "Warning: Failed to modify login manager config file!"
        fi

        # Restart login manager service to apply changes
        sudo systemctl restart systemd-logind
        if [ $? -eq 0 ]; then
            echo "Login manager service restarted, auto-sleep disabled."
        else
            echo "Warning: Failed to restart login manager service, auto-sleep may not be disabled."
        fi
    else
        echo "Auto-sleep remains enabled. To disable, rerun this script and select y."
    fi
}

# Set default language to Chinese
set_locales() {
    # Update package info
    apt update
    # Install language pack
    apt install -y locales
    # Configure Chinese environment
    sed -i '/zh_CN.UTF-8/s/^# //g' /etc/locale.gen
    locale-gen zh_CN.UTF-8
    # Set default language to Chinese
    update-locale LANG=zh_CN.UTF-8
    echo "Language set to Chinese. A reboot may be required."
    read -p "Do you want to reboot now? (y/n) " user_choice
    if [ "$user_choice" = "y" -o "$user_choice" = "Y" ]; then
        reboot
    else
        echo "Reboot cancelled. Please reboot manually if needed."
    fi
}

# Docker network optimization
docker_network_optimization() {
    echo "> Docker network optimization"
    # Get current Docker settings
    docker_info=$(sudo docker info)
    http_proxy=$(echo "$docker_info" | grep 'HTTP Proxy' | awk -F ': ' '{print $2}')
    https_proxy=$(echo "$docker_info" | grep 'HTTPS Proxy' | awk -F ': ' '{print $2}')
    no_proxy=$(echo "$docker_info" | grep 'No Proxy' | awk -F ': ' '{print $2}')
    registry_mirrors=$(echo "$docker_info" | grep 'Registry Mirrors' -A 1 | tail -n 1 | sed 's/  //')
    echo "==========Current Docker Settings=============="
    echo "Proxy:"
    echo "- HTTP Proxy: $http_proxy"
    echo "- HTTPS Proxy: $https_proxy"
    echo "- No Proxy: $no_proxy"
    echo ""
    echo "Docker Registry Mirrors:"
    echo "- $registry_mirrors"
    echo "=============================================="
    echo "Please select a network optimization method (choose one):"
    echo "1. Set Docker proxy"
    echo "2. Change Docker Registry mirror"
    echo "q. Quit"

    read -p "Choice: " choice
    case "$choice" in
    1)
        set_docker_proxy
        ;;
    2)
        switch_docker_source
        ;;
    "q")
        return
        ;;
    *)
        echo "Invalid selection, exiting"
        return
        ;;
    esac

    # Ask whether to restart docker
    if [ "$choice" = "1" -o "$choice" = "2" ]; then
        read -p "Restart docker service to apply changes now? (Y/n): " choice
        [[ -z "${choice}" ]] && choice=Y
        case "$choice" in
        [Yy] | [Yy][Ee][Ss])
            sudo systemctl restart docker
            echo "Docker service restarted."
            ;;
        *)
            echo "Docker service not restarted."
            ;;
        esac
    fi
    read -s -n1 -p "Press any key to continue... "
}

set_docker_proxy() {
    # Default parameters
    DEFAULT_PROXY="127.0.0.1:10809"
    DEFAULT_NO_PROXY="localhost,127.0.0.1,.example.com"

    echo -e "> Set proxy for Docker. Leave blank to cancel proxy, q to quit"

    # Get user input for proxy address
    read -p "Enter HTTP proxy address (e.g. ${DEFAULT_PROXY}): " HTTP_PROXY
    HTTP_PROXY=${HTTP_PROXY:-""}
    if [ "$HTTP_PROXY" = "q" ]; then
        return
    fi

    read -p "Enter HTTPS proxy address (default same as HTTP proxy ${HTTP_PROXY}): " HTTPS_PROXY
    HTTPS_PROXY=${HTTPS_PROXY:-$HTTP_PROXY}

    read -p "Enter hosts/domains not to proxy, separated by commas (default ${DEFAULT_NO_PROXY}): " NO_PROXY
    NO_PROXY=${NO_PROXY:-$DEFAULT_NO_PROXY}

    # Determine if proxy should be cancelled
    if [ -z "$HTTP_PROXY" ] && [ -z "$HTTPS_PROXY" ]; then
        sudo rm -f /etc/systemd/system/docker.service.d/proxy.conf
        echo "Docker proxy settings cancelled."
    else
        sudo mkdir -p /etc/systemd/system/docker.service.d
        echo "[Service]
Environment=\"HTTP_PROXY=http://$HTTP_PROXY\"
Environment=\"HTTPS_PROXY=http://$HTTPS_PROXY\"
Environment=\"NO_PROXY=$NO_PROXY\"" | sudo tee /etc/systemd/system/docker.service.d/proxy.conf
        echo "Docker proxy settings updated:"
        echo "  - HTTP_PROXY:  $HTTP_PROXY"
        echo "  - HTTPS_PROXY: $HTTPS_PROXY"
        echo "  - NO_PROXY:    $NO_PROXY"
    fi
    sudo systemctl daemon-reload
}

switch_docker_source() {
    echo "> Switch Docker registry mirror"
    # bash <(curl -sSL https://linuxmirrors.cn/docker.sh)
    bash <(curl -sSL https://gitee.com/xjxjin/scripts/raw/main/check_docker_registry.sh)
}

disk_usage() {
    echo "> Disk usage analysis"
    # Check if gdu command exists.
    command -v gdu >/dev/null 2>&1 || {
        # Ask user to install
        read -r -p "gdu command not found. Install? [Y/n]" INPUT
        [[ -z "${INPUT}" ]] && INPUT=Y
        case "$INPUT" in
        [Yy] | [Yy][Ee][Ss])
            # Install gdu
            apt-get update && apt-get install -y gdu # Debian/Ubuntu
            # yum install -y gdu # CentOS/RHEL
            ;;
        *)
            echo "gdu installation cancelled, cannot analyze"
            return 1
            ;;
        esac
    }
    # Input directory to analyze
    read -r -p "Enter directory to analyze (default /): " target_dir
    target_dir="${target_dir:-/}"
    # Use gdu to analyze disk usage.
    gdu "$target_dir"
}

# Script entry point
if [ $# -gt 0 ]; then
    # If there are command line arguments, execute the corresponding function directly
    function_name="$1"
    echo "Directly entering sub-function $function_name , for more options please run the above command"
    echo ">"
    shift
    $function_name "$@"
else
    echo ""
    echo "Most operations in this script are based on Debian 12. Tutorial: https://post.smzdm.com/p/a607edoe"
    while true; do
        echo ""
        echo "Please select a function:"
        echo "1. Change system software sources"
        echo "2. Update system software"
        echo "3. Install CasaOS (optimized for China)"
        echo "4. Configure IPv6"
        echo "5. Disable auto-sleep"
        echo "6. Set system language to Chinese"
        echo "7. Docker network optimization"
        echo "8. Disk usage analysis"
        echo "q. Quit"
        echo ""
        read -p "Enter function number: " input
        case $input in
        1) chenge_linuxmirrors ;;
        2) update_softwares ;;
        3) install_casaos ;;
        4) configure_ipv6 ;;
        5) disable_autosleep ;;
        6) set_locales ;;
        7) docker_network_optimization ;;
        8) disk_usage ;;
        'q') break ;;
        *) ;;
        esac
    done
fi
echo "Script execution complete"