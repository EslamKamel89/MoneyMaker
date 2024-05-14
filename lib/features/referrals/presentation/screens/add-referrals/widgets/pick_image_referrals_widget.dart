import 'package:flutter/material.dart';
import 'package:trading/core/themes/clr.dart';

class PickImageReferralsWidget extends StatelessWidget {
  const PickImageReferralsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130,
      height: 130,
      child: CircleAvatar(
        backgroundColor: Colors.grey.shade200,
        backgroundImage: const AssetImage("assets/images/avatar.png"),
        child: Stack(
          children: [
            Positioned(
              bottom: 5,
              right: 5,
              child: GestureDetector(
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Clr.d,
                    border: Border.all(color: Theme.of(context).dividerColor, width: 3),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Icon(
                    Icons.camera_alt_sharp,
                    color: Clr.c,
                    size: 25,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
