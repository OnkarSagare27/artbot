import 'package:artbot/screens/home_screen/providers/home_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'widgets/gradient_outlined_button.dart';
import 'widgets/gradient_text_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<HomeScreenProvider>(
          builder: (context, homeScreenProvider, child) {
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                Color.fromARGB(255, 23, 113, 161),
                Color.fromARGB(255, 11, 33, 171),
              ],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/logo_artbot.png",
                        height: 25,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'ArtBot',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp,
                        ),
                      ),
                      const Spacer(),
                      IconButton.filled(
                        onPressed: () =>
                            Navigator.pushNamed(context, '/settings'),
                        style: IconButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(92, 158, 158, 158)),
                        icon: const Icon(
                          Icons.settings,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [
                          Color.fromARGB(255, 106, 194, 241),
                          Color.fromARGB(255, 90, 110, 241),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 36, 33, 33),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 45,
                                child: Row(
                                  children: [
                                    Text(
                                      'Enter Promt',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18.sp,
                                      ),
                                    ),
                                    const Spacer(),
                                    if (homeScreenProvider
                                        .promtEditingController.text.isNotEmpty)
                                      IconButton(
                                        padding: const EdgeInsets.all(0),
                                        onPressed: () {
                                          homeScreenProvider
                                              .promtEditingController
                                              .clear();
                                          setState(() {});
                                        },
                                        icon: const Icon(Icons.cancel),
                                      )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Center(
                                child: TextField(
                                  cursorColor:
                                      const Color.fromARGB(255, 106, 194, 241),
                                  controller:
                                      homeScreenProvider.promtEditingController,
                                  onChanged: (value) => setState(() {}),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15.sp),
                                  maxLines: 3,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 10),
                                    hintText:
                                        'Type here a detailed description of what kinda tattoo you\'re looking for',
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.sp,
                                    ),
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                      ),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                      ),
                                    ),
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    height: 35,
                                    child: GradientOutlinedButton(
                                        onPressed: () {},
                                        text: "History",
                                        gradientColors: const [
                                          Color.fromARGB(255, 90, 186, 241),
                                          Color.fromARGB(255, 87, 76, 216),
                                        ]),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
      floatingActionButton: GradientTextButton(
        onPressed: () {
          debugPrint('Button Pressed');
        },
        text: 'GENERATE',
        gradientColors: const [
          Color.fromARGB(255, 32, 51, 218),
          Color.fromARGB(255, 10, 28, 191),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
