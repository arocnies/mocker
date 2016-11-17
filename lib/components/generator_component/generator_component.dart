// Copyright (c) 2016, Aaron. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:html';
import 'dart:indexed_db';
import 'dart:typed_data';
import 'package:angular2/core.dart';

import 'package:mocker/table.dart';
import 'package:mocker/app_component.dart';

@Component(
    selector: 'my-generator',
    styleUrls: const ['generator_component.css'],
    templateUrl: 'generator_component.html',)
class GeneratorComponent {
  double dataSize = 1.0;

  Future<Blob> generateData(Table t, int size) async {
    Blob b = new Blob([], 'text/csv', 'native');

    while (b.size < size) {
      List<String> parts = new List<String>();
      t.fields.forEach((f) => parts.add(f.newRandomValue));
      parts.add('\n');

      b = new Blob([b, parts], 'text/csv', 'native');
    }
    downloadBlob(b, '${t.name}.csv');
  }

  downloadBlob(Blob b, String fileName) {
    querySelector('#downloadLink')
      ..setAttribute('href', Url.createObjectUrl(b))
      ..setAttribute('download', '$fileName')
      ..click();
  }

  updateProgressBar(int percent) {
    Element progBar = querySelector('#prog_bar');
    progBar.style.setProperty('width', '$percent');
  }

  onGenerate() {
    tablesList.forEach((t) => generateData(t, dataSize.round()));

//    tablesList.forEach((t) {
//      StringBuffer sb = new StringBuffer('\r\n');
//      Blob blob;
//
//      do {
//        String s = sb.toString();
//        s = s.substring(0, s.length - 1) + '\r\n';
//        sb = new StringBuffer(s);
//        blob = new Blob([s]);
//        t.fields.forEach((f) {
//          sb.write('${f.newRandomValue},');
//        });
//
//      } while (blob.size < dataSize * 1000);
//    });
  }
}