#!/usr/bin/env sh -e

# Clean up of unused files assets and move into .unused folder
# Remember repository root (where this script was invoked)
REPO_ROOT=$(pwd)
PLATFORM=$1
if [ "$#" -eq 0 ]; then
    # Default behavior: go to `game`, read unused files list)
    # and move matches into ../.unused
    if [ ! -d "game" ]; then
        echo "game directory not found; cannot perform default clean."
    fi
    echo "Usage: ./clean.sh [android|ios|web|desktop]"
    echo This will clean common unused assets after platform target.
    echo Experimental script clean HAHCF game assets.
    echo "(C) 2026 Martin Eesmaa (MIT License)"
    exit 1
fi

echo "Cleaning unused files for: $PLATFORM"

# Backwards-compatible platform-based cleanup (basic heuristics)
if [ "$PLATFORM" = "android" ]; then
    # Android: move ogv files and swap mp4s
    UNUSED_FILES=("*.ogv")
elif [ "$PLATFORM" = "ios" ] || [ "$PLATFORM" = "web" ]; then
    # iOS/web: move ogv files and swap mp4s
    UNUSED_FILES=("*.ogv")
elif [ "$PLATFORM" = "desktop" ]; then
    # Desktop: keep ogv files, move all mp4s only
    UNUSED_FILES=()
else
    echo "Unknown platform: $PLATFORM"
    echo "Usage: ./clean.sh [android|ios|web|desktop]"
    exit 1
fi

# Move matched files or directories into .unused/ (operate only within `game`)
TARGET="$REPO_ROOT/.unused"
mkdir -p "$TARGET"
if [ "$PLATFORM" = "android" ]; then
    echo "Android swap: first restoring all MP4s from .unused to game folder..."
    # Restore all mp4s to game first (resets state when switching from other platforms)
    find "$TARGET" -maxdepth 1 -type f -iname "*.mp4" -print0 | while IFS= read -r -d '' SRC; do
        BN=$(basename "$SRC")
        DEST_GAME="game/$BN"
        DISP_GAME="./game/$BN"
        if [ -e "$DEST_GAME" ]; then
            echo "Skipping restore, already exists in game: $DISP_GAME"
            continue
        fi
        echo "Restoring '$SRC' -> $DISP_GAME"
        mv "$SRC" "$DEST_GAME"
    done

    echo "Android swap: moving '*-na*.mp4' from game to ./.unused (keeping non '-na' mp4s in game)"
    # move ios/web mp4s (with -na) out of game
    find game -maxdepth 5 -type f -iname "*-na*.mp4" -not -path "game/.unused/*" -print0 | while IFS= read -r -d '' SRC; do
        BN=$(basename "$SRC")
        DEST="$TARGET/$BN"
        DISP="./.unused/$BN"
        if [ -e "$DEST" ]; then
            echo "Skipping move, destination exists: $DISP"
            continue
        fi
        echo "Moving '$SRC' -> $DISP"
        mv "$SRC" "$DEST"
    done
fi

# iOS/web swap: move non -na mp4s out and keep *-na*.mp4 in game
if [ "$PLATFORM" = "ios" ] || [ "$PLATFORM" = "web" ]; then
    echo "iOS/web swap: first restoring all MP4s from .unused to game folder..."
    # Restore all mp4s to game first (resets state when switching from other platforms)
    find "$TARGET" -maxdepth 1 -type f -iname "*.mp4" -print0 | while IFS= read -r -d '' SRC; do
        BN=$(basename "$SRC")
        DEST_GAME="game/$BN"
        DISP_GAME="./game/$BN"
        if [ -e "$DEST_GAME" ]; then
            echo "Skipping restore, already exists in game: $DISP_GAME"
            continue
        fi
        echo "Restoring '$SRC' -> $DISP_GAME"
        mv "$SRC" "$DEST_GAME"
    done

    echo "iOS/web swap: moving MP4s without '-na' from game to ./.unused (keeping '*-na*.mp4' in game)"
    find game -maxdepth 5 -type f -iname "*.mp4" ! -iname "*-na*.mp4" -not -path "game/.unused/*" -print0 | while IFS= read -r -d '' SRC; do
        BN=$(basename "$SRC")
        DEST="$TARGET/$BN"
        DISP="./.unused/$BN"
        if [ -e "$DEST" ]; then
            echo "Skipping move, destination exists: $DISP"
            continue
        fi
        echo "Moving '$SRC' -> $DISP"
        mv "$SRC" "$DEST"
    done
fi

# Desktop: move all mp4 files to .unused (keep ogv), and restore any ogv files from .unused
if [ "$PLATFORM" = "desktop" ]; then
    echo "Desktop: restoring OGV files from .unused back to game..."
    # Restore all ogv files to game (desktop keeps ogv)
    find "$TARGET" -maxdepth 1 -type f -iname "*.ogv" -print0 | while IFS= read -r -d '' SRC; do
        BN=$(basename "$SRC")
        DEST_GAME="game/$BN"
        DISP_GAME="./game/$BN"
        if [ -e "$DEST_GAME" ]; then
            echo "Skipping restore, already exists in game: $DISP_GAME"
            continue
        fi
        echo "Restoring '$SRC' -> $DISP_GAME"
        mv "$SRC" "$DEST_GAME"
    done

    echo "Desktop: moving all MP4 files to ./.unused (keeping OGV files in game)"
    find game -maxdepth 5 -type f -iname "*.mp4" -not -path "game/.unused/*" -print0 | while IFS= read -r -d '' SRC; do
        BN=$(basename "$SRC")
        DEST="$TARGET/$BN"
        DISP="./.unused/$BN"
        if [ -e "$DEST" ]; then
            echo "Skipping move, destination exists: $DISP"
            continue
        fi
        echo "Moving '$SRC' -> $DISP"
        mv "$SRC" "$DEST"
    done
fi

for FILE in "${UNUSED_FILES[@]}"; do
    # Use find to match patterns inside game and avoid scanning outside
    find game -maxdepth 5 -type f \( -iname "$FILE" -o -name "$FILE" \) -print0 | while IFS= read -r -d '' SRC; do
        BASENAME=$(basename "$SRC")
        DEST="$TARGET/$BASENAME"
        DISPLAY_DEST="./.unused/$BASENAME"
        if [ -e "$DEST" ]; then
            echo "Skipping move, destination exists: $DISPLAY_DEST"
            continue
        fi
        echo "Moving '$SRC' -> $DISPLAY_DEST"
        mv "$SRC" "$DEST"
    done
done

# After platform specified cleanup, clean all remaining unused assets.
if [ -f "$REPO_ROOT/unused_files.txt" ]; then
    echo "Also processing list: unused_files.txt"
    while IFS= read -r FNAME || [ -n "$FNAME" ]; do
        case "$FNAME" in
            ''|\#*) continue ;;
        esac
        find game -type f -iname "$FNAME" -not -path "game/.unused/*" -print0 | while IFS= read -r -d '' SRC; do
            BASENAME=$(basename "$SRC")
            DEST="$TARGET/$BASENAME"
            DISPLAY_DEST="./.unused/$BASENAME"
            if [ -e "$DEST" ]; then
                echo "Skipping move, destination exists: $DISPLAY_DEST"
                continue
            fi
            echo "Moving '$SRC' -> $DISPLAY_DEST"
            mv "$SRC" "$DEST"
        done
    done < "$REPO_ROOT/unused_files.txt"
fi