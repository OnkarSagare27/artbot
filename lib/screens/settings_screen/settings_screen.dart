import 'dart:ui';

import 'package:artbot/screens/home_screen/providers/home_screen_provider.dart';
import 'package:artbot/screens/settings_screen/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer2<SettingsProvider, HomeScreenProvider>(
        builder: (context, settingsProvider, homeProvider, child) => Container(
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
              child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton.filled(
                      onPressed: () => Navigator.pop(context),
                      style: IconButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(92, 158, 158, 158)),
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                      ),
                    ),
                    Text(
                      'Settings',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp,
                      ),
                    ),
                    AbsorbPointer(
                      absorbing: true,
                      child: IconButton.filled(
                        onPressed: () {},
                        style: IconButton.styleFrom(
                            backgroundColor: Colors.transparent),
                        icon: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView(
                    children: [
                      ListTile(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return DialogWithBlur(
                                apiKeyEditingController:
                                    homeProvider.apiKeyEditingController,
                                onSaved: () {
                                  homeProvider.saveApiKey(homeProvider
                                      .apiKeyEditingController.text);
                                },
                              );
                            },
                          );
                        },
                        title: const Text(
                          'API Key',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.white,
                        ),
                        subtitle: Text(
                          homeProvider.apiKey!,
                          style: const TextStyle(color: Colors.grey),
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                      )
                    ],
                  ),
                )
              ],
            ),
          )),
        ),
      ),
    );
  }
}

class DialogWithBlur extends StatelessWidget {
  final TextEditingController apiKeyEditingController;
  final void Function() onSaved;
  const DialogWithBlur(
      {super.key,
      required this.apiKeyEditingController,
      required this.onSaved});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
          child: Container(
            color: Colors.black.withOpacity(0.5),
          ),
        ),
        AlertDialog(
          title: SizedBox(
            width: 500,
            child: TextField(
              controller: apiKeyEditingController,
              style: const TextStyle(fontWeight: FontWeight.w500),
              cursorColor: Colors.blue,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    borderSide: BorderSide(color: Colors.blue)),
                hintText: 'Enter API key',
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    borderSide: BorderSide(color: Colors.blue)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    borderSide: BorderSide(color: Colors.blue)),
              ),
            ),
          ),
          backgroundColor: Colors.white,
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              onPressed: () {
                onSaved();
                Navigator.pop(context);
              },
              child: const Text('Save',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ],
    );
  }
}
