// Copyright (c) 2016, Aaron. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';

import 'table.dart';
import 'dart:html';

@Component(
    selector: 'my-app',
    styleUrls: const ['app_component.css'],
    templateUrl: 'app_component.html')
class AppComponent {
  String tableRegex = tableCreationRegExp.pattern.toString();
  String fieldRegex = tableElementsRegExp.pattern.toString();
  String output = "";

  void run() {
    TextAreaElement input = querySelector('#input');
    Element output = querySelector('#output');
    output.children.clear();
    getTablesFromString(input.value).forEach(
        (t) => output.append(new Element.p()..appendText(t.toString())));
  }

}
