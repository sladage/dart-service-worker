library ServiceWorkerManager.Manager;

import 'dart:async';
//import 'dart:js';
import 'dart:html' as HTML;
import 'workerinterface.dart';

ServiceWorkerManager serviceWorkerManager = new ServiceWorkerManager();

class ServiceWorkerManager {
  Future<ServiceWorker> register(String scriptUrl) async {
    /*JsObject nav = new JsObject.fromBrowserObject(
            (new JsObject.fromBrowserObject(context['window']))["navigator"]);
    if (nav.hasProperty("serviceWorker")) {
      JsObject sw = new JsObject.fromBrowserObject(nav["serviceWorker"]);
      JsObject swf = sw.callMethod("register",[scriptUrl]);
      JsObject swfr = swf.callMethod("then",[(reg){

      }]);
      swfr.callMethod(method)
    }*/

    HTML.ServiceWorkerRegistration reg =
        await HTML.window.navigator.serviceWorker.register(scriptUrl);
    ServiceWorker sw = new ServiceWorker();
    sw._internal = reg;
    // register handlers
    return sw;
  }
}
