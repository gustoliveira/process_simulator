import 'package:flutter/material.dart';

class CreatePorcessCard extends StatefulWidget {
  const CreatePorcessCard({super.key});

  @override
  State<CreatePorcessCard> createState() => _CreatePorcessCardState();
}

class _CreatePorcessCardState extends State<CreatePorcessCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: content(),
      onTap: () {
        print('Create new process');
      },
    );
  }

  Widget content() {
    return Container(
      width: 222,
      height: 262,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black),
      ),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      child: Center(
        child: Text('CRIAR NOVO PROCESSO'),
      ),
    );
  }
}
