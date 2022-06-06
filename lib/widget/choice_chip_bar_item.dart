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

/// membuat widget text karena item yang diakses adalah sama-sama text.
Widget text(String text) {
  return Text(
    text,
    style: GoogleFonts.poppins(
      fontWeight: FontWeight.normal,
      fontSize: 18,
    ),
  );
}

/// Membuat daftar chip secara manual.
final chipBarList = <ItemChipBar>[
  ItemChipBar(
    0,
    'Foods',
    Table(
      // Membagi daftar makanan dengan fungsi
      // map (ingat kalo map itu membagi berdasarkan key - value pada JSON)
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
      // Membagi daftar minuman dengan fungsi
      // map (ingat kalo map itu membagi berdasarkan key - value pada JSON)
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
