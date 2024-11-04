import 'package:flutter/material.dart';

class MyDrawerButton extends StatelessWidget {
  const MyDrawerButton({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: Icon(icon, color: const Color(0xFF5A6B64)),
      onTap: () {
        Navigator.pop(context);
        onTap.call();
      },
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(title, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
