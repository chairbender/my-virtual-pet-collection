import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_virtual_pet_collection/user/user.dart';

class OwnedShellDetails extends StatelessWidget {
  final OwnedShell ownedShell;

  const OwnedShellDetails(this.ownedShell, {super.key});
  @override
  Widget build(BuildContext context) {
    // TODO: details of shell, clickable list of obtained pets
    return Scaffold(
      appBar: AppBar(title: Text(ownedShell.nickname)),
    );
  }

}