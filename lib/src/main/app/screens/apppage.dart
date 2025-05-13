import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project/src/datamodels/receivemessages.dart';
import 'package:project/src/main/chat/screens/chatpage.dart';
import 'package:project/src/main/home/screens/homepage.dart';
import 'package:project/src/main/profile/screens/profilepage.dart';
import 'package:project/src/states/login.dart';
import 'package:project/src/main/wallet/screens/walletpage.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:project/src/states/socketprovider.dart';

class AppPage extends ConsumerStatefulWidget {
  const AppPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AppPageState();
}

class _AppPageState extends ConsumerState<AppPage> {
  @override
  Widget build(BuildContext context) {
    final channel;
    final AsyncValue<List<rmessages>> messages;
    if (kIsWeb) {
      messages = ref.watch(webmessagesProvider);
      channel = ref.watch(webwsChannelProvider);
    } else {
      messages = ref.watch(messagesProvider);
      channel = ref.watch(wsChannelProvider);
    }
    final _pageController = PageController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome Saravana"),
        centerTitle: true,
        actions: [
          ElevatedButton.icon(
              onPressed: () {
                ref.read(loginProvider.notifier).turnlogoff();
              },
              icon: const Icon(Icons.power_settings_new),
              label: const Text("Log out"))
        ],
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: <Widget>[HomePage(), ChatPage(), WalletPage(), ProfilePage()],
      ),
      // Pages[botindex],
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.white,
        backgroundColor: Colors.black,
        buttonBackgroundColor: Colors.white,
        items: const <Widget>[
          Icon(Icons.home, color: Colors.black),
          Icon(Icons.chat, color: Colors.black),
          Icon(Icons.wallet, color: Colors.black),
          Icon(Icons.person, color: Colors.black),
        ],
        onTap: (index) {
          _pageController.animateToPage(index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut);
        },
        /*onTap: (value) {
          setState(() {
            botindex = value;
          });
        },*/
      ),
    );
  }
}






/*
class AppPage1 extends ConsumerWidget {
  const AppPage1({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _pageController = PageController();
    List<Widget> Pages = const <Widget>[
      HomePage(),
      ChatPage(),
      WalletPage(),
      ProfilePage()
    ];
    int botindex = 1;
    final log = ref.watch(loginProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome Saravana"),
        centerTitle: true,
        actions: [
          ElevatedButton.icon(
              onPressed: () {
                print(log);
                ref.read(loginProvider.notifier).turnlogoff();
                Navigator.pushReplacementNamed(context, '/');
              },
              icon: const Icon(Icons.power_settings_new),
              label: const Text("Log out"))
        ],
      ),
      body: /*PageView(
        controller: _pageController,
        children: const <Widget>[
          HomePage(),
          ChatPage(),
          WalletPage(),
          ProfilePage()
        ],
      ),*/
          Pages[botindex],
      /*bottomNavigationBar: CurvedNavigationBar(
        items: const [
          CurvedNavigationBarItem(child: Icon(Icons.home), label: 'Home'),
          CurvedNavigationBarItem(child: Icon(Icons.chat), label: 'Chat'),
          CurvedNavigationBarItem(child: Icon(Icons.wallet), label: 'Wallet'),
          CurvedNavigationBarItem(child: Icon(Icons.person), label: 'Person'),
        ],*/
        /*onTap: (index) {
          _pageController.animateToPage(index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut);
        },*/
      ),
    );
  }
}
*/