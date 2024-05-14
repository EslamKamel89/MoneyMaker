import 'package:flutter/material.dart';

class UploadPassportStatusRefferals extends StatelessWidget {
  const UploadPassportStatusRefferals({super.key});

  @override
  Widget build(BuildContext context) {
    // SignupCubit controller = context.read<SignupCubit>();
    return const SizedBox();
    // return BlocBuilder<SignupCubit, SignupState>(
    //   buildWhen: (previous, current) {
    //     return current is UpdateDoucumentImageState ? true : false;
    //   },
    //   builder: (context, state) {
    //     if (controller.isUploadPassport) {
    //       return SizedBox(
    //         child: controller.uploadIdDocumentFileOne != null
    //             ? const UploadDocumentSuccess()
    //             : const UploadDocumentFailure(),
    //       );
    //     } else {
    //       return SizedBox(
    //         child: controller.uploadIdDocumentFileOne != null && controller.uploadIdDocumentFileTwo != null
    //             ? const UploadDocumentSuccess()
    //             : const UploadDocumentFailure(),
    //       );
    //     }
    //   },
    // );
  }
}

class UploadDocumentFailureRefferals extends StatelessWidget {
  const UploadDocumentFailureRefferals({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
    // final controller = context.read<SignupCubit>();
    // return Row(
    //   mainAxisSize: MainAxisSize.min,
    //   mainAxisAlignment: MainAxisAlignment.start,
    //   children: [
    //     Icon(Icons.error, size: 30.w, color: Colors.red),
    //     SizedBox(width: 5.w),
    //     Txt.displayMeduim(
    //       controller.isUploadPassport ? "DIDNT_UPLOAD_DOCUMENT".tr(context) : "UPLOAD_TWO_PHOTO".tr(context),
    //       color: Colors.red,
    //     ),
    //   ],
    // );
  }
}

class UploadDocumentSuccessRefferals extends StatelessWidget {
  const UploadDocumentSuccessRefferals({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
    // return Row(
    //   mainAxisSize: MainAxisSize.min,
    //   mainAxisAlignment: MainAxisAlignment.start,
    //   children: [
    //     Icon(Icons.check, size: 30.w, color: Colors.green),
    //     SizedBox(width: 5.w),
    //     Txt.displayMeduim(
    //       'Documents Uploaded Successfuly',
    //       color: Colors.green,
    //     ),
    //   ],
    // );
  }
}
