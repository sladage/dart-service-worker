part of IndexedDB;

enum CursorDirection {
  NEXT,
  NEXT_UNIQUE,
  PREV,
  PREV_UNIQUE
}

class Cursor implements JsProxyObject {
  Cursor._internal(this._js) {

  }

  JsObject toJs() => _js;

  JsObject _js;
}

class CursorWithValue extends Cursor {
  CursorWithValue._internal(js) : super._internal(js) {
    
  }
}
