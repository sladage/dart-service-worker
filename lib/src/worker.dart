library ServiceWorker.Worker;

import 'dart:async';

enum ServiceWorkerState {
  INSTALLING,
  INSTALLED,
  ACTIVATING,
  ACTIVATED,
  REDUNDANT
}

class ServiceWorkerStateChangeEvent {
  ServiceWorkerStateChangeEvent(this.oldState,this.newState) {}
  final ServiceWorkerState oldState;
  final ServiceWorkerState newState;
}

class ServiceWorker {
  /// Returns the state of the service worker. It returns one of the following
  /// values: installing, installed, activating, activated, or redundant.

  ServiceWorkerState get state => _state;

  /// Returns a [Stream] which fires an event when the state changes.

  Stream<ServiceWorkerStateChangeEvent> get onStateChange =>
      _stateController.stream;

  ///

  Stream<MessageEvent> get onMessage => _messageController.stream;

  ///

  Stream<ErrorEvent> get onError => _errorController.stream;

  /// 

  void postMessage(message) {

  }

  ServiceWorkerState _state;
  StreamController _stateController;
  StreamController _messageController;
  StreamController _errorController;
}
