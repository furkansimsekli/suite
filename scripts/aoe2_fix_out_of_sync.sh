#!/bin/bash

set -e

cd "/home/$USER/.steam/steam/steamapps/compatdata/813780/pfx/drive_c/windows/system32/"

if [ -f "vc_redist.x64.exe" ]; then
    echo "File vc_redist.x64.exe already exists."
else
    echo "File vc_redist.x64.exe not found. Downloading..."
    wget -q "https://download.microsoft.com/download/9/3/F/93FCF1E7-E6A4-478B-96E7-D4B285925B00/vc_redist.x64.exe"
fi

echo "Extracting vc_redist.x64.exe using cabextract..."
sudo cabextract vc_redist.x64.exe

echo "Extracting 'a10' using cabextract..."
sudo cabextract a10

