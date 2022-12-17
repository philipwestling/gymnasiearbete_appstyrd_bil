package com.example.gymnasiearbete_appstyrd_bil

import io.flutter.embedding.android.FlutterActivity


class MainActivity: FlutterActivity() {
    RxJavaPlugins.setErrorHandler { throwable ->
  if (throwable is UndeliverableException && throwable.cause is BleException) {
    return@setErrorHandler // ignore BleExceptions since we do not have subscriber
  }
  else {
    throw throwable
  }
}
}


