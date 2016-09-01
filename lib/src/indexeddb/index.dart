part of IndexedDB;

class Index implements JsProxyObject {
  Index._internal(this._js) {
    
  }

  JsObject toJs() => _js;
  JsObject _js;
}
