# SDUI Mock Server

A minimal Dart HTTP server that serves JSON screen contracts from `assets/screens/`.

## Quick Start

```bash
cd server
dart pub get
dart run bin/server.dart
```

The server starts on port 8080 (override with `PORT` env var).

## Endpoints

| Method | Path | Description |
|--------|------|-------------|
| `GET` | `/api/screens` | List all available screen IDs |
| `GET` | `/api/screens/:id` | Fetch a screen contract by ID |
| `GET` | `/health` | Health check |

## Connecting from the Flutter App

Use `HttpApiClient` pointing to the server:

```dart
final client = HttpApiClient(baseUrl: 'http://localhost:8080/api/screens');
```
