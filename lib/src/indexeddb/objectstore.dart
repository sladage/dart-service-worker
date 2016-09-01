part of IndexedDB;


class ObjectStore implements JsProxyObject {
  ObjectStore._internal(this._js) {}

  Future add(value,[String key]) {
    Completer c = new Completer();
    var vars = [value];
    if (key != null) vars.add(key);
    JsObject request = _js.callMethod("add",vars);
    request["onsuccess"] = (e) {
      c.complete();
    };
    request["onerror"] = (e) {
      c.completeError(request["error"]);
    };
    return c.future;
  }

  Future clear(key_OR_Range) {
    Completer c = new Completer();
    var jvar = (key_OR_Range is KeyRange) ? (key_OR_Range as KeyRange).toJs() : key_OR_Range;
    JsObject request = _js.callMethod("clear",[jvar]);
    request["onsuccess"] = (e) {
      c.complete();
    };
    request["onerror"] = (e) {
      c.completeError(request["error"]);
    };
    return c.future;
  }

  Future<int> count(key_OR_Range) {
    Completer c = new Completer();
    var jvar = (key_OR_Range is KeyRange) ? (key_OR_Range as KeyRange).toJs() : key_OR_Range;
    JsObject request = _js.callMethod("count",[jvar]);
    request["onsuccess"] = (e) {
      c.complete(request["result"]);
    };
    request["onerror"] = (e) {
      c.completeError(request["error"]);
    };
    return c.future;
  }

  Future delete(key_OR_Range) {
    Completer c = new Completer();
    var jvar = (key_OR_Range is KeyRange) ? (key_OR_Range as KeyRange).toJs() : key_OR_Range;
    JsObject request = _js.callMethod("delete",[jvar]);
    request["onsuccess"] = (e) {
      c.complete();
    };
    request["onerror"] = (e) {
      c.completeError(request["error"]);
    };
    return c.future;
  }

  Future get(key_OR_Range) {
    Completer c = new Completer();
    var jvar = (key_OR_Range is KeyRange) ? (key_OR_Range as KeyRange).toJs() : key_OR_Range;
    JsObject request = _js.callMethod("get",[jvar]);
    request["onsuccess"] = (e) {
      c.complete(request["result"]);
    };
    request["onerror"] = (e) {
      c.completeError(request["error"]);
    };
    return c.future;
  }

  Future<List> getAll(key_OR_Range,{int count}) {
    Completer c = new Completer();
    var jvar = (key_OR_Range is KeyRange) ? (key_OR_Range as KeyRange).toJs() : key_OR_Range;
    var jvars = [jvar];
    if (count != null) jvars.add(count);
    JsObject request = _js.callMethod("getAll",jvars);
    request["onsuccess"] = (e) {
      JsArray ret = request["result"];
      c.complete(ret.toList());
    };
    request["onerror"] = (e) {
      c.completeError(request["error"]);
    };
    return c.future;
  }

  Future<List<String>> getAllKeys(KeyRange range,{int count}) {
    Completer c = new Completer();
    var jvars = [range.toJs()];
    if (count != null) jvars.add(count);
    JsObject request = _js.callMethod("getAllKeys",jvars);
    request["onsuccess"] = (e) {
      JsArray ret = request["result"];
      c.complete(ret.toList());
    };
    request["onerror"] = (e) {
      c.completeError(request["error"]);
    };
    return c.future;
  }

  Index createIndex(String indexName, String keyPath, {bool unique, bool multiEntry}) {
    var options = {};
    if (unique != null) options["unique"] = unique;
    if (multiEntry != null) options["multiEntry"] = multiEntry;
    var ret = _js.callMethod("createIndex",[indexName,keyPath,new JsObject.jsify(options)]);
    return new Index._internal(ret);
  }

  void deleteIndex(String indexName) {
    _js.callMethod("deleteIndex",[indexName]);
  }

  Index index(String indexName) {
    return new Index._internal(_js.callMethod("index",[indexName]));
  }

  Future<CursorWithValue> openCursor({String key, KeyRange range, CursorDirection direction}) {
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
    JsObject request = _js.callMethod("openCursor",vars);
    request["onsuccess"] = (e) {
      c.complete(new CursorWithValue._internal(request["result"]));
    };
    request["onerror"] = (e) {
      c.completeError(request["error"]);
    };
    return c.future;
  }

  JsObject toJs() => _js;

  JsObject _js;
}
