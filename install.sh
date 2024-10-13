#!/bin/bash


#Instalamos todo el software que se necesita para que funcione de forma correcta el software de creación de timelapse.
#by_LGM


# Verificar si el script se está ejecutando como root
if [ "$(id -u)" != "0" ]; then
   echo "Este script debe ejecutarse como root" 1>&2
   exit 1
fi

# Actualizar la lista de paquetes
echo "Actualizando la lista de paquetes..."
apt update

# Instalar curl
echo "Instalando curl..."
apt install -y curl

# Instalar ffmpeg
echo "Instalando ffmpeg..."
apt install -y ffmpeg

# Instalar Node.js (requisito para pm2)
echo "Instalando Node.js..."
curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
apt install -y nodejs

# Instalar pm2 globalmente
echo "Instalando pm2..."
npm install -g pm2

# Verificación de las instalaciones
echo "Verificación de instalaciones:"
echo -n "curl: " && curl --version | head -n 1
echo -n "ffmpeg: " && ffmpeg -version | head -n 1
echo -n "pm2: " && pm2 --version

echo "Instalación completada."

