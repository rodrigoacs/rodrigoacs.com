FROM nginx:stable-alpine

# Config do site (substitui a padrão do Nginx)
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Arquivos estáticos — o que não deve ir para a imagem está no .dockerignore
COPY . /usr/share/nginx/html

EXPOSE 80

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget -q --spider http://127.0.0.1/healthz || exit 1