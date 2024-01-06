import 'package:db/core/controllers/cubit/db_cubit.dart';
import 'package:db/core/controllers/cubit/db_state.dart';
import 'package:db/screens/modules/cubit_modules/add_notes.dart';
import 'package:db/screens/widgets/item_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/managers/values.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DbCubit, DbState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (notes.isEmpty) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Notes"),
              centerTitle: true,
            ),
            body: const Center(
              child: Text("There is no items here"),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const AddNote()));
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
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, crossAxisSpacing: 5, mainAxisSpacing: 5),
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  return itemContainer(context, notes[index]);
                }),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const AddNote()));
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
