// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class CustomDropdown extends StatefulWidget {
  final List<String> options;
  final String selectedOption;
  final Function(String) onOptionChanged;
  Function onSaved;

   CustomDropdown({
    Key? key,
    required this.options,
    required this.selectedOption,
    required this.onOptionChanged,
    required this.onSaved,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      borderRadius: BorderRadius.circular(18),
      isDense: true,
      isExpanded: true,
      icon: const Icon(Icons.arrow_drop_down_circle_rounded),
      iconEnabledColor: const Color(0xFFFE9F02),
      value: widget.selectedOption,
      onChanged: (value) {
        setState(() {
          widget.onOptionChanged(value!);
        });
      },
      items: widget.options.map((option) {
        return DropdownMenuItem(
          value: option,
          child: Text(
            option,
            style: GoogleFonts.kanit(
                fontWeight: FontWeight.bold, color: const Color(0xFF212B66)),
          ),
        );
      }).toList(),
    );
  }
}
// 0xFFFE9F02