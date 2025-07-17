# hahcf-patch

HAHCF patches to reduce unused assets & fix cutscene bugs

This can fix the bug for Android, iOS and Web by reencoding cutscenes.

## Android

If you targetting Android platform:

Please make sure to grab Ren'Py 7.3.5 stable version for modern builds
or/and legacy builds for Ren'Py 7.0.1 stable version.

Since Ren'Py 7.4, it could **crash** due to memory increasing up over 2 GB during play game for unexpected reason for Android builds.

To reduce assets, we don't actually need an OGV cutscenes for Android builds, because it's only for PC platforms and also could still work for since Ren'Py 7.4 optional.

Most common easy in File Manager or Windows Explorer of graphical window is to find OGV video file extensions and then delete manually.

Or you could do in terminal:

```
# Windows
del /S HAHCF\game\*.ogv

# macOS/Linux
rm -f HAHCF/game/*.ogv
```



## Automatic (deprecated)

This can be found for video folder with one file called:

```
CheeseFestival.ogv
ENDING.ogv
```

These video files were reencoded video only with H.264 and Vorbis audio is kept.

So please copy to the game folder of HAHCF from the video folder.

Automatic command used for encoding of FFmpeg:

```
ffmpeg -i CheeseFestival.ogv -c:v libx264 -profile:v main -level 3 -crf 18 -c:a copy -preset placebo -bsf:v "filter_units=remove_types=6" -fflags +bitexact -flags:v +bitexact -flags:a +bitexact -map_metadata -1 -vsync cfr -f mp4 CheeseFestival1.ogv

ffmpeg -i ENDING.ogv -c:v libx264 -profile:v main -level 3 -crf 18 -c:a copy -preset placebo -bsf:v "filter_units=remove_types=6" -fflags +bitexact -flags:v +bitexact -flags:a +bitexact -map_metadata -1 -vsync cfr -f mp4 Ending1.ogv
```

## Manual (deprecated)

If you don't want to grab video folder with pre-encoded:

You can get the two original video files:

[CheeseFestival.ogv](https://github.com/MartinEesmaa/HAHCF/raw/5d3b320c31941fe5416342d840dac57265df0305/game/CheeseFestival.ogv)

[ENDING.ogv](https://github.com/MartinEesmaa/HAHCF/raw/5d3b320c31941fe5416342d840dac57265df0305/game/ENDING.ogv)

After that you downloaded the file, finally thing is to reencode, but keep audio copy:

```
mv CheeseFestival.ogv CheeseFestival-old.ogv
mv ENDING.ogv ENDING-old.ogv
ffmpeg -i CheeseFestival-old.ogv -c:v libx264 -c:a copy -profile:v main -level 3 -crf 18 -preset medium -f mp4 CheeseFestival.ogv
ffmpeg -i ENDING-old.ogv -c:v libx264 -c:a copy -profile:v main -level 3 -crf 18 -preset medium -f mp4 ENDING.ogv
```

On Windows, replace `mv` by `move`.

Once you're done reencoding, replace movie files to the game folder of HAHCF please.

- Martin Eesmaa