import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:staff_connect/utilities/ReUsable_Functions.dart';

class DropDown extends StatefulWidget {
  final Future<List<String>> itemList;

  const DropDown({
    Key? key,
    required this.itemList,
  }) : super(key: key);

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  List<String> selectedItems = [];

  @override
  Widget build(BuildContext context) {
    SelectedItemProvider selectedItemProvider = SelectedItemProvider();
    var res = MediaQuery.of(context);
    return FutureBuilder<List<String>>(
      future: widget.itemList,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading indicator while waiting for the itemList
          return Container(
            decoration: const BoxDecoration(
              color: Color(0xFFFE9F02),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            alignment: AlignmentDirectional.topStart,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
              child: Text(
                "wait...",
                style: TextStyle(
                  fontSize: 15,
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 1,
              ),
            ),
          );
        } else if (snapshot.hasError) {
          // Show an error message if the itemList retrieval failed
          return Text('Error: ${snapshot.error}');
        } else {
          // Build the dropdown with the retrieved itemList
          List<String> itemList = snapshot.data ?? [];
          return DropdownButtonHideUnderline(
            child: DropdownButton2(
              isExpanded: true,
              hint: const Align(
                alignment: AlignmentDirectional.topStart,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    "👉 Select Here",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF212B66),
                    ),
                  ),
                ),
              ),
              items: itemList.map((item) {
                return DropdownMenuItem<String>(
                  value: item,
                  enabled: false,
                  child: StatefulBuilder(
                    builder: (context, menuSetState) {
                      final isSelected = selectedItems.contains(item);
                      return InkWell(
                        onTap: () {
                          isSelected
                              ? selectedItems.remove(item)
                              : selectedItems.add(item);
                          setState(() {});
                          menuSetState(() {});
                        },
                        child: Container(
                          height: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            children: [
                              isSelected
                                  ? const Icon(Icons.check_box_outlined)
                                  : const Icon(Icons.check_box_outline_blank),
                              const SizedBox(width: 16),
                              Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }).toList(),
              value: selectedItems.isEmpty ? null : selectedItems.last,
              onChanged: (value) {},
              selectedItemBuilder: (context) {
                return itemList.map(
                  (item) {
                    return Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFFFE9F02),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      alignment: AlignmentDirectional.topStart,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 3),
                        child: Text(
                          selectedItems.join(', '),
                          style: const TextStyle(
                            fontSize: 15,
                            overflow: TextOverflow.ellipsis,
                          ),
                          maxLines: 1,
                        ),
                      ),
                    );
                  },
                ).toList();
              },
              buttonStyleData: ButtonStyleData(
                height: 40,
                width: res.size.width,
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 35,
                padding: EdgeInsets.zero,
              ),
            ),
          );
        }
      },
    );
  }
}
