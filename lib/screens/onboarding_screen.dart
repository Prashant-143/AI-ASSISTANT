import 'package:ai_assistant/helper/global.dart';
import 'package:ai_assistant/model/onboard.dart';
import 'package:ai_assistant/screens/home_screen.dart';
import 'package:ai_assistant/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();

    final list = [
      //Onboarding 1

      Onboard(
          title: 'Ask me Anything',
          subtitle:
              'I can be your Best Friend & You can ask me anything & I will help you!',
          lottie: 'ai_ask_me'),

      //Onboarding 2

      Onboard(
          title: 'Imagination to Reality',
          subtitle:
              'I can be your Best Friend & You can ask me anything & I will help you!',
          lottie: 'ai_play'),

      //Onboarding 3

      Onboard(
          title: 'AI Bg Remover',
          subtitle: 'Upload your image and i will remove the background of it!',
          lottie: 'Bgremover'),
    ];
    return Scaffold(
      body: PageView.builder(
        controller: pageController,
        itemCount: list.length,
        itemBuilder: (ctx, ind) {
          final isLast = ind == list.length - 1;
          final isSecond = ind == list.length - 2;

          return Column(
            children: [
              // Lottie
              Lottie.asset('assets/lottie/${list[ind].lottie}.json',
                  height: mq.height * .6,
                  width: isSecond
                      ? mq.width * 0.7
                      : (isLast ? mq.width * 1 : mq.width)),

              // Ttile
              Text(
                list[ind].title,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    letterSpacing: .5),
              ),

              // For adding some space...
              SizedBox(height: mq.height * .015),

              // Subtitle
              SizedBox(
                width: mq.width * .7,
                height: mq.height * 0.08,
                child: Text(
                  list[ind].subtitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 13, letterSpacing: .5),
                ),
              ),

              Wrap(
                spacing: 10,
                children: List.generate(
                  list.length,
                  (i) => Container(
                    width: i == ind ? 15 : 10,
                    height: 8,
                    decoration: BoxDecoration(
                        color: i == ind ? Colors.blue : Colors.grey,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5))),
                  ),
                ),
              ),

              const Spacer(),

              // Button
              CustomBtn(
                  onTap: () {
                    if (isLast) {
                      Get.off(() => const HomeScreen());
                    } else {
                      pageController.nextPage(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.ease);
                    }
                  },
                  text: isLast ? 'Finish' : 'Next'),

              const Spacer(),
            ],
          );
        },
      ),
    );
  }
}
