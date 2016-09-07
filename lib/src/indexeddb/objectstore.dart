part of IndexedDB;

class ObjectStore implements JsProxyObject {
  ObjectStore._internal(this._js) {}

  /// Creates a structured clone of the value, and stores the cloned value in
  /// the object store. This is for adding new records to an object store.

  Future add(String key, value) {
    Completer c = new Completer();
    var vars = [value];
    if (key != null) vars.add(key);
    JsObject request = _js.callMethod("add", vars);
    request["onsuccess"] = (e) {
      c.complete();
    };
    request["onerror"] = (e) {
      c.completeError(request["error"]);
    };
    return c.future;
  }

  /// Clears this object store. This is for deleting all current records
  /// out of an object store.

  Future clear(String key) {
    Completer c = new Completer();
    JsObject request = _js.callMethod("clear", [key]);
    request["onsuccess"] = (e) {
      c.complete();
    };
    request["onerror"] = (e) {
      c.completeError(request["error"]);
    };
    return c.future;
  }

  Future clearRange(KeyRange range) {
    Completer c = new Completer();
    JsObject request = _js.callMethod("clear", [range.toJs()]);
    request["onsuccess"] = (e) {
      c.complete();
    };
    request["onerror"] = (e) {
      c.completeError(request["error"]);
    };
    return c.future;
  }

  /// Returns the total number of records that match the provided
  /// key or `KeyRange`. If no arguments are provided, it returns the total
  /// number of records in the store.

  Future<int> count(String key) {
    Completer c = new Completer();
    JsObject request = _js.callMethod("count", [key]);
    request["onsuccess"] = (e) {
      c.complete(request["result"]);
    };
    request["onerror"] = (e) {
      c.completeError(request["error"]);
    };
    return c.future;
  }

  Future<int> countRange(KeyRange range) => _requestCall(_js, "result", [range.toJs()], useResult: true);

  Future delete(String key) => _requestCall(_js, "delete", [key]);

  Future deleteRange(KeyRange range) => _requestCall(_js, "delete", [range.toJs()]);

  Future get(String key) => _requestCall(_js, "get", [key]);

  Future getRange(KeyRange range) => _requestCall(_js, "get", [range.toJs()]);

  Future<List> getAll(key_OR_Range, {int count}) {
    Completer c = new Completer();
    var jvar = (key_OR_Range is KeyRange)
        ? (key_OR_Range as KeyRange).toJs()
        : key_OR_Range;
    var jvars = [jvar];
    if (count != null) jvars.add(count);
    JsObject request = _js.callMethod("getAll", jvars);
    request["onsuccess"] = (e) {
      JsArray ret = request["result"];
      c.complete(ret.toList());
    };
    request["onerror"] = (e) {
      c.completeError(request["error"]);
    };
    return c.future;
  }

  Future<List<String>> getAllKeys(KeyRange range, {int count}) {
    Completer c = new Completer();
    var jvars = [range.toJs()];
    if (count != null) jvars.add(count);
    JsObject request = _js.callMethod("getAllKeys", jvars);
    request["onsuccess"] = (e) {
      JsArray ret = request["result"];
      c.complete(ret.toList());
    };
    request["onerror"] = (e) {
      c.completeError(request["error"]);
    };
    return c.future;
  }

  Index createIndex(String indexName, String keyPath,
      {bool unique, bool multiEntry}) {
    var options = {};
    if (unique != null) options["unique"] = unique;
    if (multiEntry != null) options["multiEntry"] = multiEntry;
    var ret = _js.callMethod(
        "createIndex", [indexName, keyPath, new JsObject.jsify(options)]);
    return new Index._internal(ret);
  }

  void deleteIndex(String indexName) {
    _js.callMethod("deleteIndex", [indexName]);
  }

  Index index(String indexName) {
    return new Index._internal(_js.callMethod("index", [indexName]));
  }

  Future<CursorWithValue> openCursor(
      {String key, KeyRange range, CursorDirection direction}) {
    var vars = [];
    if (key != null || range != null) {
      vars.add(key != null ? key : range);
    }
    if (direction != null) {
      String dir = "next";
      if (direction == CursorDirection.NEXT_UNIQUE) dir = "nextunique";
      if (direction == CursorDirection.PREV) dir = "prev";
      if (direction == CursorDirection.PREV_UNIQUE) dir = "prevunique";
      vars.add(dir);
    }

    Completer c = new Completer();
    JsObject request = _js.callMethod("openCursor", vars);
    request["onsuccess"] = (e) {
      c.complete(new CursorWithValue._internal(request["result"]));
    };
    request["onerror"] = (e) {
      c.completeError(request["error"]);
    };
    return c.future;
  }

  Future<CursorWithValue> openKeyCursor(
      {KeyRange range, CursorDirection direction}) {
    var vars = [];
    if (range != null) {
      vars.add(range);
    }
    if (direction != null) {
      String dir = "next";
      if (direction == CursorDirection.NEXT_UNIQUE) dir = "nextunique";
      if (direction == CursorDirection.PREV) dir = "prev";
      if (direction == CursorDirection.PREV_UNIQUE) dir = "prevunique";
      vars.add(dir);
    }

    Completer c = new Completer();
    JsObject request = _js.callMethod("openKeyCursor", vars);
    request["onsuccess"] = (e) {
      c.complete(new CursorWithValue._internal(request["result"]));
    };
    request["onerror"] = (e) {
      c.completeError(request["error"]);
    };
    return c.future;
  }

  bool get autoIncrement => _js["autoIncrement"];

  List<String> get indexNames => (_js["indexNames"] as JsArray).toList();

  String get keyPath => _js["keyPath"];

  String get name => _js["name"];
  void set name(String name) {
    _js["name"] = name;
  }

  Transaction get transaction => new Transaction._internal(_js["transaction"]);

  JsObject toJs() => _js;

  JsObject _js;
}
