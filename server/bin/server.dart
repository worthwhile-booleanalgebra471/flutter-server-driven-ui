import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';

/// Minimal REST server that serves JSON screen contracts from
/// `../assets/screens/`. Start with: `dart run bin/server.dart`
void main() async {
  final port = int.tryParse(Platform.environment['PORT'] ?? '') ?? 8080;
  final assetsDir = Directory('../assets/screens');

  final router = Router()
    ..get('/api/screens', (Request request) async {
      final files = assetsDir
          .listSync()
          .whereType<File>()
          .where((f) => f.path.endsWith('.json'))
          .map((f) => f.uri.pathSegments.last.replaceAll('.json', ''))
          .toList()
        ..sort();

      return Response.ok(
        jsonEncode({'screens': files}),
        headers: {'Content-Type': 'application/json'},
      );
    })
    ..get('/api/screens/<id>', (Request request, String id) async {
      final file = File('${assetsDir.path}/$id.json');
      if (!file.existsSync()) {
        return Response.notFound(
          jsonEncode({'error': 'Screen "$id" not found'}),
          headers: {'Content-Type': 'application/json'},
        );
      }

      return Response.ok(
        file.readAsStringSync(),
        headers: {'Content-Type': 'application/json'},
      );
    })
    ..get('/health', (Request request) {
      return Response.ok(
        jsonEncode({'status': 'ok'}),
        headers: {'Content-Type': 'application/json'},
      );
    });

  final handler = const Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(_corsMiddleware())
      .addHandler(router.call);

  final server = await io.serve(handler, InternetAddress.anyIPv4, port);
  print('SDUI server running at http://${server.address.host}:${server.port}');
  print('Screens endpoint: http://localhost:$port/api/screens');
}

Middleware _corsMiddleware() {
  return (Handler handler) {
    return (Request request) async {
      if (request.method == 'OPTIONS') {
        return Response.ok('', headers: _corsHeaders);
      }
      final response = await handler(request);
      return response.change(headers: _corsHeaders);
    };
  };
}

const _corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Methods': 'GET, OPTIONS',
  'Access-Control-Allow-Headers': 'Content-Type',
};
