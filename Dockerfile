# Etapa 1: Construir la aplicación
FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Etapa 2: Servir los archivos estáticos
FROM nginx:alpine
COPY --from=builder /app/dist /usr/share/nginx/html
# Añade esta línea para debuggear:
RUN ls -la /usr/share/nginx/html  
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]