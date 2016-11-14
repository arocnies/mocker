RegExp tableCreationRegExp = new RegExp(r"CREATE TABLE (\w*)\s*\(([\s\S]*?)\)\;");
RegExp tableElementsRegExp = new RegExp(r"[,\s]*([\w ]*?)[\s]*([\w]*)\(([\s\S]*?)\)[,\s]*?", caseSensitive: false);

List<Table> getTablesFromString(String s) {
  List<Table> tables = new List<Table>();
  tableCreationRegExp.allMatches(s)
      .forEach((m) => tables.add(new Table(m.group(1))..addFieldsFromString(m.group(2))));
  return tables;
}

class Table {
  String name;
  List<Field> fields = new List<Field>();

  Table(this.name) {}

  Table.fromString(String s) {
    var m = tableCreationRegExp.firstMatch(s);
    name = m.group(1);
    s = m.group(2);
    addFieldsFromString(s);
  }

  addFieldsFromString(String s) {
    tableElementsRegExp.allMatches(s)
        .forEach((m) => fields.add(new Field(m.group(1), m.group(2), m.group(3))));
  }

  String toString() {
    StringBuffer sb = new StringBuffer();
    sb.write("$name (");
    fields.forEach((f) => sb.write("$f "));
    sb.write(")\n");
    return sb.toString();
  }
}


class Type {
  final _value;
  const Type._internal(this._value);
  toString() => '$_value';

  static const INT = const Type._internal('INT');
  static const INTEGER = const Type._internal('INTEGER');
  static const CHAR = const Type._internal('CHAR');
  static const VARCHAR = const Type._internal('VARCHAR');
  static const ENUM = const Type._internal('ENUM');
  static const UNKNOWN = const Type._internal('UNKNOWN');

  static const List<Type> values = const [INT, INTEGER, CHAR, VARCHAR, ENUM, UNKNOWN];
}

class Field {
  String name;
  var type;
  var param;

  Field(this.name, String type, this.param) {
    this.type = Type.values.firstWhere(
        (v) => v.toString() == type.toUpperCase(), orElse: () => Type.UNKNOWN);
  }

  String toString() {
    return "$name $type($param)";
  }
}

