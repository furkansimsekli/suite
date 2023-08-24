#!/bin/bash

set -e

echo "Changing to the /home/pi/production directory"
cd production

echo "Deleting the old project folder"
rm -rf konyaticaretborsasi-bot

LATEST_VERSION=$(curl -s "https://api.github.com/repos/furkansimsekli/konyaticaretborsasi-bot/releases/latest" | grep -Po '"tag_name": "\K[^"]*')
echo "Latest version found: $LATEST_VERSION"

echo "Downloading the $LATEST_VERSION..."
curl -LOJ "https://github.com/furkansimsekli/konyaticaretborsasi-bot/archive/refs/tags/$LATEST_VERSION.tar.gz"

VERSION=${LATEST_VERSION#v}

echo "Extracting the archive..."
tar xzf konyaticaretborsasi-bot-$VERSION.tar.gz

echo "Normalize the name of the release folder"
mv konyaticaretborsasi-bot-$VERSION konyaticaretborsasi-bot

cd konyaticaretborsasi-bot

echo "Building the project..."
python3.10 -m venv venv && source venv/bin/activate && pip install -r requirements.txt && deactivate

echo "Restarting the service..."
sudo systemctl restart konyaticaretborsasi-bot.service

echo "Cleaning the downloaded archive"
rm ../konyaticaretborsasi-bot-$VERSION.tar.gz
