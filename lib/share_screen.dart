import 'package:flutter/material.dart';
import 'package:flutter_sharing_intent/model/sharing_file.dart';

class ShareScreen extends StatelessWidget {
  const ShareScreen({super.key, required this.sharedFiles});

  final List<SharedFile> sharedFiles;

  @override
  Widget build(BuildContext context) {
    const title = 'Shared Files List';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(title),
        ),
        body: ListView.builder(
          itemCount: sharedFiles.length,
          prototypeItem: ListTile(
            title: Text(sharedFiles.first.toString()),
          ),
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(sharedFiles[index].toString()),
            );
          },
        ),
      ),
    );
  }
}
