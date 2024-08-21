#!/bin/bash

# Copyright © 20XX Flames Co. All rights reserved.

# Define local and iCloud directories
LOCAL_DIR="$HOME"
ICLOUD_DIR="$HOME/Library/Mobile Documents"

# List of directories to move
DIRS=("Documents" "Desktop" "Downloads" "Pictures" "Music" "Movies")

# Move directories and create symbolic links
for dir in "${DIRS[@]}"; do
    LOCAL_PATH="$LOCAL_DIR/$dir"
    ICLOUD_PATH="$ICLOUD_DIR/$dir"

    # Check if the directory exists
    if [ -d "$LOCAL_PATH" ]; then
        # Skip if symbolic link already exists
        if [ -L "$LOCAL_PATH" ]; then
            echo "Symbolic link $LOCAL_PATH already exists. Skipping link creation."
            continue
        fi

        # Handle directory move
        if [ -d "$ICLOUD_PATH" ]; then
            echo "Directory $ICLOUD_PATH already exists. Skipping move for $dir."
        else
            mv "$LOCAL_PATH" "$ICLOUD_DIR/"
            if [ $? -eq 0 ]; then
                echo "Successfully moved $dir to iCloud."
            else
                echo "Failed to move $dir. Skipping..."
                continue
            fi
        fi

        # Create a symbolic link from the original location to the new location
        ln -s "$ICLOUD_PATH" "$LOCAL_PATH"
        if [ $? -eq 0 ]; then
            echo "Created symbolic link for $dir."
        else
            echo "Failed to create symbolic link for $dir."
        fi
    else
        echo "Directory $LOCAL_PATH does not exist. Skipping..."
    fi
done

echo "Directories moved and linked to iCloud."
