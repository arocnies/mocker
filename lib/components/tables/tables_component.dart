// Copyright (c) 2016, Aaron. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';

import 'package:mocker/table.dart';
import 'package:mocker/app_component.dart';

@Component(
    selector: 'my-tables',
    styleUrls: const ['tables_component.css'],
    templateUrl: 'tables_component.html',)
class TablesComponent {
  Table selectedTable;
  List<Table> get tables => tablesList;
  List<Field> get fields => selectedTable.fields;

  onSelect(Table t) {
    selectedTable = t;
  }
}
