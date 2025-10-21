import 'package:effective_mobile_russia_test/effective_mobile_russia_test_provider.dart';
import 'package:effective_mobile_russia_test/favorites/favorites_controller.dart';
import 'package:effective_mobile_russia_test/home/home_controller.dart';
import 'package:effective_mobile_russia_test/main%20/main_controller.dart';
import 'package:effective_mobile_russia_test/main%20/main_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainView extends StatefulWidget {
  final MainModel mainViewData;
  final MainController mainController;
  const MainView({
    super.key,
    required this.mainViewData,
    required this.mainController,
  });

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  void initState() {
    super.initState();

    widget.mainController.viewInit(widget, context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<EffectiveMobileRussiaTestProvider>(
        builder:
            (
              context,
              EffectiveMobileRussiaTestProvider
              effectiveMobileRussiaTestProvider,
              child,
            ) => Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text(
                  widget.mainViewData.tabCurrentIndex == 0
                      ? 'Home'
                      : 'Favorites',
                ),
                backgroundColor: Colors.grey,
              ),
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                onTap: (index) async {
                  final effectiveMobileRussiaTestProvider =
                      Provider.of<EffectiveMobileRussiaTestProvider>(
                        context,
                        listen: false,
                      );

                  widget.mainViewData.tabCurrentIndex = index;

                  await effectiveMobileRussiaTestProvider.refresh(
                    'Bottom Bar',
                    'Main View',
                  );
                },
                currentIndex:
                    effectiveMobileRussiaTestProvider.refreshUI == 'Bottom Bar'
                    ? widget.mainViewData.tabCurrentIndex
                    : widget.mainViewData.tabCurrentIndex,
                selectedItemColor: Colors.black,
                unselectedItemColor: Colors.white,
                backgroundColor: Colors.grey,
                items: [
                  BottomNavigationBarItem(
                    label: 'Home',
                    icon: Icon(Icons.home),
                  ),
                  BottomNavigationBarItem(
                    label: 'Favorites',
                    icon: Icon(Icons.star),
                  ),
                ],
              ),
              body: widget.mainViewData.tabCurrentIndex == 0
                  ? HomeController()
                  : FavoritesController(),
            ),
      ),
    );
  }
}
