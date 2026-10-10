# ---------- Stage 1: Build the React app ----------
FROM node:20-alpine AS build
WORKDIR /app

# Only the non-secret build setting is passed in here.
# Do NOT pass a GitHub token as a build argument: anything prefixed with VITE_
# is compiled into the JavaScript that every visitor downloads.
ARG VITE_MAX_REPOS=50
ENV VITE_MAX_REPOS=$VITE_MAX_REPOS

# Install dependencies first so this layer is cached between builds
COPY package*.json ./
RUN npm ci

COPY . .
RUN npm run build

# ---------- Stage 2: Serve with Nginx ----------
FROM nginx:alpine

RUN rm -rf /usr/share/nginx/html/*
COPY --from=build /app/dist /usr/share/nginx/html

# Custom Nginx config with the fallback needed for single-page routing
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

HEALTHCHECK --interval=30s --timeout=3s CMD wget -qO- http://localhost/ || exit 1

CMD ["nginx", "-g", "daemon off;"]
