#!/bin/bash

# ============================================
# MOBILE IMAGE OPTIMIZER FOR TILDA LANDING
# ============================================

# REQUIREMENTS:
# brew install webp imagemagick
#
# RUN:
# chmod +x optimize.sh
# ./optimize.sh
# ============================================

# folders
INPUT_DIR="./images"
MOBILE_DIR="./images/mobile"
DESKTOP_DIR="./images/desktop"

# create folders
mkdir -p "$MOBILE_DIR"
mkdir -p "$DESKTOP_DIR"

echo "====================================="
echo "START IMAGE OPTIMIZATION"
echo "====================================="

# loop all webp
for file in "$INPUT_DIR"/*.webp; do

  filename=$(basename "$file")

  echo ""
  echo "Processing: $filename"

  # ----------------------------------
  # MOBILE VERSION
  # ----------------------------------
  # width: 768px
  # quality: 65
  # aggressive compression

  magick "$file" \
    -resize 768x \
    -strip \
    -quality 65 \
    "$MOBILE_DIR/$filename"

  # re-compress with cwebp
  cwebp \
    -q 60 \
    -m 6 \
    -af \
    "$MOBILE_DIR/$filename" \
    -o "$MOBILE_DIR/$filename" >/dev/null 2>&1

  # ----------------------------------
  # DESKTOP VERSION
  # ----------------------------------
  # width: 1600px
  # quality: 78

  magick "$file" \
    -resize 1600x \
    -strip \
    -quality 78 \
    "$DESKTOP_DIR/$filename"

  cwebp \
    -q 75 \
    -m 6 \
    -af \
    "$DESKTOP_DIR/$filename" \
    -o "$DESKTOP_DIR/$filename" >/dev/null 2>&1

  # show sizes
  mobile_size=$(du -h "$MOBILE_DIR/$filename" | cut -f1)
  desktop_size=$(du -h "$DESKTOP_DIR/$filename" | cut -f1)

  echo "Mobile : $mobile_size"
  echo "Desktop: $desktop_size"

done

echo ""
echo "====================================="
echo "DONE"
echo "====================================="
echo ""
echo "Files created:"
echo "./images/mobile/"
echo "./images/desktop/"
echo ""
