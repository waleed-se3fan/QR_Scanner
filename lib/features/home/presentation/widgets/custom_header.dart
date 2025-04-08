import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qr_scanner/features/home/presentation/views/result.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        Container(
          height: 8,
          width: 80,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.5),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        InkWell(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c) {
            return const ResultScreen();
          })),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Align(
                alignment: Alignment.topRight,
                child: SvgPicture.asset(
                  'images/menu.svg',
                  height: 43,
                  width: 41,
                )),
          ),
        ),
      ],
    );
  }
}
