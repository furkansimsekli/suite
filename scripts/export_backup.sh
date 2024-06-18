#!/bin/bash

set -e

DEFAULT_DESTINATION="/media/$USER/ADMIN/backup"
DEFAULT_FILES_TO_BACKUP=("/home/$USER/.ssh" "/home/$USER/.config" "/home/$USER/Documents" "/home/$USER/Pictures" "/home/$USER/.zsh_history")

echo "Default destination: $DEFAULT_DESTINATION"
read -p "Use default destination? (y/n) [y]: " use_default
if [ "$use_default" == "n" ]; then
    read -p "Enter the destination path: " - DESTINATION
else
    DESTINATION=$DEFAULT_DESTINATION
fi
echo "----------"

echo "Default files to backup:"
for i in "${!DEFAULT_FILES_TO_BACKUP[@]}"; do
    echo "$((i + 1)). ${DEFAULT_FILES_TO_BACKUP[i]}"
done
read -p "Use default files? (y/n) [y]: " use_default
if [ "$use_default" == "n" ]; then
    read -p "Enter the files to backup (space-separated): " -a FILES_TO_BACKUP
else
    FILES_TO_BACKUP=("${DEFAULT_FILES_TO_BACKUP[@]}")
fi
echo "----------"

echo "Exporting flatpak app list..."
flatpak list --app --columns=app > flatpaks.txt
FILES_TO_BACKUP+=("/home/$USER/flatpaks.txt")
echo "Flatpak app list have been exported"

echo "Exporting gnome extension list..."
gnome-extensions list > gnome_extensions.txt
FILES_TO_BACKUP+=("/home/$USER/gnome_extensions.txt")
echo "Gnome extension list have been exported"

CURRENT_DATE=$(date +"%Y-%m-%d")
HOSTNAME=$(hostname)
BACKUP_FILE="${CURRENT_DATE}-${HOSTNAME}.tar.gz"

tar -czf /tmp/${BACKUP_FILE} "${FILES_TO_BACKUP[@]}"
mv /tmp/${BACKUP_FILE} ${DESTINATION}

echo "Backup completed: ${DESTINATION}/${BACKUP_FILE}"
