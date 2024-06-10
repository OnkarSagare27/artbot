import 'package:artbot/screens/home_screen/providers/home_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  bool _isLoading = true;
  List<String> history = [];

  @override
  void initState() {
    loadHistory();
    super.initState();
  }

  void loadHistory() async {
    SharedPreferences preffs = await SharedPreferences.getInstance();
    history = preffs.getStringList('history') ?? [];
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void removeFromHistory(int index) async {
    if (mounted) {
      setState(() {
        _isLoading = true;
      });
    }
    history.removeAt(index);
    SharedPreferences preffs = await SharedPreferences.getInstance();
    preffs.setStringList('history', history);
    loadHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<HomeScreenProvider>(
        builder: (context, homeScreenProvider, child) => Container(
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
              padding: const EdgeInsets.all(15),
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
                        'History',
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
                    child: _isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.blue,
                            ),
                          )
                        : history.isEmpty
                            ? const Center(
                                child: Text(
                                  'Nothing to see here',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            : ListView.builder(
                                itemCount: history.length,
                                itemBuilder: (context, index) => Container(
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey, width: 0.5))),
                                  child: ListTile(
                                    trailing: InkWell(
                                      onTap: () {
                                        removeFromHistory(index);
                                      },
                                      child: const Icon(
                                        Icons.clear,
                                        color: Colors.white,
                                      ),
                                    ),
                                    onTap: () {
                                      homeScreenProvider.promtEditingController
                                          .text = history[index];
                                      Navigator.pop(context);
                                    },
                                    title: Text(
                                      history[index],
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
