import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_scanner/features/home/presentation/bloc/qrcode_bloc.dart';

class CustomActionsRow extends StatelessWidget {
  const CustomActionsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QrcodeBloc, QrcodeState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                icon: const Icon(Icons.photo, color: Colors.grey),
                onPressed: () {
                  context.read<QrcodeBloc>().add(GetQRFromGalleryEvent());
                }),
            const SizedBox(width: 20),
            IconButton(
              icon: const Icon(Icons.grid_view, color: Colors.grey),
              onPressed: () {},
            ),
            const SizedBox(width: 20),
            IconButton(
              icon: const Icon(Icons.flash_on, color: Colors.grey),
              onPressed: () =>
                  context.read<QrcodeBloc>().add(ToggleFlashEvent()),
            ),
          ],
        );
      },
    );
  }
}
