// import 'package:flutter/material.dart';

// import 'package:provider/provider.dart';

// import 'package:staff_connect/utilities/ReUsable_Functions.dart';
// import 'package:staff_connect/utilities/drop_down.dart';

// class UserInformation extends StatelessWidget {
//   const UserInformation({super.key});

//   @override
//   Widget build(BuildContext context) {
//     TextEditingController _name = TextEditingController();

//     UserDataProvider userDataProvider = Provider.of<UserDataProvider>(context);
//     List? items = {"ww", "LL"} as List?;
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.only(top: 4, left: 10, right: 10),
//           child: Column(
//             children: [
//               Center(
//                 child: CircleAvatar(
//                   radius: 35,
//                   backgroundImage: NetworkImage(userDataProvider.downloadUrl!),
//                 ),
//               ),
//               const SizedBox(height: 5),
//               // TextInput(name: _name, labelText: "Name"),
//               const SizedBox(height: 1),
//               TextInput(name: _name, labelText: "E-Mail"),
//               const SizedBox(height: 9),
//               DropDown(items: items!, text: 'Select Department'),
//               const SizedBox(height: 6),
//               DropDown(items: items, text: 'Select JobRoles'),
//               const SizedBox(height: 6),
//               DropDown(items: items, text: 'Select Posts'),
//               const SizedBox(height: 6),
//               DropDown(items: items, text: 'Select Skills')
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // ignore: must_be_immutable
// class TextInput extends StatelessWidget {
//   TextEditingController name;
//   String labelText;
//   TextInput({
//     Key? key,
//     required this.name,
//     required this.labelText,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     TextEditingController name = TextEditingController();
//     return Padding(
//       padding: const EdgeInsets.only(top: 10, left: 12, right: 12),
//       child: TextFormField(
//         style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
//         controller: name,
//         decoration: InputDecoration(
//             contentPadding: const EdgeInsets.all(14),
//             border: const OutlineInputBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(32))),
//             focusedBorder: const OutlineInputBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(32))),
//             labelText: labelText,
//             labelStyle: const TextStyle(color: Color(0xFF212B66))),
//         validator: (value) {
//           if (value!.isEmpty) {
//             return 'Please Enter a $name';
//           }
//           return null;
//         },
//       ),
//     );
//   }
// }
