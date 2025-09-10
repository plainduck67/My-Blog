#!/usr/bin/env bash

if command -v dotnet >/dev/null 2>&1; then
    echo ".NET is already installed. Version: $(dotnet --version)"
else
    echo ".NET is not installed. Installing..."

    if [ -f /etc/debian_version ]; then
        wget https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
        sudo dpkg -i packages-microsoft-prod.deb
        sudo apt-get update
        sudo apt-get install -y apt-transport-https dotnet-sdk-8.0
        rm packages-microsoft-prod.deb
    elif [ -f /etc/redhat-release ]; then
        
        sudo dnf install -y dotnet-sdk-8.0
    else
        echo "Unsupported distro"
    fi
fi
