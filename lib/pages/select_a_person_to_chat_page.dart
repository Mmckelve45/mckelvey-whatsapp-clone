
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/models/user_data.dart';
import 'package:whatsapp_clone/providers.dart';
import '../models/chat.dart';


class SelectPersonToChat extends ConsumerWidget {
  const SelectPersonToChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Person to Chat"),
      ),
      body: SafeArea(
        child: StreamBuilder<List<UserData>>(
          stream: ref.read(databaseProvider)!.getUsers(),
          builder: ((context, snapshot) {
            
          } ),)),
    );
  }
}