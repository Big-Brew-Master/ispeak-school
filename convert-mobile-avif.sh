#!/bin/bash

INPUT_DIR="./images/mobile"
TEMP_DIR="./temp-mobile-avif"

mkdir -p "$TEMP_DIR"

echo "START MOBILE AVIF CONVERSION"

for file in "$INPUT_DIR"/*.webp; do

  filename=$(basename "$file" .webp)

  echo ""
  echo "Processing: $filename"

  # webp -> png
  magick "$file" "$TEMP_DIR/$filename.png"

  # png -> avif
  avifenc \
    -q 32 \
    "$TEMP_DIR/$filename.png" \
    "$INPUT_DIR/$filename.avif"

  size=$(du -h "$INPUT_DIR/$filename.avif" | cut -f1)

  echo "Created: $filename.avif ($size)"

done

rm -rf "$TEMP_DIR"

echo ""
echo "DONE"
