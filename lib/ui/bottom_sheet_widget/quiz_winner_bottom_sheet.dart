import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';
import 'package:satorio/ui/widget/bordered_button.dart';

class QuizWinnerBottomSheet extends StatelessWidget {
  final String prize;
  final String bonus;
  final VoidCallback? onPressed;

  final ConfettiController _confettiController = ConfettiController(
    duration: const Duration(seconds: 2),
  );

  QuizWinnerBottomSheet(
    this.prize,
    this.bonus, {
    this.onPressed,
  }) {
    Future.delayed(Duration(milliseconds: 250), () {
      _confettiController.play();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'txt_your_total_reward'.tr,
                style: textTheme.headline3!.copyWith(
                  color: SatorioColor.darkAccent,
                  fontSize: 20 * coefficient,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 4 * coefficient,
              ),
              Text(
                prize,
                style: textTheme.headline1!.copyWith(
                  color: SatorioColor.darkAccent,
                  fontSize: 34 * coefficient,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: bonus.isEmpty ? 0 : 24 * coefficient,
              ),
              bonus.isEmpty
                  ? SizedBox(
                      height: 0,
                    )
                  : Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      padding: EdgeInsets.all(16 * coefficient),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: SatorioColor.lavender2,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '🔥',
                            style: textTheme.headline1!.copyWith(
                              color: SatorioColor.textBlack,
                              fontSize: 34 * coefficient,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            'txt_includes_bonus'.tr,
                            style: textTheme.headline1!.copyWith(
                              color: SatorioColor.interactive,
                              fontSize: 18 * coefficient,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            bonus,
                            style: textTheme.headline1!.copyWith(
                              color: SatorioColor.interactive,
                              fontSize: 18 * coefficient,
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        ],
                      ),
                    ),
              SizedBox(
                height: 20 * coefficient,
              ),
              BorderedButton(
                text: 'txt_back'.tr,
                textColor: SatorioColor.darkAccent,
                borderColor: SatorioColor.smalt.withOpacity(0.24),
                onPressed: () {
                  Get.back();
                  onPressed?.call();
                },
              ),
              SizedBox(
                height: 32 * coefficient,
              ),
            ],
          ),
        ),
        Positioned(
          left: Get.width / 2,
          top: 0,
          child: Container(
            child: ConfettiWidget(
              confettiController: _confettiController,
              numberOfParticles: 15,
              blastDirectionality: BlastDirectionality.explosive,
              // blastDirectionality: BlastDirectionality.directional,
              // blastDirection: -pi / 2,
              // maxBlastForce: 35,
              // minBlastForce: 25,
              shouldLoop: false,
              colors: const [
                Colors.green,
                Colors.blue,
                Colors.pink,
                Colors.orange,
                Colors.purple
              ],
              createParticlePath: _starPath,
            ),
          ),
        ),
      ],
    );
  }

  Path _starPath(Size size) {
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }
}
