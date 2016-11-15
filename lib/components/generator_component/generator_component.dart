// Copyright (c) 2016, Aaron. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'package:angular2/core.dart';

import 'package:mocker/table.dart';
import 'package:mocker/app_component.dart';

@Component(
    selector: 'my-generator',
    styleUrls: const ['generator_component.css'],
    templateUrl: 'generator_component.html',)
class GeneratorComponent {
  double dataSize;

  onGenerate() {
    tablesList.forEach((t) {
      StringBuffer sb = new StringBuffer();
      t.fields.forEach((f) {
        sb.write('${f.newRandomValue},');
      });
      Blob blob = new Blob([sb.toString()]);
      querySelector('#downloadLink')
        ..setAttribute('href', Url.createObjectUrl(blob))
        ..setAttribute('download', '${t.name}.csv')
        ..click();
    });
  }
}
