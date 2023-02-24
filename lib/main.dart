import 'package:flutter/material.dart';

void main() => runApp(const TestApp());

class TestApp extends StatelessWidget {
  const TestApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _pages = const [Page1(), Page2(), Page3()];
  final _navigatorKeyList = List.generate(3, (index) => GlobalKey<NavigatorState>());
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return !(await _navigatorKeyList[_currentIndex].currentState!.maybePop());
      },
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          body: TabBarView(
            physics: const BouncingScrollPhysics(),
            children: _pages.map(
              (page) {
                int index = _pages.indexOf(page);
                return CustomNavigator(
                  page: page,
                  navigatorKey: _navigatorKeyList[index],
                );
              },
            ).toList(),
          ),
          bottomNavigationBar: TabBar(
            padding: const EdgeInsets.only(
              bottom: 10,
            ),
            isScrollable: false,
            indicatorPadding: const EdgeInsets.only(bottom: 74),
            indicatorWeight: 2.5,
            indicatorColor: const Color.fromARGB(255, 0, 199, 213),
            indicatorSize: TabBarIndicatorSize.tab,
            automaticIndicatorColorAdjustment: true,
            onTap: (index) => setState(() {
              _currentIndex = index;
            }),
            tabs: [
              Tab(
                icon: Icon(
                  Icons.home,
                  color: Theme.of(context).primaryColor,
                ),
                // text: '플라토',
                child: Text(
                  'Home',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.calendar_today,
                  color: Theme.of(context).primaryColor,
                ),
                // text: '캘린더',
                child: Text(
                  'Home',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.email,
                  color: Theme.of(context).primaryColor,
                ),
                // text: '쪽지',
                child: Text(
                  'Home',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Page1 extends StatelessWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page 1'),
        centerTitle: true,
      ),
      body: Center(
        child: FutureBuilder(
          future: Future.delayed(const Duration(seconds: 2)),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return TextButton(
                child: const Text('Next page'),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const Page4()));
                },
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page 2'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Page 2'),
      ),
    );
  }
}

class Page3 extends StatelessWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page 3'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Page 3'),
      ),
    );
  }
}

class Page4 extends StatelessWidget {
  const Page4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page4'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: Future.delayed(const Duration(milliseconds: 500)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: ListView.separated(
                itemCount: 20,
                separatorBuilder: (context, index) {
                  return const Divider(
                    height: 2,
                    color: Colors.grey,
                  );
                },
                itemBuilder: (_, index) {
                  return ListTile(
                    title: CircleAvatar(
                      backgroundColor: Colors.amber.shade200,
                      radius: 30,
                      child: Text(
                        '${index + 1}',
                        style: const TextStyle(fontSize: 30, fontWeight: FontWeight.normal),
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class CustomNavigator extends StatefulWidget {
  final Widget page;
  final Key navigatorKey;
  const CustomNavigator({Key? key, required this.page, required this.navigatorKey}) : super(key: key);

  @override
  CustomNavigatorState createState() => CustomNavigatorState();
}

class CustomNavigatorState extends State<CustomNavigator> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Navigator(
      key: widget.navigatorKey,
      onGenerateRoute: (_) => MaterialPageRoute(builder: (context) => widget.page),
    );
  }
}
