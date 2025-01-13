# Etapa 1: Construcción de la aplicación
FROM node:18-alpine AS build

# Creamos una carpeta de trabajo
WORKDIR /app

# Copiamos los archivos de dependencias y los instalamos
COPY package*.json .
RUN npm install

# Copiamos el resto del código al contenedor
COPY . .

# Construimos la aplicación usando Vite (la carpeta de salida por defecto es dist/)
RUN npm run build

# Etapa 2: Servir la aplicación
FROM nginx:alpine

# Copiamos los archivos estáticos generados en la etapa anterior
COPY --from=build /app/dist /usr/share/nginx/html

# Abrimos el puerto 80 (opcional para Cloud Run, pero útil si lo despliegas en otro servicio)

EXPOSE 8080

# Arrancamos el servidor Nginx en primer plano
CMD ["nginx", "-g", "daemon off;"]
