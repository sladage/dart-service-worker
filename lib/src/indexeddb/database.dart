part of IndexedDB;


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
