library IndexedDB;

import 'dart:js';
import 'util.dart';
import 'dart:async';

final IndexedDB indexedDB = context.hasProperty("window")
    ? new IndexedDB._internal(new JsObject.fromBrowserObject(
        new JsObject.fromBrowserObject(context["window"])["indexedDB"]))
    : new IndexedDB._internal(context["indexedDB"]);

enum AccessMode { READ_ONLY, READ_WRITE }

class IndexedDB implements JsProxyObject {
  IndexedDB._internal(this._js) {}

  Future<Database> open(String name,
      {int version,
      void onUpgradeNeeded(VersionChangeEvent),
      void onBlocked(Event)}) {
    var vars = [name];
    if (version != null) vars.add(version);
    JsObject request = _js.callMethod("open", vars);
    Completer c = new Completer();

    request["onerror"] = (JsObject event) {
      c.completeError("Error opening database.");
    };

    request["onsuccess"] = (JsObject event) {
      c.complete(new Database._internal(request["result"]));
    };

    if (onUpgradeNeeded != null) {
      request["onupgradeneeded"] = (JsObject event) {
        onUpgradeNeeded(new VersionChangeEvent(
            event["oldVersion"], event["newVersion"], event["target"]));
      };
    }

    if (onBlocked != null) {
      request["onblocked"] = (JsObject event) {};
    }

    return c.future;
  }

  JsObject toJS() => _js;

  JsObject _js;
}

class Database implements JsProxyObject {
  Database._internal(this._js) {}

  void close() {}

  ObjectStore createObjectStore(String name,
      {String keyPath, bool autoIncrement}) {}

  void deleteObjectStore(String name) {}

  Transaction transaction(List<String> storeNames, AccessMode mode) {
    String modestr = "readonly";
    if (mode == AccessMode.READ_WRITE) modestr = "readwrite";
    return new Transaction._internal(
        _js.callMethod("transaction", [new JsArray.from(storeNames), modestr]));
  }

  JsObject toJS() => _js;

  JsObject _js;
}

class VersionChangeEvent {
  VersionChangeEvent(this.oldVersion, this.newVersion, this.target) {}
  final int oldVersion;
  final int newVersion;
  final target;
}

class ObjectStore implements JsProxyObject {
  ObjectStore._internal(this._js) {}

  JsObject toJs() => _js;

  JsObject _js;
}

class Transaction implements JsProxyObject {
  Transaction._internal(this._js) {}

  void abort() {}

  ObjectStore objectStore() =>
      new ObjectStore._internal(_js.callMethod("objectStore"));

  Database get db => new Database._internal(_js["db"]);

  AccessMode get mode {
    String mode = _js["mode"];
    if (mode == "readwrite") return AccessMode.READ_WRITE;
    return AccessMode.READ_ONLY;
  }

  List<String> get objectStoreNames {}

  JsObject toJs() => _js;

  JsObject _js;
}
