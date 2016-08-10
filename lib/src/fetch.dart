library FetchAPI;

import 'dart:async';
import 'dart:typed_data';
import 'dart:js';
import 'dart:convert';

abstract class HttpStatus {
  static const int CONTINUE = 100;
  static const int SWITCHING_PROTOCOLS = 101;
  static const int OK = 200;
  static const int CREATED = 201;
  static const int ACCEPTED = 202;
  static const int NON_AUTHORITATIVE_INFORMATION = 203;
  static const int NO_CONTENT = 204;
  static const int RESET_CONTENT = 205;
  static const int PARTIAL_CONTENT = 206;
  static const int MULTIPLE_CHOICES = 300;
  static const int MOVED_PERMANENTLY = 301;
  static const int FOUND = 302;
  static const int MOVED_TEMPORARILY = 302; // Common alias for FOUND.
  static const int SEE_OTHER = 303;
  static const int NOT_MODIFIED = 304;
  static const int USE_PROXY = 305;
  static const int TEMPORARY_REDIRECT = 307;
  static const int BAD_REQUEST = 400;
  static const int UNAUTHORIZED = 401;
  static const int PAYMENT_REQUIRED = 402;
  static const int FORBIDDEN = 403;
  static const int NOT_FOUND = 404;
  static const int METHOD_NOT_ALLOWED = 405;
  static const int NOT_ACCEPTABLE = 406;
  static const int PROXY_AUTHENTICATION_REQUIRED = 407;
  static const int REQUEST_TIMEOUT = 408;
  static const int CONFLICT = 409;
  static const int GONE = 410;
  static const int LENGTH_REQUIRED = 411;
  static const int PRECONDITION_FAILED = 412;
  static const int REQUEST_ENTITY_TOO_LARGE = 413;
  static const int REQUEST_URI_TOO_LONG = 414;
  static const int UNSUPPORTED_MEDIA_TYPE = 415;
  static const int REQUESTED_RANGE_NOT_SATISFIABLE = 416;
  static const int EXPECTATION_FAILED = 417;
  static const int INTERNAL_SERVER_ERROR = 500;
  static const int NOT_IMPLEMENTED = 501;
  static const int BAD_GATEWAY = 502;
  static const int SERVICE_UNAVAILABLE = 503;
  static const int GATEWAY_TIMEOUT = 504;
  static const int HTTP_VERSION_NOT_SUPPORTED = 505;
  // Client generated status code.
  static const int NETWORK_CONNECT_TIMEOUT_ERROR = 599;
}

enum ResponseType {
  BASIC,
  CORS,
  ERROR,
  OPAQUE
}

class Headers {
  Headers.internal(this._internal) {

  }

  JsObject _internal;
}

class Response {
  Response.internal(this._internal) {

  }

  Future<Uint8List> data() async {
    Completer c = new Completer();
    JsObject promise = _internal.callMethod("arrayBuffer", []);
    promise.callMethod("then", [
      (buffer) {
        var data = new Uint8List.view(buffer);
        c.complete(data);
      }
    ]);
    return await c.future;
  }

  Future<Map> json() async {
    Completer c = new Completer();
    JsObject promise = _internal.callMethod("json", []);
    promise.callMethod("then", [
      (buffer) {
        var data = new JsonDecoder().convert(buffer);
        c.complete(data);
      }
    ]);
    return await c.future;
  }

  Future<String> text() async {
    Completer c = new Completer();
    JsObject promise = _internal.callMethod("arrayBuffer", []);
    promise.callMethod("then", [
      (buffer) {
        c.complete(buffer as String);
      }
    ]);
    return await c.future;
  }

  Response clone() {
    return new Response.internal(_internal.callMethod("clone"));
  }

  Response error() {
    return new Response.internal(_internal.callMethod("error"));
  }

  Response redirect() {
    return new Response.internal(_internal.callMethod("redirect"));
  }

  Headers get headers => new Headers.internal(_internal["headers"]);

  bool get ok => _internal["ok"];

  bool get redirected => _internal["redirected"];

  int get status => _internal["status"];

  ResponseType get type {
    switch (_internal["type"]) {
      case "basic":
        return ResponseType.BASIC;
      case "cors":
        return ResponseType.CORS;
      case "error":
        return ResponseType.ERROR;
      case "opaque":
        return ResponseType.OPAQUE;
      default:
        return ResponseType.BASIC;
    }
  }

  JsObject _internal;
}
