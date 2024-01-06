import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Titles extends StatelessWidget {
  const Titles(
      {super.key, required this.text, required this.text2, this.color});

  final String text;
  final String text2;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Consumer(
                builder: (context, ref, child) {
                  return Container(
                    height: 90,
                    width: 3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        //dynamic color later
                        color: color),
                  );
                },
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    text2,
                    style: const TextStyle(fontSize: 10),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
