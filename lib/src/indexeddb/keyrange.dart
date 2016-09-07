part of IndexedDB;

class KeyRange implements JsProxyObject {
  /// Creates a new key range with upper and lower bounds.
  KeyRange.bound(String lower, String upper, {bool lowerOpen:false,bool upperOpen:false}) {
    _js = new JsObject(context["IDBKeyRange"]["bound"],[lower,upper,lowerOpen,upperOpen]);
  }

  KeyRange.only(String key) {
    _js = new JsObject(context["IDBKeyRange"]["only"],[key]);
  }

  KeyRange.lowerBound(String bound, {bool open: false}) {
    _js = new JsObject(context["IDBKeyRange"]["lowerBound"],[bound]);
  }

  KeyRange.upperBound(String bound, {bool open: false}) {
    _js = new JsObject(context["IDBKeyRange"]["upperBound"],[bound]);
  }

  bool includes(String key) => _js.callMethod("includes",[key]);

  String get lower => _js["lower"];
  bool get lowerOpen => _js["lowerOpen"];
  String get upper => _js["upper"];
  bool get upperOpen => _js["upperOpen"];

  JsObject toJs() => _js;

  JsObject _js;
}
