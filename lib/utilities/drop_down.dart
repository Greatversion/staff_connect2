// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';

// class DropDown extends StatefulWidget {
//   final List items;
//   String text;
//   DropDown({
//     Key? key,
//     required this.items,
//     required this.text,
//   }) : super(key: key);

//   @override
//   State<DropDown> createState() => _DropDownState();
// }

// class _DropDownState extends State<DropDown> {
//   final List<String> items = [
//     z
//   ];
//   List<String> selectedItems = [];
//   late List<String?> items;
//   String? text;

//   @override
//   Widget build(BuildContext context) {
//     var res = MediaQuery.of(context);
//     return DropdownButtonHideUnderline(
//         child: DropdownButton2(
//       isExpanded: true,
//       hint: Align(
//         alignment: AlignmentDirectional.topStart,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: Text(
//             text!,
//             style: const TextStyle(
//               fontSize: 17,
//               fontWeight: FontWeight.bold,
//               color: Color(0xFF212B66),
//             ),
//           ),
//         ),
//       ),
//       items: items.map((item) {
//         return DropdownMenuItem<String>(
//           value: item,
//           //disable default onTap to avoid closing menu when selecting an item
//           enabled: false,
//           child: StatefulBuilder(
//             builder: (context, menuSetState) {
//               final isSelected = selectedItems.contains(item);
//               return InkWell(
//                 onTap: () {
//                   isSelected
//                       ? selectedItems.remove(item)
//                       : selectedItems.add(item);
//                   //This rebuilds the StatefulWidget to update the button's text
//                   setState(() {});
//                   //This rebuilds the dropdownMenu Widget to update the check mark
//                   menuSetState(() {});
//                 },
//                 child: Container(
//                   height: double.infinity,
//                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                   child: Row(
//                     children: [
//                       isSelected
//                           ? const Icon(Icons.check_box_outlined)
//                           : const Icon(Icons.check_box_outline_blank),
//                       const SizedBox(width: 16),
//                       Text(
//                         item!,
//                         style: const TextStyle(
//                           fontSize: 14,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         );
//       }).toList(),
//       //Use last selected item as the current value so if we've limited menu height, it scroll to last item.
//       value: selectedItems.isEmpty ? null : selectedItems.last,
//       onChanged: (value) {},
//       selectedItemBuilder: (context) {
//         return items.map(
//           (item) {
//             return Container(
//               alignment: AlignmentDirectional.topStart,
//               child: Text(
//                 selectedItems.join(', '),
//                 style: const TextStyle(
//                   fontSize: 14,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 maxLines: 1,
//               ),
//             );
//           },
//         ).toList();
//       },
//       buttonStyleData: ButtonStyleData(
//         height: 40,
//         width: res.size.width,
//       ),
//       menuItemStyleData: const MenuItemStyleData(
//         height: 25,
//         padding: EdgeInsets.zero,
//       ),
//     ));
//   }
// }
