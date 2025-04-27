#!/usr/bin/env bash

set -euo pipefail

PLUGIN_DIRS=(
  "/Library/Audio/Plug-Ins/Components"
  "$HOME/Library/Audio/Plug-Ins/Components"
  "/Library/Audio/Plug-Ins/VST"
  "$HOME/Library/Audio/Plug-Ins/VST"
  "/Library/Audio/Plug-Ins/MIDI"
  "$HOME/Library/Audio/Plug-Ins/MIDI"
)

DEST="$HOME/Downloads/barrys_plugins"
mkdir -p "$DEST"

for DIR in "${PLUGIN_DIRS[@]}"; do
  if [[ -d "$DIR" ]]; then
    echo "Backing up: $DIR"
    rsync -a --delete "$DIR" "$DEST"
  else
    echo "Plugin path not found, skipping: $DIR"
  fi
done

if [ -z "$(ls -A "$DEST")" ]; then
  rm -rf "$DEST"
  echo "No plugins were found"
else
  echo "Backup complete! Plugins are in: $DEST"
fi
