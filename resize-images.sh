#!/usr/bin/env bash

set -euo pipefail

# Usage:
#   ./resize-images.sh [max_dimension]
# Example:
#   ./resize-images.sh 1600

MAX_DIMENSION="${1:-1600}"
SOURCE_DIR="img"
OUTPUT_DIR="${SOURCE_DIR}/resized"

if ! [[ "$MAX_DIMENSION" =~ ^[0-9]+$ ]] || [ "$MAX_DIMENSION" -le 0 ]; then
  echo "Error: max_dimension must be a positive integer."
  exit 1
fi

if [ ! -d "$SOURCE_DIR" ]; then
  echo "Error: '${SOURCE_DIR}' folder not found."
  exit 1
fi

if ! command -v sips >/dev/null 2>&1; then
  echo "Error: 'sips' is not available on this system."
  exit 1
fi

mkdir -p "$OUTPUT_DIR"

count=0
for file in "$SOURCE_DIR"/*; do
  [ -f "$file" ] || continue

  ext="${file##*.}"
  ext_lower="$(printf '%s' "$ext" | tr '[:upper:]' '[:lower:]')"

  case "$ext_lower" in
    jpg|jpeg|png|webp|heic)
      out_file="$OUTPUT_DIR/$(basename "$file")"
      sips -Z "$MAX_DIMENSION" "$file" --out "$out_file" >/dev/null
      count=$((count + 1))
      ;;
  esac
done

echo "Done. Resized ${count} image(s) to max ${MAX_DIMENSION}px in '${OUTPUT_DIR}'."
