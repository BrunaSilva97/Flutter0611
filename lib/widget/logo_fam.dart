import 'package:flutter/material.dart';

import '../cores/cores_fam.dart';

class LogoFam extends StatelessWidget {
  final double largura;
  LogoFam({super.key, this.largura = 160});

  @override
  Widget build(BuildContext context) => Image.asset(
    'assets\images\logo_FAM.png',
    width: largura,
    errorBuilder: (_, _, _) =>
        const Text('FAM', style: TextStyle(fontSize: 30)),
  );
}
