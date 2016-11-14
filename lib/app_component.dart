// Copyright (c) 2016, Aaron. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';

import 'package:mocker/components/tables/tables_component.dart';
import 'table.dart';
import 'dart:html';

@Component(
    selector: 'my-app',
    styleUrls: const ['app_component.css'],
    templateUrl: 'app_component.html',
    directives: const [TablesComponent])
class AppComponent {
  String tableRegex = tableCreationRegExp.pattern.toString();
  String fieldRegex = tableElementsRegExp.pattern.toString();
  String output = "";

  void processTables() {
    TextAreaElement input = querySelector('#input');
    getTablesFromString(input.value).forEach(
        (t) => tablesList.add(t));
  }

}

List<Table> tablesList = [];
