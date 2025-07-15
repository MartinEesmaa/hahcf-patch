# hahcf-patch

HAHCF patches to fix cutscene bugs

This can fix the bug for Android, iOS and Web by reencoding cutscenes.

## Automatic

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

## Manual

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