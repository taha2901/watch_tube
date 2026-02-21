import 'package:flutter/material.dart';

class ControlBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final bool isActive;

  const ControlBtn({super.key, 
    required this.icon,
    required this.label,
    this.onTap,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = onTap == null
        ? Colors.white12
        : isActive
            ? const Color(0xFFFF3B3B)
            : Colors.white70;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: isActive
                  ? const Color(0xFFFF3B3B).withOpacity(0.15)
                  : const Color(0xFF1E1E2E),
              shape: BoxShape.circle,
              border: Border.all(
                color: isActive
                    ? const Color(0xFFFF3B3B).withOpacity(0.5)
                    : Colors.white.withOpacity(0.08),
              ),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}