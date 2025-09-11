#!/usr/bin/env bash
set -e

if ! command -v dotnet >/dev/null 2>&1; then
    echo ".NET not found, installing..."
    if [ -f /etc/debian_version ]; then
        wget https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
        sudo dpkg -i packages-microsoft-prod.deb
        sudo apt-get update
        sudo apt-get install -y apt-transport-https dotnet-sdk-8.0
        rm packages-microsoft-prod.deb
    elif [ -f /etc/redhat-release ]; then
        sudo dnf install -y dotnet-sdk-8.0
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        if ! command -v brew >/dev/null 2>&1; then
            echo "Homebrew not found. Installing Homebrew first..."
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        fi
        brew install --cask dotnet-sdk
    else
        echo "Unsupported distro. Install .NET manually."
        exit 1
    fi
fi


if ! command -v git >/dev/null 2>&1; then
    echo "Git not found, installing..."
    if [ -f /etc/debian_version ]; then
        sudo apt-get install -y git
    elif [ -f /etc/redhat-release ]; then
        sudo dnf install -y git
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        
        if ! command -v brew >/dev/null 2>&1; then
            echo "Homebrew not found. Installing Homebrew first..."
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        fi
        brew install git
    else
        echo "Unsupported distro. Install Git manually."
        exit 1
    fi
fi


cd ~
rm -rf sorter
mkdir sorter
cd sorter

git clone https://github.com/plainduck67/fileSorter
cd fileSorter/sorter

dotnet build || true


read -p "What would you like to sort (photos, music, videos)? " target


dotnet run -- --"$target"
