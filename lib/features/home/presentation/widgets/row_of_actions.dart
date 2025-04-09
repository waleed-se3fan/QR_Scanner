import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_scanner/core/utils/app_colors.dart';
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
                icon: const Icon(Icons.photo, color: AppColors.darkGreyColor),
                onPressed: () {
                  context.read<QrcodeBloc>().add(GetQRFromGalleryEvent());
                }),
            SizedBox(width: 20.w),
            IconButton(
              icon: const Icon(Icons.grid_view, color: AppColors.darkGreyColor),
              onPressed: () {},
            ),
            SizedBox(width: 20.w),
            IconButton(
              icon: const Icon(Icons.flash_on, color: AppColors.darkGreyColor),
              onPressed: () =>
                  context.read<QrcodeBloc>().add(ToggleFlashEvent()),
            ),
          ],
        );
      },
    );
  }
}
