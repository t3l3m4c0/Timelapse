#!/bin/bash

#Con el log que genera el script de shell timelapse.sh lo utilizo de playlist para ffmpeg
#y genero un video con los fotogramas que captura timelapse.sh que luego subo por FTP
#by_LGM

source timelapse.conf

function timelapse_to_video(){

fecha=$(date '+%d-%m-%Y')

ffmpeg -y -f concat -safe 0 -i playlist_ffmpeg.txt -c:v libx264 -r 25 -pix_fmt yuv420p timelapse-$fecha.mp4

curl -T ~/timelapse/timelapse-$fecha.mp4 ftp://$ftp_server --user $ftp_user:$ftp_password

}


while true; do

timelapse_to_video

sleep 86400

done
