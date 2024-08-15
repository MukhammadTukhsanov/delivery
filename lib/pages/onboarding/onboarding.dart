import 'package:flutter/material.dart';
import 'package:yolda/pages/onboarding/content_model.dart';
import 'package:yolda/widgets/button.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffffffff),
        body: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(contents.length, (index) => buildDot()),
          ),
          Expanded(
            child: Stack(alignment: Alignment.bottomCenter, children: [
              PageView.builder(
                  itemCount: contents.length,
                  itemBuilder: (_, i) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          contents[i].title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: "Josefin Sans",
                            color: Color(0xffd85e16),
                            fontWeight: FontWeight.w900,
                            fontSize: 36,
                          ),
                        ),
                        Image(
                          image: AssetImage(contents[i].image),
                        ),
                        // Button()
                      ],
                    );
                  }),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
                width: double.infinity,
                child: Button(
                  text: "Keyingi",
                  onPressed: () {},
                  icon: Icons.arrow_forward,
                ),
              ),
            ]),
          )
        ]));
  }

  Container buildDot() {
    return Container(
      width: 10,
      height: 10,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Color(0xffd85e16)),
    );
  }
}
