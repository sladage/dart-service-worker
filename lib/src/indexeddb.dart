library IndexedDB;

import 'dart:js';
import 'util.dart';
import 'dart:async';

part 'indexeddb/database.dart';
part 'indexeddb/keyrange.dart';
part 'indexeddb/index.dart';
part 'indexeddb/cursor.dart';
part 'indexeddb/objectstore.dart';
part 'indexeddb/transaction.dart';

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

  JsObject toJs() => _js;

  JsObject _js;
}


class VersionChangeEvent {
  VersionChangeEvent(this.oldVersion, this.newVersion, this.target) {}
  final int oldVersion;
  final int newVersion;
  final target;
}
