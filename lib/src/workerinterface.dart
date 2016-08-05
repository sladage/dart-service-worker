library ServiceWorkerManager.Worker;

import 'dart:async';
import 'shared.dart';

enum ServiceWorkerState {
  INSTALLING,
  INSTALLED,
  ACTIVATING,
  ACTIVATED,
  REDUNDANT
}

class StateChangeEvent {
  StateChangeEvent(this.oldState,this.newState) {}
  final ServiceWorkerState oldState;
  final ServiceWorkerState newState;
}

class ServiceWorker {

  ///

  String get scope => _scope;

  /// Returns the state of the service worker. It returns one of the following
  /// values: installing, installed, activating, activated, or redundant.

  ServiceWorkerState get state => _state;

  /// Returns a [Stream] which fires an event when the state changes.

  Stream<StateChangeEvent> get onStateChange =>
      _stateController.stream;

  ///

  Stream<MessageEvent> get onMessage => _messageController.stream;

  ///

  Stream get onError => _errorController.stream;

  ///

  void postMessage(message) {

  }

  ///

  void update() {

  }

  ///

  void unregister() {

  }

  ServiceWorkerState _state;
  StreamController _stateController;
  StreamController _messageController;
  StreamController _errorController;
  String _scope;
  var _internal;
}
