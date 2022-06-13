import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_app/data/model/detail.dart';

// Mengolah data JSON pada bagian Menu.
class ItemChipBar {
  final int id;
  final Widget bodyWidget;
  final String title;
  final BuildContext? context;

  ItemChipBar(this.id, this.title, this.bodyWidget, {this.context});
}

final List<Item> foods = [];
final List<Item> drinks = [];
const itemIcon = Icon(Icons.circle, size: 10, color: Color(0xFFD74141));


Widget text(String text) {
  return Text(
    text,
    style: GoogleFonts.poppins(
      fontWeight: FontWeight.normal,
      fontSize: 18,
    ),
  );
}


final chipBarList = <ItemChipBar>[
  ItemChipBar(
    0,
    'Foods',
    Table(
      children: foods
          .map(
            (item) => TableRow(
          children: [
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                // Icon ini pemanis
                itemIcon,
                text(item.name),
              ],
            )
          ],
        ),
      )
          .toList(),
    ),
  ),
  ItemChipBar(
    1,
    'Drinks',
    Table(
      children: drinks
          .map(
            (item) => TableRow(
          children: [
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                // Icon ini pemanis
                itemIcon,
                text(item.name),
              ],
            )
          ],
        ),
      )
          .toList(),
    ),
  ),
];
