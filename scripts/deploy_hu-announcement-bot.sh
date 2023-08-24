#!/bin/bash

set -e

echo "Changing to the /home/hu-announcement directory"
cd /home/hu-announcement

echo "Deleting the old project folder"
rm -rf hu-announcement-bot

LATEST_VERSION=$(curl -s "https://api.github.com/repos/hacettepeoyt/hu-announcement-bot/releases/latest" | grep -Po '"tag_name": "\K[^"]*')
echo "Latest version found: $LATEST_VERSION"

echo "Downloading the $LATEST_VERSION..."
curl -LOJ "https://github.com/hacettepeoyt/hu-announcement-bot/archive/refs/tags/$LATEST_VERSION.tar.gz"

VERSION=${LATEST_VERSION#v}

echo "Extracting the archive..."
tar xzf hu-announcement-bot-$VERSION.tar.gz

echo "Normalize the name of the release folder"
mv hu-announcement-bot-$VERSION hu-announcement-bot

cd hu-announcement-bot

echo "Building the project..."
make

echo "Restarting the service..."
doas systemctl restart huannouncementbot.service

echo "Cleaning the downloaded archive"
rm ../hu-announcement-bot-$VERSION.tar.gz
