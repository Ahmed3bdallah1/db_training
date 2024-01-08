import 'package:db/core/controllers/provider/database_provider.dart';
import 'package:db/screens/modules/provider_modules/add_provider_note.dart';
import 'package:db/screens/widgets/expanded_tile_info.dart';
import 'package:db/screens/widgets/item_container_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/managers/values.dart';

class NotesProviderScreen extends StatelessWidget {
  const NotesProviderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context,provider,_){
        if (notes.isEmpty) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Notes"),
              centerTitle: true,
            ),
            body: const Center(
              child: Text("There are no items here"),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => const AddNoteProvider()));
              },
              child: const Icon(Icons.add),
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text("Notes"),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                // SizedBox(
                //   height: 200,
                //   child: Padding(
                //     padding: const EdgeInsets.symmetric(horizontal: 5),
                //     child: GridView.builder(
                //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                //         crossAxisCount: 2,
                //         crossAxisSpacing: 5,
                //         mainAxisSpacing: 5,
                //       ),
                //       itemCount: notes.length,
                //       itemBuilder: (context, index) {
                //         return itemContainerProvider(context, notes[index]);
                //       },
                //     ),
                //   ),
                // ),
                ExpandedTasks(notes: notes)
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const AddNoteProvider()));
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
