import 'package:db/core/controllers/cubit/db_cubit.dart';
import 'package:db/screens/modules/cubit_modules/update_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../core/managers/values.dart';

Widget itemContainerProvider(BuildContext context, Map note) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.indigo.withOpacity(.6),
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color: Colors.indigo),
    ),
    child: Stack(children: [
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(note["title"],
                style: const TextStyle(color: Colors.white, fontSize: 18)),
            Text(note["description"],
                style: TextStyle(
                    color: Colors.white.withOpacity(.8), fontSize: 12))
          ],
        ),
      ),
      Positioned(
        right: 0,
        bottom: 0,
        child: Padding(
          padding: const EdgeInsets.only(right: 12, bottom: 12),
          child: InkWell(
              onTap: () {
                titles = note['title'];
                desc = note['description'];
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return UpdateNote(id: note["id"]);
                }));
              },
              child: const Icon(
                Icons.edit,
                color: Colors.white,
              )),
        ),
      ),
      Positioned(
        left: 0,
        bottom: 0,
        child: Padding(
          padding: const EdgeInsets.only(left: 12, bottom: 12),
          child: InkWell(
              onTap: () {
                showCupertinoDialog(
                    context: context,
                    builder: (_) {
                      return CupertinoAlertDialog(
                        title: const Text("Delete"),
                        content: Text("${note["title"]} Note will be deleted"),
                        actions: [
                          CupertinoDialogAction(
                              child: const Text("ok"),
                              onPressed: () {
                                DbCubit.get(context).deleteNote(id: note["id"]);
                                Navigator.pop(context);
                              }),
                          CupertinoDialogAction(
                              child: const Text("cancel"),
                              onPressed: () {
                                Navigator.pop(context);
                              }),
                        ],
                      );
                    });
              },
              child: const Icon(
                Icons.delete,
                color: Colors.white,
              )),
        ),
      ),
    ]),
  );
}
