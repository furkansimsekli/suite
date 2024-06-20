#!/bin/bash

set -e

FLATPAK_LIST_FILE="flatpaks.txt"

if ! command -v flatpak &> /dev/null; then
    echo "Error: Flatpak is not installed. Please install Flatpak first."
    exit 1
else
    flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
fi

if [ ! -f "$FLATPAK_LIST_FILE" ]; then
    echo "Error: The file $PACKAGE_FILE does not exist."
    exit 1
fi

echo "Installing Flatpak packages..."
while IFS= read -r package; do
    echo "Installing $package..."
    flatpak install flathub -y "$package"
    if [ $? -eq 0 ]; then
        echo "Successfully installed $package."
    else
        echo "Failed to install $package."
    fi
done < "$FLATPAK_LIST_FILE"

echo "Flatpak installation complete."
