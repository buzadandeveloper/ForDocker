FROM nginx:alpine

# Copiem toate fișierele proiectului în root-ul Nginx
COPY . /usr/share/nginx/html

# Expunem portul 80 (HTTP)
EXPOSE 80

# Comanda prin care pornește serverul Nginx în foreground
CMD ["nginx", "-g", "daemon off;"]
