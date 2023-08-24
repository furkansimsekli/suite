#!/bin/bash

set -e

echo "Changing to the /home/pi/production directory"
cd production

echo "Deleting the old project folder"
rm -rf Leakie

LATEST_VERSION=$(curl -s "https://api.github.com/repos/furkansimsekli/Leakie/releases/latest" | grep -Po '"tag_name": "\K[^"]*')
echo "Latest version found: $LATEST_VERSION"

echo "Downloading the $LATEST_VERSION..."
curl -LOJ "https://github.com/furkansimsekli/Leakie/archive/refs/tags/$LATEST_VERSION.tar.gz"

VERSION=${LATEST_VERSION#v}

echo "Extracting the archive..."
tar xzf Leakie-$VERSION.tar.gz

echo "Normalize the name of the release folder"
mv Leakie-$VERSION Leakie

cd Leakie

echo "Building the project..."
python3.10 -m venv venv && source venv/bin/activate && pip install -r requirements.txt && deactivate

echo "Restarting the service..."
sudo systemctl restart Leakie.service

echo "Cleaning the downloaded archive"
rm ../Leakie-$VERSION.tar.gz
