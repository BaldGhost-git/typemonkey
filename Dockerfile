# Use latest stable channel SDK.
FROM ghcr.io/cirruslabs/flutter:3.32.2 AS build

# Resolve app dependencies.
WORKDIR /app
COPY pubspec.* ./
RUN flutter pub get

# Copy app source code (except anything in .dockerignore) and compile with WASM
COPY . .
RUN flutter create . --platforms web
RUN dart run build_runner build
RUN flutter build web

FROM python:3.11.14-alpine3.23

WORKDIR /web

COPY --from=build /app/build/web/ ./

# Start server.
EXPOSE 8000
CMD ["sh", "-c", "python -m http.server ${PORT:-8000}"]