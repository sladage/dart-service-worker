library ServiceWorker.Cache;

import 'dart:async';
import 'dart:js';

import 'fetch.dart';

class Cache {
  Cache.internal(this._internal) {

  }
  JsObject _internal;
}

class CacheStorage {
  CacheStorage.internal(this._internal) {

  }

  Future<Cache> open(String cacheName) async {
    Completer c = new Completer();
    JsObject promise = _internal.callMethod("open", [cacheName]);
    promise.callMethod("then", [
      (jscache) {
        var cache = new Cache.internal(jscache);
        c.complete(cache);
      }
    ]);
    return await c.future;
  }

  Future<Response>

  JsObject _internal;
}
