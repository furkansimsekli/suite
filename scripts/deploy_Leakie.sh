#!/bin/bash

set -e

NC="\e[0m"
RED="\e[31m"
GREEN="\e[32m"
BROWN="\e[33m"

if [ ! -d "production" ]; then
    echo -e "${BROWN}Creating production directory...${NC}"
    mkdir production
fi

echo -e "${BROWN}Changing to the production directory...${NC}"
cd production

echo -e "${BROWN}Deleting the old project files...${NC}"
rm -rf Leakie *.tar.gz

LATEST_VERSION=$(curl -s "https://api.github.com/repos/furkansimsekli/Leakie/releases/latest" | grep -Po '"tag_name": "\K[^"]*')
echo -e "${GREEN}Latest version found: ${LATEST_VERSION}${NC}"

echo -e "${BROWN}Downloading the $LATEST_VERSION...${NC}"
curl -LOJ "https://github.com/furkansimsekli/Leakie/archive/refs/tags/$LATEST_VERSION.tar.gz"

VERSION=${LATEST_VERSION#v}

echo -e "${BROWN}Extracting the archive...${NC}"
tar xzf Leakie-$VERSION.tar.gz

echo -e "${BROWN}Normalizing the name of the release folder...${NC}"
mv Leakie-$VERSION Leakie

echo -e "${BROWN}Building the project...${NC}"
cd Leakie
python -m venv venv && source venv/bin/activate && pip install -r requirements.txt && deactivate

echo -e "${BROWN}Restarting the service...${NC}"
# I don't know if there is a case where the system disables the service
# itself, so I put this command just in case.
sudo systemctl enable Leakie.service
sudo systemctl restart Leakie.service

echo -e "${BROWN}Cleaning the downloaded archive...${NC}"
rm ../Leakie-$VERSION.tar.gz

echo -e "${GREEN}Success!${NC} https://t.me/LeakieBot"
