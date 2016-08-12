library ServiceWorker.Worker;

import 'dart:async';
import 'dart:js';
import 'shared.dart';
import 'fetch.dart';
import 'util.dart';

class ServiceWorkerClient {
  ServiceWorkerClient.internal(this._internal) {}

  /// Send message to client.
  void postMessage(data) {
    _internal.callMethod("postMessage", [data]);
  }

  /// Returns the universally unique identifier of the service worker client.
  String get id => _internal["id"];

  /// Returns the URL of the service worker client.
  String get url => _internal["url"];
  JsObject _internal;
}

class FetchEvent {
  FetchEvent.internal(this._internal) {}

  Request get request => new Request.fromInternal(_internal["request"]);
  String get clientId => _internal["clientId"];
  bool get isReload => _internal["isReload"];

  void respondWith(Future<Response> r) {
    _internal.callMethod("respondWith",[new Promise.fromFuture(r).toJs()]);
  }

  JsObject _internal;
}

class ServiceWorker {
  ServiceWorker() {
    context["self"].callMethod("addEventListener", [
      "activate",
      (e) {
        _onActivate.add({});
      }
    ]);
    context["self"].callMethod("addEventListener", [
      "fetch",
      (e) {
        _onFetch.add(new FetchEvent.internal(e));
      }
    ]);
    context["self"].callMethod("addEventListener", [
      "install",
      (e) {
        _onInstall.add({});
      }
    ]);
    context["self"].callMethod("addEventListener", [
      "message",
      (e) {
        _onMessage.add(new MessageEvent(e["data"], e["origin"],
            e["lastEventId"], new ServiceWorkerClient.internal(e["source"])));
      }
    ]);
    /*context["this"]["onpushsubscriptionchange"] = (e){
      _onPushSubscriptionChange.add({});
    };
    context["this"]["onpush"] = (e){
      _onPush.add({});
    };*/
    context["self"].callMethod("addEventListener", [
      "onsync",
      (e) {
        _onSync.add({});
      }
    ]);
  }

  /// Gets a service worker client matching a given id.

  Future<ServiceWorkerClient> client(String id) async {
    Completer c = new Completer();
    JsObject promise = context["self"]["clients"].callMethod("get", [id]);
    promise.callMethod("then", [
      (swclient) {
        var sw = new ServiceWorkerClient.internal(swclient);
        c.complete(sw);
      }
    ]);
    return await c.future;
  }

  /// Gets a list of service worker clients.

  Future<List<ServiceWorkerClient>> clients(
      {bool includeUncontrolled: false, String type: "all"}) async {
    Completer c = new Completer();
    JsObject options = new JsObject.jsify(
        {"includeUncontrolled": includeUncontrolled, "type": type});
    JsObject promise =
        context["self"]["clients"].callMethod("matchAll", [options]);
    promise.callMethod("then", [
      (JsArray jsclients) {
        var clients = [];
        for (JsObject client in jsclients) {
          clients.add(new ServiceWorkerClient.internal(client));
        }
        c.complete(clients);
      }
    ]);
    return await c.future;
  }

  Stream get onActivate => _onActivate.stream;

  Stream get onFetch => _onFetch.stream;

  Stream get onInstall => _onInstall.stream;

  Stream<MessageEvent> get onMessage => _onMessage.stream;

  //Stream get onPush => _onPush.stream;

  //Stream get onPushSubscriptionChange => _onPushSubscriptionChange.stream;

  Stream get onSync => _onSync.stream;

  StreamController _onActivate = new StreamController.broadcast();
  StreamController _onFetch = new StreamController.broadcast();
  StreamController _onInstall = new StreamController.broadcast();
  StreamController _onMessage = new StreamController.broadcast();
  //StreamController _onNotificationClick = new StreamController.broadcast();
  //StreamController _onNotificationClose = new StreamController.broadcast();
  //StreamController _onPush = new StreamController.broadcast();
  //StreamController _onPushSubscriptionChange = new StreamController.broadcast();
  StreamController _onSync = new StreamController.broadcast();
}
