# NLive Media Server

A Live Streaming Server using nginx , nginx-rtmp-module (branch hls) and nginx-http-flv-module (branch flv), with custom config files.

### Port Settings

HTTP Server:`80`  
HTTPS Server:`443`  
RTMP:`1935`  

### Link Settings
Push RTMP:`rtmp://<ip>/live/<stream>`  
Receive RTMP:`rtmp://<ip>/live/<stream>` for the origional video&audio and codec,while `rtmp://<ip>/transcode/<stream>_hls` for the origional video&audio settings and x264+aac codec.  
Receive audio-only rtmp:`rtmp://<ip>/transcode/<stream>_audio`  
Receive HLS:`http://<ip>/hls/transcode/<stream>_hls/index.m3u8` and `http://<ip>/hls/transcode/<stream>_audio/index.m3u8`.You can use `https://` as well.TS clips are AES-128 protected by default.  
Backup RTMP application:`rtmp://<ip>/backup/<stream>`  
Video-on-demand:`rtmp://<ip>/vod//<name>.flv`  
Statistics:`http://<ip>/count.html` for auto-refreshing (5 seconds),or `http://<ip>/stat.xml` for a static report.`http://<ip>/stat.xsl` for downloading the defination file.You can use https as well.

### Dir Settings  
`/root/logs` is the log files' dir.  
`/root/software` is the dir containing program files.  
`/root/web` is the dir holding all the files serving over the network.  
`/root/config` is the dir containing config files.  
`/root/web/html`:webroot  
`/root/web/hls`:hls files  
`/root/web/dash`:mpeg-dash files  
`/root/web/record`:DVR flv files  
`/root/web/vod`:VOD media files