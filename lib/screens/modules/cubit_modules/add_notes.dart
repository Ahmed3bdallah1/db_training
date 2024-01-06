import 'package:db/core/controllers/cubit/db_cubit.dart';
import 'package:db/core/controllers/cubit/db_state.dart';
import 'package:db/screens/widgets/botton.dart';
import 'package:db/screens/widgets/text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNote extends StatelessWidget {
  const AddNote({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    TextEditingController title = TextEditingController();
    TextEditingController description = TextEditingController();

    return BlocConsumer<DbCubit, DbState>(
      listener: (context, state) {
        if (state is AddDbDoneState) {
          Navigator.pop(context);
        } else if (state is AddDbInitialState) {
          print("loading");
        } else {
          print("error in adding");
        }
      },
      builder: (context, state) {
        DbCubit cubit = DbCubit.get(context);
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
                        valid: (string) {
                          if (string!.isEmpty) {
                            return "please enter a title";
                          }
                          return null;
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: CustomTextFormField(
                        controller: description,
                        keyboard: TextInputType.text,
                        valid: (string) {
                          if (string!.isEmpty) {
                            return "please enter a description";
                          }
                          return null;
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: DefaultButton(
                        childWidget: const Text("Add"),
                        function: () {
                          if (title.text.isNotEmpty &&
                              description.text.isNotEmpty) {
                            cubit.addNote(
                                title: title.text,
                                description: description.text);
                          }
                        }),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
