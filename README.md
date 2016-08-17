# Dart Service Worker library

Write Web Apps using Dart with Service Worker support. (Currently only supports compilation to javascript)

## Usage

Landing page:

```
import 'package:dart_service_worker/serviceworkermanager.dart' as SW;

main() async {
  try {
    SW.ServiceWorker sw = await SW.serviceWorkerManager.register("sw.js");
    print("registered");
    sw.onMessage.listen((SW.MessageEvent e){
      print(e.data);
    });
  } catch(e) {
    print(e);
  }
}
```

Service worker:

```
void main() {
  ServiceWorker sw = new ServiceWorker();
  sw.onInstall.listen((e){
    print("install");
    //setup cache
  });

  sw.onActivate.listen((e){
    print("activate");
  });

  sw.onMessage.listen((MessageEvent e){
    print("msg:"+e.data);
  });

  sw.onFetch.listen((FetchEvent e){
    print("fetch");
    e.respondWith(getReponse(e.request));
  });
}

Future<Response> getReponse(Request r) async {
  Response response = await caches.match(r);
  if (response != null) {
    return response;
  }
  return fetch(request:r.clone());
}
```
