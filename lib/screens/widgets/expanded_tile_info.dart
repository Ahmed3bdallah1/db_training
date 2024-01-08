import 'package:db/core/controllers/provider/database_provider.dart';
import 'package:db/screens/modules/provider_modules/update_provider_screen.dart';
import 'package:db/screens/widgets/todo_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/managers/values.dart';
import 'expanded_tile.dart';

class ExpandedTasks extends StatelessWidget {
  final List<Map> notes;

  const ExpandedTasks({super.key, required this.notes});

  @override
  Widget build(BuildContext context) {
    bool expanded = false;
    return ExpansionTileEditied(
      firstText: "Tasks",
      secondText:
          'expand to check available tasks for \n${DateTime.now().add(const Duration(days: 1)).toString().substring(2, 10)}',
      onExpansionChanged: (expanded) {
        expanded = !expanded;
      },
      trailing: Padding(
        padding: const EdgeInsets.only(right: 12),
        child: expanded == false
            ? const Icon(
                Icons.arrow_circle_down_outlined,
                color: Colors.white,
              )
            : const Icon(
                Icons.arrow_circle_up,
                color: Colors.white,
              ),
      ),
      children: [
        for (final todo in notes)
          InkWell(
            onLongPress: () {
              titles = todo["title"];
              desc = todo["description"];
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => UpdateNoteProvider(
                            id: todo["id"] ?? 0,
                          )));
            },
            child: TodoTile(
              title: todo["title"],
              description: todo["description"],
              color: Colors.white,
              delete: () {
                showDialog(
                    context: context,
                    builder: (_) {
                      return CupertinoAlertDialog(
                          title: const Text("are u sure u want to delete"),
                          actions: [
                            CupertinoDialogAction(
                                onPressed: () {
                                  context
                                      .read<DatabaseProvider>()
                                      .deleteNote(context: context, id: todo["id"]);
                                  Navigator.pop(context);
                                },
                                child: const Text('ok')),
                            CupertinoDialogAction(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('cancel')),
                          ]);
                    });
              },
              editWidget: InkWell(
                onTap: () {
                  titles = todo["title"];
                  desc = todo["description"];
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => UpdateNoteProvider(
                                id: todo["id"],
                              )));
                },
                child: const Icon(Icons.edit_outlined, color: Colors.white),
              ),
              switcher: const SizedBox.shrink(),
            ),
          )
      ],
    );
  }
}
