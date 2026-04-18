FROM node:18-slim

RUN apt-get update && apt-get install -y \
    ffmpeg \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY app/package*.json ./

RUN npm install --production && npm cache clean --force

COPY app/ ./app/
COPY config/ ./config/
COPY public/ ./public/

ENV NODE_ENV=production
ENV HOST=0.0.0.0
ENV PORT=3000

EXPOSE 3000

RUN mkdir -p /app/config /app/logs && \
    chmod 755 /app && \
    chmod 777 /app/config /app/logs

VOLUME ["/app/config", "/app/logs"]

HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD wget --no-verbose --tries=1 --spider http://localhost:3000/ || exit 1

USER node

CMD ["node", "app/src/server.js"]
