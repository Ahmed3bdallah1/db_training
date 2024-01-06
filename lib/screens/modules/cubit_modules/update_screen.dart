import 'package:db/core/managers/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/controllers/cubit/db_cubit.dart';
import '../../../core/controllers/cubit/db_state.dart';
import '../../widgets/botton.dart';
import '../../widgets/text_form.dart';

class UpdateNote extends StatelessWidget {
  final int id;

  const UpdateNote({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    TextEditingController title = TextEditingController(text: titles);
    TextEditingController description = TextEditingController(text: desc);

    return BlocConsumer<DbCubit, DbState>(
      listener: (context, state) {
        if (state is UpdateDbDoneState) {
          Navigator.pop(context);
        } else if (state is UpdateDbDoneState) {
          print("loading");
        } else {
          print("error in adding");
        }
      },
      builder: (context, state) {
        DbCubit cubit = DbCubit.get(context);
        return Scaffold(
          appBar: AppBar(title: const Text("Update note"), centerTitle: true),
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
                        childWidget: const Text("Update"),
                        function: () {
                          if (title.text.isNotEmpty &&
                              description.text.isNotEmpty) {
                            cubit.update(id, title.text, description.text);
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
