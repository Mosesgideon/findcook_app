import 'package:flutter/material.dart';

class CustomActionButton extends StatefulWidget {
  const CustomActionButton(
      {super.key,
      this.size = 34,
      required this.child,
      required this.onTap,
      this.gradient});

  final double size;
  final Widget child;
  final VoidCallback onTap;
  final Gradient? gradient;

  @override
  State<CustomActionButton> createState() => _CustomActionButtonState();
}

class _CustomActionButtonState extends State<CustomActionButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        height: widget.size,
        width: widget.size,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: widget.gradient ??
                const LinearGradient(colors: [
                  Color(0xFF0E315D),
                  Color(0xFF1D67C3),
                ])),
        child: widget.child,
      ),
    );
  }
}
