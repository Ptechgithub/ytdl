#!/bin/bash

#colors
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
blue='\033[0;34m'
purple='\033[0;35m'
cyan='\033[0;36m'
white='\033[0;37m'
rest='\033[0m'

detect_distribution() {
    # Detect the Linux distribution
    local supported_distributions=("ubuntu" "debian" "centos" "fedora")
    
    if [ -f /etc/os-release ]; then
        source /etc/os-release
        if [[ "${ID}" = "ubuntu" || "${ID}" = "debian" || "${ID}" = "centos" || "${ID}" = "fedora" ]]; then
            PM="apt-get"
            [ "${ID}" = "centos" ] && PM="yum"
            [ "${ID}" = "fedora" ] && PM="dnf"
        else
            echo "Unsupported distribution!"
            exit 1
        fi
    else
        echo "Unsupported distribution!"
        exit 1
    fi
}

check_dependencies() {
    detect_distribution

    local dependencies=("git" "python3" "ffmpeg" "aria2" "python3-pip")
    
    for dep in "${dependencies[@]}"; do
        if ! command -v "${dep}" &> /dev/null; then
            echo "${dep} is not installed. Installing..."
            "${PM}" update && "${PM}" upgrade -y
            "${PM}" install "${dep}" -y
            
        fi
    done
}

inputs() {
    clear

    read -p "Please enter Telegram APP_ID: " APP_ID
    sed -i "s/APP_ID: int = int(os.getenv(\"APP_ID\", A))/APP_ID: int = int(os.getenv(\"APP_ID\", $APP_ID))/" config.py

    read -p "Please enter Telegtam APP_HASH: " APP_HASH
    sed -i "s/APP_HASH = os.getenv(\"APP_HASH\", \"B\")/APP_HASH = os.getenv(\"APP_HASH\", \"$APP_HASH\")/" config.py

    read -p "Please enter Telegram Bot TOKEN: " TOKEN
    sed -i "s/TOKEN = os.getenv(\"TOKEN\", \"C\")/TOKEN = os.getenv(\"TOKEN\", \"$TOKEN\")/" config.py
    
    read -p "Please enter the number of free downloads [default : 20] : " FREE_DOWNLOAD
    sed -i "s/FREE_DOWNLOAD = os.getenv(\"FREE_DOWNLOAD\", 20)/FREE_DOWNLOAD = os.getenv(\"FREE_DOWNLOAD\", $FREE_DOWNLOAD)/" config.py
}

#install
install() {
    if ! systemctl is-active --quiet ytdl.service; then
        check_dependencies
        git clone https://github.com/Ptechgithub/ytdl.git
        cd ytdl
        pip3 install -r requirements.txt
        inputs
        service
    else
        echo "The ytdl service is already installed"
    fi
}

service() {
    cat <<EOL > /etc/systemd/system/ytdl.service
[Unit]
Description=YouTube Downloader Service
After=network.target

[Service]
WorkingDirectory=/root/ytdl
ExecStart=python3 /root/ytdl/ytdl_bot.py
Restart=always

[Install]
WantedBy=multi-user.target
EOL

    systemctl daemon-reload
    systemctl enable ytdl.service
    systemctl start ytdl.service
}

uninstall() {
    if systemctl is-active --quiet ytdl.service; then
        systemctl stop ytdl.service
        systemctl disable ytdl.service
        rm /etc/systemd/system/ytdl.service
        systemctl daemon-reload
        rm -rf /root/ytdl
    else
        echo "ytdl is not installed."
    fi
}

check_ytdl_status() {
    # Check the status of the ytdl service
    if sudo systemctl is-active --quiet ytdl.service; then
        echo -e "${yellow}YouTube Downloader is: ${green} [running ✔]${rest}"
    else
        echo -e "${yellow}ytdl is:${red} [Not running ✗ ]${rest}"
    fi
}

#Termux
install_termux() {
    bash <(curl -fsSL https://raw.githubusercontent.com/Ptechgithub/ytdl/main/termux/install.sh)
}

# Main menu
clear
echo -e "${cyan}By --> Peyman * Github.com/Ptechgithub * ${rest}"
check_ytdl_status
echo -e "${yellow} ----YouTube downloader Telegram bot---- ${rest}"
echo -e "${green}1) Install on server${rest}"
echo -e "${red}2) Uninstall${rest}"
echo -e "${yellow} ----------------------------------------- ${rest}"
echo -e "${green}3) Install on Termux${rest}"
echo -e "${yellow} ----------------------------------------- ${rest}"
echo -e "${yellow}0) Exit${rest}"
read -p "Please choose: " choice

case $choice in
    1)
        install
        ;;
    2)
        uninstall
        ;;
    3)
        install_termux
        ;;
    0)   
        exit
        ;;
    *)
        echo "Invalid choice. Please try again."
        ;;
esac
