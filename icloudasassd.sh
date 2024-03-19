#!/bin/bash

# Copyright © 20XX Flames Co. All rights reserved.

# Define local and iCloud directories
LOCAL_DIR="$HOME"
ICLOUD_DIR="$HOME/Library/Mobile Documents"

# List of directories to move
DIRS=("Documents" "Desktop" "Downloads" "Pictures" "Music" "Movies")

# Move directories and create symbolic links
for dir in "${DIRS[@]}"; do
    # Move each directory to iCloud
    if [ -d "$LOCAL_DIR/$dir" ]; then
        mv "$LOCAL_DIR/$dir" "$ICLOUD_DIR/"
    fi

    # Create a symbolic link from the original location to the new location in iCloud
    ln -s "$ICLOUD_DIR/$dir" "$LOCAL_DIR/$dir"
done

echo "Directories moved and linked to iCloud."
