# hahcf-patch

HAHCF patches to reduce unused assets & fix cutscene bugs

This can fix the bug for Android, iOS and Web by reencoding cutscenes.

## Android

If you targetting Android platform:

Please make sure to grab Ren'Py 7.3.5 stable version for modern builds
or/and legacy builds for Ren'Py 7.0.1 stable version.

Since Ren'Py 7.4, it could **crash** due to memory increasing up over 2 GB during play game for unexpected reason for Android builds.

To reduce assets, we don't actually need an OGV cutscenes for Android builds, because it's only for PC platforms and also could still work for since Ren'Py 7.4 optional.

Most common easy in File Manager or Windows Explorer of graphical window is to find OGV video file extensions, make new directory called `.unused` and move unused assets to `.unused`. Or alternatively, you could delete unused OGV cutscenes for your choice.

Or you could do in terminal:

Make a new directory called `.unused` and move files (recommended method):

```

# Windows
cd HAHCF\game
mkdir .unused
move *.ogv .unused

# macOS/Linux
cd HAHCF/game
mkdir .unused
mv *.ogv .unused
```

Alternative method is deletion:

```
# Windows
del /S HAHCF\game\*.ogv

# macOS/Linux
rm HAHCF/game/*.ogv
```

It is ready to go and build distributions for Android.

See the below to build seperate builds to keep stable and compatibility.

Modern build package & Ren'Py version: org.martineesmaa.hahcf (7.3.5)

Legacy build package & Ren'Py version: org.martineesmaa.hahcflegacy (7.0.1)

Note if you getting error of not found packages for older versions than Ren'Py 7.3.5:

```
* What went wrong:
Could not resolve all files for configuration ':app:releaseRuntimeClasspath'.
Searched in the following locations :
file:/home/martineesmaa/Downloads/renpy-7.0.1-sdk/rapt/Sdk/extras/m2repository/com/danikula/expansion/expansion/1.3.4/expansion-1.3.4.pom
file:/home/martineesmaa/Downloads/renpy-7.0.1-sdk/rapt/Sdk/extras/m2repository/com/danikula/expansion/expansion/1.3.4/expansion-1.3.4.aar
file:/home/martineesmaa/Downloads/renpy-7.0.1-sdk/rapt/Sdk/extras/m2repository/com/danikula/expansion/license/1.7.0/license-1.7.0.pom
file:/home/martineesmaa/Downloads/renpy-7.0.1-sdk/rapt/Sdk/extras/m2repository/com/danikula/expansion/license/1.7.0/license-1.7.0.pom
file:/home/martineesmaa/Downloads/renpy-7.0.1-sdk/rapt/Sdk/extras/m2repository/com/danikula/expansion/zip/1.2.1/zip-1.2.1.pom
file:/home/martineesmaa/Downloads/renpy-7.0.1-sdk/rapt/Sdk/extras/m2repository/com/danikula/expansion/zip/1.2.1/zip-1.2.1.aar
```

See the folder with Android old packages [android-old](android-old), taken from web.archive.org and copy six files to each three directories:

Please download six files into rapt folder from renpy-7.0.1-sdk.

Make sure you're in rapt folder behind renpy-7.0.1-sdk folder example:

```
mkdir -p Sdk/extras/m2repository/com/danikula/expansion/expansion/1.3.4/
mkdir -p Sdk/extras/m2repository/com/danikula/expansion/license/1.7.0/
mkdir -p Sdk/extras/m2repository/com/danikula/expansion/zip/1.2.1/
cp expansion-1.3.4* Sdk/extras/m2repository/com/danikula/expansion/expansion/1.3.4/
cp license-1.7.0* Sdk/extras/m2repository/com/danikula/expansion/license/1.7.0/
cp zip-1.2.1* Sdk/extras/m2repository/com/danikula/expansion/zip/1.2.1/
```

## Mac OS X (for PowerPC users)

If you want to play the game on your Mac OS PowerPC version.

Only seperated package of Macintosh PowerPC Ren'Py was supported between 6.13 and 6.14.1.

Grab Ren'Py Macintosh PPC package [here](https://renpy.org/dl/6.13.8/renpy-ppc.zip)

### Patch:

The patch file can be found on [macos-ppc/environment.txt](macos-ppc/environment.txt).

Also please rename from renpy.app to renpy-temp.app
and then rename it from renpy-ppc.app into renpy.app, so it can build on Windows & Linux.

Please note when building on Mac by running renpy-ppc.app (as renamed to renpy.app)
can only work between Mac OS X 10.4.4 and 10.6.8 
for emulating PowerPC for Intel host, also includes Mac OS 10.4 to 10.5.8 for PowerPC.

Windows run: renpy.exe / Linux run: renpy.sh

Run renpy-temp.app for only Intel x86 macOS computers.

or run renpy.app for only macOS PowerPC computers.

Finally run the program, select the project and then build distributions.

### Explanation:

Create a environment text file for switch renderer to Software in Ren'Py.

```
echo 'RENPY_RENDERER="sw"' > environment.txt
```

This will avoid crash to avoid automatic detection 
and forces switch to Software renderer rather than OpenGL.

Using OpenGL on Mac OS X PowerPC version can crash for some users.
It is best to use software renderer, but it is very slow and no choice to turn OpenGL on.

After that, copy the environment.txt file to the root folder of HAHCF.

```
cp environment.txt HAHCF/
```

Once you done copying environment.txt file to HAHCF project, you need Ren'Py 6.13.8 with PPC ZIP compressed file (tested) and you need to rename it by two times.

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