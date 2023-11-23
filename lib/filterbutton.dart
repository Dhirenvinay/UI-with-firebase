import 'package:flutter/material.dart';

class FilterButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final Color colors;
  const FilterButton(
      {super.key,
      required this.onTap,
      required this.text,
      required this.colors});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(left: 10, top: 20),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          // border: Border.all(color: const Color(0xff0066A5)),
          color: colors,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 15,
              color: colors == Color(0xff0066a5)
                  ? Colors.white
                  : Color(0xff0066a5),
            ),
          ),
        ),
      ),
    );
  }
}
