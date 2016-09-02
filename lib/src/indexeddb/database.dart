part of IndexedDB;

class Database implements JsProxyObject {
  Database._internal(this._js) {}

  void close() {}

  ObjectStore createObjectStore(String name,
      {String keyPath, bool autoIncrement}) {
    var options = {};
    if (keyPath != null) options["keyPath"] = keyPath;
    if (autoIncrement != null) options["autoIncrement"] = autoIncrement;
    JsObject ret = _js
        .callMethod("createObjectStore", [name, new JsObject.jsify(options)]);
    return new ObjectStore._internal(ret);
  }

  void deleteObjectStore(String name) =>
      _js.callMethod("deleteObjectStore", [name]);

  Transaction transaction(List<String> storeNames, AccessMode mode) {
    String modestr = "readonly";
    if (mode == AccessMode.READ_WRITE) modestr = "readwrite";
    return new Transaction._internal(
        _js.callMethod("transaction", [new JsArray.from(storeNames), modestr]));
  }

  JsObject toJs() => _js;

  JsObject _js;
}
