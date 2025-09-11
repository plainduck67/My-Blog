#!/usr/bin/env bash

set -e

if command -v dotnet >/dev/null 2>&1; then
    echo ".NET is already installed. Version: $(dotnet --version)"
else
    if [ -f /etc/debian_version ]; then
        wget https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
        sudo dpkg -i packages-microsoft-prod.deb
        sudo apt-get update
        sudo apt-get install -y apt-transport-https dotnet-sdk-8.0
        rm packages-microsoft-prod.deb
    elif [ -f /etc/redhat-release ]; then
        sudo dnf install -y dotnet-sdk-8.0
    else
        echo "Unsupported distro. Install .NET manually."
        exit 1
    fi
fi

if command -v git >/dev/null 2>&1; then
    echo "Git is already installed."
else
    if [ -f /etc/debian_version ]; then
        sudo apt-get update
        sudo apt-get install -y git
    elif [ -f /etc/redhat-release ]; then
        sudo dnf install -y git
    else
        echo "Unsupported distro. Install Git manually."
        exit 1
    fi
fi

cd ~
mkdir sorter
cd sorter
git clone https://github.com/plainduck67/fileSorter
cd fileSorter
cd sorter
read -p "What would you like to sort, photos, music or videos?" target
dotnet run -- --"$target"

