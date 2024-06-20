#!/bin/bash

set -e

NC="\e[0m"
RED="\e[31m"
GREEN="\e[32m"
BROWN="\e[33m"

if ! command -V curl &> /dev/null; then
    echo -e "${RED}ERROR:${NC} curl is not installed"
    exit 1
fi

if ! command -V python &> /dev/null; then
    echo -e "${RED}ERROR:${NC} python is not installed, please install >3.10"
    exit 1
fi

if [ ! -d "production" ]; then
    echo -e "${BROWN}Creating production directory...${NC}"
    mkdir production
fi

echo -e "${BROWN}Changing to the production directory...${NC}"
cd production

echo -e "${BROWN}Deleting the old project files...${NC}"
rm -rf konyaticaretborsasi-bot

LATEST_VERSION=$(curl -s "https://api.github.com/repos/furkansimsekli/konyaticaretborsasi-bot/releases/latest" | grep -Po '"tag_name": "\K[^"]*')
echo -e "${GREEN}Latest version found: ${LATEST_VERSION}${NC}"

echo -e "${BROWN}Downloading the $LATEST_VERSION...${NC}"
curl -LOJ "https://github.com/furkansimsekli/konyaticaretborsasi-bot/archive/refs/tags/$LATEST_VERSION.tar.gz"

VERSION=${LATEST_VERSION#v}

echo -e "${BROWN}Extracting the archive...${NC}"
tar xzf konyaticaretborsasi-bot-$VERSION.tar.gz

echo -e "${BROWN}Normalizing the name of the release folder...${NC}"
mv konyaticaretborsasi-bot-$VERSION konyaticaretborsasi-bot

echo -e "${BROWN}Building the project...${NC}"
cd konyaticaretborsasi-bot
python -m venv venv && source venv/bin/activate && pip install -r requirements.txt && deactivate

echo -e "${BROWN}Restarting the service...${NC}"
sudo systemctl restart konyaticaretborsasi-bot.service

echo -e "${BROWN}Cleaning the downloaded archive...${NC}"
rm ../konyaticaretborsasi-bot-$VERSION.tar.gz

echo -e "${GREEN}Success!${NC} https://t.me/konyaticaretborsasi_bot"
