FROM node:18-alpine

WORKDIR /app

# Copiamos e instalamos dependencias
COPY package*.json .
RUN npm install

# Copiamos el resto del código
COPY . .

# Construimos el proyecto
RUN npm run build

# Instalamos http-server (global)
RUN npm install -g http-server

# Exponemos el puerto que usaremos
EXPOSE 8080

# Arrancamos http-server en el puerto 8080,
# sirviendo la carpeta 'dist'.
CMD ["sh", "-c", "cd dist && http-server -p 8080"]
