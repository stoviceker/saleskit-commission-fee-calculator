FROM node:20-alpine

WORKDIR /app

# Žádné npm závislosti – stačí zkopírovat zdroje
COPY package.json ./
COPY server.js ./
COPY public ./public

ENV PORT=3000
EXPOSE 3000

CMD ["node", "server.js"]
