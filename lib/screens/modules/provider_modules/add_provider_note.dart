import 'package:db/core/controllers/provider/database_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/botton.dart';
import '../../widgets/text_form.dart';

class AddNoteProvider extends StatelessWidget {
  const AddNoteProvider({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final TextEditingController title = TextEditingController();
    final TextEditingController description = TextEditingController();

    return Consumer<DatabaseProvider>(
      builder: (context, provider, _) {
        return Scaffold(
          appBar: AppBar(title: const Text("Add notes"), centerTitle: true),
          body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: CustomTextFormField(
                      controller: title,
                      keyboard: TextInputType.text,
                      valid: (String? string) {
                        if (string!.isEmpty) {
                          return "please enter a title";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: CustomTextFormField(
                      controller: description,
                      keyboard: TextInputType.text,
                      valid: (String? string) {
                        if (string!.isEmpty) {
                          return "please enter a description";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: DefaultButton(
                      childWidget: const Text("Add"),
                      function: () {
                        if (title.text.isNotEmpty &&
                            description.text.isNotEmpty) {
                          provider.addNote(
                            context: context,
                            title: title.text,
                            description: description.text,
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
