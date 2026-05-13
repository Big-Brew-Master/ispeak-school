#!/bin/bash

INPUT_DIR="./images/desktop"
TEMP_DIR="./temp-avif"

mkdir -p "$TEMP_DIR"

echo "START AVIF CONVERSION"

for file in "$INPUT_DIR"/*.webp; do

  filename=$(basename "$file" .webp)

  echo ""
  echo "Processing: $filename"

  # convert webp -> png
  magick "$file" "$TEMP_DIR/$filename.png"

  # png -> avif
  avifenc \
    -q 38 \
    "$TEMP_DIR/$filename.png" \
    "$INPUT_DIR/$filename.avif"

  size=$(du -h "$INPUT_DIR/$filename.avif" | cut -f1)

  echo "Created: $filename.avif ($size)"

done

rm -rf "$TEMP_DIR"

echo ""
echo "DONE"
