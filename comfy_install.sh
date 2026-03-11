#!/bin/bash
set -e

echo "Installing missing ComfyUI nodes..."

cd /workspace/ComfyUI/custom_nodes

clone_or_pull () {
if [ -d "$1/.git" ]; then
git -C "$1" pull
else
git clone "$2" "$1"
fi
}

# TinyTerra nodes (TSColorMatch, TSPoseDataSmoother и т.д.)

clone_or_pull "ComfyUI_tinyterraNodes" "https://github.com/TinyTerra/ComfyUI_tinyterraNodes.git"

# Video helper suite

clone_or_pull "ComfyUI-VideoHelperSuite" "https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite.git"

echo "Installing dependencies..."

find /workspace/ComfyUI/custom_nodes -maxdepth 2 -name requirements.txt -print0 | while IFS= read -r -d '' req; do
pip install -r "$req"
done

echo "Nodes installed successfully"
