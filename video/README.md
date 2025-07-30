# Compatibility fix cutscenes

If you want to make compatible with web for example.

The only we can make compatible is for H.264 video and AAC audio.

Taken two songs from best samples of YouTube format:

You need to download yt-dlp, but `HIW.m4a` and `OCBM.webm` are pre-available songs available on this folder.

Otherwise you can still download two songs from YouTube videos using yt-dlp:

```
yt-dlp -f 140 https://www.youtube.com/watch?v=eVPsjCzrE4w -o HIW.m4a
yt-dlp -f 251 https://www.youtube.com/watch?v=8vkOLA_Cpyg -o OCBM.webm
```

After that this can be done trimming losslessly and ending song will be reencoded with fade out filter:

### Beginning music

```
ffmpeg -i HIW.m4a -c:a copy -t 00:00:38.633 HEISWE-1.m4a
ffmpeg -i HIW.m4a -c:a copy -ss 00:02:43.430 HEISWE-2.m4a
```

Apply concentenate for two seperated tracks into complete trimmed beginning song. Still it is available list.txt pre-made text.

```
echo file 'HEISWE-1.m4a' > list.txt
echo file 'HEISWE-2.m4a' >> list.txt
```

```
ffmpeg -f concat -i list.txt -t 00:01:56.516 -c:a copy -fflags +bitexact -flags:a +bitexact -map_metadata -1 cf-trimmed.m4a
```

### Ending music

The song has to be reencoded by applying override fade out filter:

```
ffmpeg -i OCBM.webm -t 00:00:40.836 -af afade=out:st=39:d=1 -c:a aac -b:a 320k -fflags +bitexact -flags:a +bitexact -map_metadata -1 OCBM.m4a
```