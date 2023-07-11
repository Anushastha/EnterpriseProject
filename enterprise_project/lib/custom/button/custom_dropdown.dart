// import 'package:control_style/decorated_input_border.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';

// import '../theme.dart';

// class CustomDropDown extends StatelessWidget {
//   final String? Function(String?)? validator;
//   final String? hint;
//   final String lableText;
//   final List<String> dropdownItems;
//   final ValueChanged<String?>? onChanged;

//   CustomDropDown(
//       {super.key,
//       this.validator,
//       this.hint,
//       required this.lableText,
//       required this.dropdownItems,
//       this.onChanged});

//   String? selectedValue;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       // height: 60,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [
//           BoxShadow(
//             color: CustomTheme.shadowColor,
//             blurRadius: 7,
//             spreadRadius: 2.2,
//           ),
//         ],
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           DropdownButtonFormField2<String>(
//             isExpanded: true,
//             decoration: InputDecoration(
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                   borderSide: BorderSide(
//                     width: 0,
//                     style: BorderStyle.none,
//                   ),
//                 ),
//                 disabledBorder: InputBorder.none,
//                 filled: true,
//                 fillColor: CustomTheme.whiteText,
//                 contentPadding: EdgeInsets.symmetric(
//                   horizontal: 20,
//                   vertical: 13,
//                 ),
//                 label: Text(
//                   lableText,
//                   style: TextStyle(fontSize: 15, color: CustomTheme.lightText),
//                 ),
//                 // prefixIcon: widget.prefixIcon,
//                 // suffixIcon: widget.suffixIcon,

//                 hintText: hint,
//                 hintStyle: TextStyle(
//                   fontSize: 15,
//                   color: CustomTheme.lightText,
//                 )),
//             // hint: Text(
//             //   'Select Your Gender',
//             //   style: TextStyle(
//             //     fontSize: 14,
//             //     color: CustomTheme.lightText,
//             //   ),
//             // ),
//             items: dropdownItems
//                 .map((item) => DropdownMenuItem<String>(
//                       value: item,
//                       child: Text(
//                         item,
//                         style: const TextStyle(
//                           fontSize: 14,
//                         ),
//                       ),
//                     ))
//                 .toList(),
//             validator: validator,

//             onChanged: (value) {
//               // setState(() {
//               //   selectedValue = value;
//               // });
//               onChanged?.call(value);
//             },
//             onSaved: (value) {
//               selectedValue = value.toString();
//             },
//             buttonStyleData: const ButtonStyleData(
//               padding: EdgeInsets.only(right: 8),
//             ),
//             iconStyleData: const IconStyleData(
//               icon: Icon(
//                 Icons.arrow_drop_down,
//                 color: Colors.black45,
//               ),
//               iconSize: 24,
//             ),
//             dropdownStyleData: DropdownStyleData(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(15),
//               ),
//             ),
//             menuItemStyleData: const MenuItemStyleData(
//               padding: EdgeInsets.symmetric(horizontal: 16),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
