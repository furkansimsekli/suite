#!/bin/bash

set -e

NC="\e[0m"
RED="\e[31m"
GREEN="\e[32m"
BROWN="\e[33m"

if [ ! -d "production" ]; then
    echo "${BROWN}Creating production directory...${NC}"
    mkdir production
fi

# Not necessarily needed for this script to work, but I don't need to create manually this way
# Sqlite file will be inside this directory
if [ ! -d ".var" ]; then
    echo -e "${BROWN}Creating .var directory...${NC}"
    mkdir .var
fi

echo -e "${BROWN}Changing to the production directory...${NC}"
cd production

echo -e "${BROWN}Deleting the old project folder...${NC}"
rm -rf pseudocontact *.tar.gz

LATEST_VERSION=$(curl -s "https://api.github.com/repos/furkansimsekli/pseudocontact/releases/latest" | grep -Po '"tag_name": "\K[^"]*')
echo -e "${GREEN}Latest version found: ${LATEST_VERSION}${NC}"

echo -e "${BROWN}Downloading the $LATEST_VERSION...${NC}"
curl -LOJ "https://github.com/furkansimsekli/pseudocontact/archive/refs/tags/$LATEST_VERSION.tar.gz"

VERSION=${LATEST_VERSION#v}

echo -e "${BROWN}Extracting the archive...${NC}"
tar xzf pseudocontact-$VERSION.tar.gz

echo -e "${BROWN}Normalizing the name of the release folder...${NC}"
mv pseudocontact-$VERSION pseudocontact

echo -e "${BROWN}Building the project...${NC}"
cd pseudocontact
python3 -m venv venv && source venv/bin/activate && pip install -r requirements.txt && deactivate

echo -e "${BROWN}Restarting the service...${NC}"
sudo systemctl restart pseudocontact.service

echo -e "${BROWN}Cleaning the downloaded archive...${NC}"
rm ../pseudocontact-$VERSION.tar.gz

echo -e "${GREEN}Success!${NC} https://t.me/pseudocontactbot"
