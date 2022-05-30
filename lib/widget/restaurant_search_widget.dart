import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// [SearchWidget] is created with additional setting with searchBar
/// used for access search feature.
class SearchWidget extends StatefulWidget {
  final String text;
  final ValueChanged<String> onChanged;
  final String hintText;

  const SearchWidget(
      {Key? key,
        required this.text,
        required this.onChanged,
        required this.hintText})
      : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  // Controller untuk mendapatkan data teks dari search
  final controller = TextEditingController();
  final FocusNode _focus = FocusNode();

  @override
  Widget build(BuildContext context) {
    // cuma style
    const styleActive = TextStyle();
    const styleHint = TextStyle();
    final style = widget.text.isEmpty ? styleHint : styleActive;
    return Container(
      height: 43,
      margin: const EdgeInsets.all(15),
      decoration: const BoxDecoration(),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextField(
        // Mendapatkan data controller
        controller: controller,
        // Menghias TextField
        decoration: InputDecoration(
          // Icon di awal TextField
          prefixIcon: Icon(
            Icons.search,
            color: Theme.of(context).iconTheme.color,
          ),
          // Icon di akhir TextField
          suffixIcon: _focus.hasFocus || widget.text.isNotEmpty
              ? GestureDetector(
            child: Icon(
              Icons.close,
              color: style.color,
              semanticLabel: AppLocalizations.of(context)!.search_undo,
            ),
            onTap: () {
              controller.clear();
              widget.onChanged('');
              FocusScope.of(context).requestFocus(FocusNode());
            },
          )
              : const Icon(null),
          // Hint dari search bar
          hintText: widget.hintText,
          // Stylle dari hint
          hintStyle: style,
        ),
        style: style,
        onChanged: widget.onChanged,
        focusNode: _focus,
      ),
    );
  }
}
