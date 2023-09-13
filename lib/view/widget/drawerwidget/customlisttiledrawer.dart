import 'package:flutter/material.dart';

class CustomListTileDrawer extends StatelessWidget {
  final IconData icon;
  final void Function() onTap;
  final String text;
  final Widget? trailing;
  const CustomListTileDrawer({Key? key, required this.icon, required this.onTap, required this.text, this.trailing}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      onTap: onTap,
      title: Text(text,style: const TextStyle(fontSize: 17,fontWeight: FontWeight.w600)),
      trailing: trailing,
    );
  }
}