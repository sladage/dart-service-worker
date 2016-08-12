library DSWUtil;

import 'dart:js';
import 'dart:async';

abstract class JsProxyObject {
  JsObject toJs();
}

class Promise implements JsProxyObject {
  Promise.fromFuture(Future f) {
    var exec = (resolve,reject){
      _resolve = resolve;
      _reject = reject;
    };
    _internal = new JsObject(context["Promise"],[exec]);
    f.then((v){
      var ret = (v is JsProxyObject) ? v.toJs() : v;
      _resolve(ret);
    }).catchError((e){
      _reject();
    });
  }

  JsObject toJs() => _internal;

  var _resolve;
  var _reject;
  JsObject _internal;
}
