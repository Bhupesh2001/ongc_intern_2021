import 'package:flutter/material.dart';

class MyTable {
  static TextEditingController _tec0 = TextEditingController();
  static TextEditingController _tec1 = TextEditingController();
  static TextEditingController _tec2 = TextEditingController();
  static TextEditingController _tec3 = TextEditingController();
  static TextEditingController _tec4 = TextEditingController();
  static TextEditingController _tec5 = TextEditingController();
  static TextEditingController _tec6 = TextEditingController();
  static TextEditingController _tec7 = TextEditingController();
  static TextEditingController _tec8 = TextEditingController();
  static TextEditingController _tec9 = TextEditingController();
  static TextEditingController _tec10 = TextEditingController();
  static TextEditingController _tec11 = TextEditingController();
  static TextEditingController _tec12 = TextEditingController();
  static TextEditingController _tec13 = TextEditingController();
  static TextEditingController _tec14 = TextEditingController();
  static TextEditingController _tec15 = TextEditingController();

  static List<String> _data = List.filled(17, '');
  static List getData() {
    _data[0] = _tec0.text;
    _data[1] = _tec1.text;
    _data[2] = _tec2.text;
    _data[3] = _tec3.text;
    _data[4] = _tec4.text;
    _data[5] = _tec5.text;
    _data[6] = _tec6.text;
    _data[7] = _tec7.text;
    _data[8] = _tec8.text;
    _data[9] = _tec9.text;
    _data[10] = _tec10.text;
    _data[11] = _tec11.text;
    _data[12] = _tec12.text;
    _data[13] = _tec13.text;
    _data[14] = _tec14.text;
    _data[15] = _tec15.text;
    return _data;
  }

  static Widget displayTable(BuildContext context, List data) {
    _tec0.text = data[0];
    _tec1.text = data[1];
    _tec2.text = data[2];
    _tec3.text = data[3];
    _tec4.text = data[4];
    _tec5.text = data[5];
    _tec6.text = data[6];
    _tec7.text = data[7];
    _tec8.text = data[8];
    _tec9.text = data[9];
    _tec10.text = data[10];
    _tec11.text = data[11];
    _tec12.text = data[12];
    _tec13.text = data[13];
    _tec14.text = data[14];
    _tec15.text = data[15];

    double edge = 40;

    return Table(
      border: TableBorder.all(),
      columnWidths: const <int, TableColumnWidth>{
        0: FixedColumnWidth(100),
        1: FixedColumnWidth(100),
        2: FixedColumnWidth(100),
        3: FixedColumnWidth(100),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      children: <TableRow>[
        TableRow(
          children: <Widget>[
            TableCell(
                child: Container(
                    height: edge,
                    width: edge,
                    child: TextField(
                        controller: _tec0,
                        decoration: InputDecoration(hintText: '')))),
            TableCell(
                child: Container(
                    height: edge,
                    width: edge,
                    child: TextField(
                        controller: _tec1,
                        decoration: InputDecoration(hintText: '')))),
            TableCell(
                child: Container(
                    height: edge,
                    width: edge,
                    child: TextField(
                        controller: _tec2,
                        decoration: InputDecoration(hintText: '')))),
            TableCell(
                child: Container(
                    height: edge,
                    width: edge,
                    child: TextField(
                        controller: _tec3,
                        decoration: InputDecoration(hintText: '')))),
          ],
        ),
        TableRow(
          children: <Widget>[
            TableCell(
                child: Container(
                    height: edge,
                    width: edge,
                    child: TextField(
                        controller: _tec4,
                        decoration: InputDecoration(hintText: '')))),
            TableCell(
                child: Container(
                    height: edge,
                    width: edge,
                    child: TextField(
                        controller: _tec5,
                        decoration: InputDecoration(hintText: '')))),
            TableCell(
                child: Container(
                    height: edge,
                    width: edge,
                    child: TextField(
                        controller: _tec6,
                        decoration: InputDecoration(hintText: '')))),
            TableCell(
                child: Container(
                    height: edge,
                    width: edge,
                    child: TextField(
                        controller: _tec7,
                        decoration: InputDecoration(hintText: '')))),
          ],
        ),
        TableRow(
          children: <Widget>[
            TableCell(
                child: Container(
                    height: edge,
                    width: edge,
                    child: TextField(
                        controller: _tec8,
                        decoration: InputDecoration(hintText: '')))),
            TableCell(
                child: Container(
                    height: edge,
                    width: edge,
                    child: TextField(
                        controller: _tec9,
                        decoration: InputDecoration(hintText: '')))),
            TableCell(
                child: Container(
                    height: edge,
                    width: edge,
                    child: TextField(
                        controller: _tec10,
                        decoration: InputDecoration(hintText: '')))),
            TableCell(
                child: Container(
                    height: edge,
                    width: edge,
                    child: TextField(
                        controller: _tec11,
                        decoration: InputDecoration(hintText: '')))),
          ],
        ),
        TableRow(
          children: <Widget>[
            TableCell(
                child: Container(
                    height: edge,
                    width: edge,
                    child: TextField(
                        controller: _tec12,
                        decoration: InputDecoration(hintText: '')))),
            TableCell(
                child: Container(
                    height: edge,
                    width: edge,
                    child: TextField(
                        controller: _tec13,
                        decoration: InputDecoration(hintText: '')))),
            TableCell(
                child: Container(
                    height: edge,
                    width: edge,
                    child: TextField(
                        controller: _tec14,
                        decoration: InputDecoration(hintText: '')))),
            TableCell(
                child: Container(
                    height: edge,
                    width: edge,
                    child: TextField(
                        controller: _tec15,
                        decoration: InputDecoration(hintText: '')))),
          ],
        ),
      ],
    );
    // );
  }
}
