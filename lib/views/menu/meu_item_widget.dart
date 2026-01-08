import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final Color containerColor;
  final Icon icon;
  final String label;
  final void Function()? onTap;
  const MenuItem({
    super.key,
    required this.containerColor,
    required this.icon,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: containerColor,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: Row(
            spacing: 16,
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: icon,
              ),
              Flexible(
                child: Text(
                  label,
                  softWrap: true,
                  overflow: TextOverflow.visible,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
