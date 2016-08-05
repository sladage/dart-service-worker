library ServiceWorker.Worker;

import 'dart:async';
import 'dart:js';
import 'shared.dart';

class ServiceWorkerClient {
  void postMessage(data) {}
}

class ServiceWorker {
  ServiceWorker() {
    context["self"].callMethod("addEventListener",["activate", (e) {
      _onActivate.add({});
    }]);
    context["self"].callMethod("addEventListener",["fetch", (e) {
      _onFetch.add({});
    }]);
    context["self"].callMethod("addEventListener",["install", (e) {
      _onInstall.add({});
    }]);
    context["self"].callMethod("addEventListener",["message", (e) {
      _onMessage.add(new MessageEvent(
          e["data"], e["origin"], e["lastEventId"], e["source"]));
    }]);
    /*context["this"]["onpushsubscriptionchange"] = (e){
      _onPushSubscriptionChange.add({});
    };
    context["this"]["onpush"] = (e){
      _onPush.add({});
    };*/
    context["self"].callMethod("addEventListener",["onsync", (e) {
      _onSync.add({});
    }]);
  }

  List<ServiceWorkerClient> get clients {
    return [];
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
