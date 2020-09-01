import 'package:flutter/material.dart';

class ChoicechipWidget extends StatelessWidget {
  const ChoicechipWidget(
      {Key key,
      this.icon,
      this.text,
      this.selected,
      this.selectedTextColor,
      this.unselectedTextColor,
      this.onSelected,
      this.unselectedTextBackgroundColor,
      this.selectedTextBackgroundColor})
      : super(key: key);

  final Icon icon;
  final String text;
  final bool selected;
  final Function(bool) onSelected;
  final Color selectedTextColor;
  final Color unselectedTextColor;
  final Color unselectedTextBackgroundColor;
  final Color selectedTextBackgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ChoiceChip(
          backgroundColor: selected
              ? selectedTextBackgroundColor
              : unselectedTextBackgroundColor,
          selectedColor: selected
              ? selectedTextBackgroundColor
              : unselectedTextBackgroundColor,
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if(icon != null) icon,
              Flexible(child: Text(
                '$text',
                style: TextStyle(
                  fontSize: 12,
                    color: selected ? selectedTextColor : unselectedTextColor),
              ),),
            ],
          ),
          selected: selected,
          onSelected: onSelected),
    );
  }
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10),
//       child: ChoiceChip(
//         backgroundColor: selected == 0 ? unselectedTextBackgroundColor : selected == 1 ? selectedTextBackgroundColor : Colors.red,
//       label: Text(
//         '$text',
//         style: TextStyle(
//           color: selected == 0 ? unselectedTextBackgroundColor : selectedTextColor
//         )
//       ),
//       selected: selected == 0 ? false : true,
//       onSelected: onSelected,
//       )
//     );
//   }

}
