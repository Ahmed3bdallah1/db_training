import 'package:flutter/material.dart';

class TodoTile extends StatelessWidget {
  const TodoTile(
      {super.key,
      this.color,
      this.title,
      this.description,
      this.start,
      this.end,
      this.editWidget,
      this.delete,
      this.switcher});

  final Color? color;
  final String? title;
  final String? description;
  final String? start;
  final String? end;
  final Widget? editWidget;
  final Widget? switcher;
  final void Function()? delete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(8),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.indigo.withOpacity(.2),
            borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: [
            Container(
              height: 90,
              width: 5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: color ?? Colors.red),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: SizedBox(
                  // width: Constants.kWidth*.50,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title ?? "todo name",
                          style: const TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 5),
                      Text(description ?? "todo description",
                          style: const TextStyle(
                              fontSize: 9,
                              color: Colors.white,
                              fontWeight: FontWeight.normal)),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Container(
                          //     width: Constants.kWidth * .3,
                          //     height: 25.h,
                          //     // color: Constants.kLight.withOpacity(.3),
                          //     decoration: BoxDecoration(
                          //       color: Colors.white,
                          //       borderRadius: BorderRadius.circular(12),
                          //       border: Border.all(width: .6),
                          //     ),
                          //     child: Center(
                          //         child: ReusableText(
                          //             text: '$start - $end',
                          //             textStyle: appStyle(
                          //                 12,
                          //                 Constants.kBlack,
                          //                 FontWeight.normal)))),
                          // const SizedBox(width: 20),
                          Row(
                            children: [
                              SizedBox(
                                child: editWidget,
                              ),
                              const SizedBox(width: 10),
                              GestureDetector(
                                onTap: delete,
                                child: const Icon(
                                  Icons.delete_outline,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 5),
              child: switcher,
            )
          ],
        ),
      ),
    );
  }
}
