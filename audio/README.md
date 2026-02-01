# Replace upsampled audio

For Helga's Cheese Festival version, it has been edited for only HA! Dangerous Lumber soundtrack by trimming it.
But it has originally exported to WAV upsampled audio, not losslessly split MP3 file.

New original audio of "org-DangerousLumber.mp3" MP3 file to trim like Helga's Cheese Festival version.

This can be done trimming losslessly:

```
ffmpeg -i "org-DangerousLumber.mp3" -c copy -t 00:00:29.793 -fflags +bitexact -flags:a +bitexact 48DL-01.mp3
ffmpeg -i "org-DangerousLumber.mp3" -c copy -ss 00:00:51.928 -to 00:01:32.075 -fflags +bitexact -flags:a +bitexact 48DL-02.mp3
```

Apply concentenate for two seperated tracks into complete trimmed beginning song. Still it is available list.txt pre-made text.

```
echo file '48DL-01.mp3' > list.txt
echo file '48DL-02.mp3' >> list.txt
```

```
ffmpeg -f concat -i list.txt -c:a copy -fflags +bitexact -flags:a +bitexact "Dangerous Lumber.mp3"
```

- Martin Eesmaa