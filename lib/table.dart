import 'dart:math';

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
  Type type;
  var arg;
  Function genFunction;

  static final Random rng = new Random();
  static final Map<Type, Function> defaultFunctions = {
    Type.INT : (a) => '${getDigitString(int.parse(a))}',
    Type.INTEGER : (a) => '${getDigitString(int.parse(a))}',
    Type.CHAR : (a) => '${getDigitString(int.parse(a))}',
    Type.VARCHAR : (a) => '${getDigitString(int.parse(a))}',
    Type.ENUM : (a) => '${a.split(',')[rng.nextInt(a.split(',').length-1)]}',
    Type.UNKNOWN : (a) => r'\N',
  };

  static String getDigitString(int n) {
    var sb = new StringBuffer();
    for (var i = 0; i < 4; i++) {
      sb.write(rng.nextInt(10));
    }
    return sb.toString();
  }

  Field(this.name, String type, this.arg) {
    this.type = Type.values.firstWhere(
        (v) => v.toString() == type.toUpperCase(), orElse: () => Type.UNKNOWN);
    genFunction = defaultFunctions[this.type];
  }

  get newRandomValue => genFunction(arg);

  String toString() {
    return "$name $type($arg)";
  }
}

