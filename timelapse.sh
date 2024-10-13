#!/bin/bash

#Capturo una foto de una cámara dahua con la frecuencia indicada en la variable intervalo
#vía curl haciendo login a la cámara y le asigno un nombre que facilite luego la selección de imágenes.
#by_LGM

source timelapse.conf

fecha_log=$(date '+%Y-%m-%d_%H-%M-%S')

function take_photo() {

fecha=$(date '+%Y-%m-%d_%H-%M-%S')
archivo="${fecha}_timelapse.jpg"
curl -Ss --digest -u "$usuario:$password" "http://$ip/cgi-bin/snapshot.cgi" --output "$archivo"
#send_ftp "$archivo"
echo "$archivo" >> log_$fecha_log.txt
echo "file '$archivo'" >> playlist_ffmpeg.txt
}

function send_ftp() {

#ftp -inv $ftp_server << EOF
#user $ftp_user $ftp_password
#put "~/timelapse/$1" "$(basename "$1")"
#bye
#EOF

timeout 10 curl -T ~/timelapse/$1 ftp://$ftp_server --user $ftp_user:$ftp_password

}

while true; do

take_photo
sleep $((intervalo * 60))

done
