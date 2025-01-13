# ===============================
# Etapa 1: Construcción
# ===============================
FROM node:18-alpine AS build

WORKDIR /app

COPY package*.json .
RUN npm install

COPY . .
RUN npm run build

# ===============================
# Etapa 2: Servir con http-server
# ===============================
FROM node:18-alpine

# Instalamos 'http-server' en la imagen final
RUN npm install -g http-server

WORKDIR /app

# # Copiamos la carpeta dist generada en la etapa anterior
# COPY --from=build /dist ./dist

EXPOSE 8080

CMD ["http-server", "dist", "-p", "8080"]