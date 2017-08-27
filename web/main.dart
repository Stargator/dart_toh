// Copyright (c) 2017. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/angular2.dart';
import 'package:angular2/platform/browser.dart';
import 'package:angular_tour_of_heroes/app_component.dart';
import 'package:angular_tour_of_heroes/in_memory_data_service.dart';
import 'package:http/http.dart';

void main() {
  bootstrap(AppComponent, <Provider>[
    provide(Client, useClass: InMemoryDataService)
  // Using a real back end?
  // Import browser_client.dart and change the above to:
  // [provide(Client, useFactory: () => new BrowserClient(), deps: [])]
   ]);
}
