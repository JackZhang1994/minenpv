import 'package:flutter/material.dart';
import 'package:flutter_v2ray_desktop/flutter_v2ray_desktop.dart';

void main(List<String> args) {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter V2Ray',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final v2ray = FlutterV2rayDesktop(statusListner: (status) {
    debugPrint(status.toString());
  }, logListner: (log) {
    setState(() {
      if (logs.length >= maxLogLines) {
        logs.removeAt(0);
      }
      logs.add(log);
    });
  });

  final link = TextEditingController();

  static const maxLogLines = 20;
  final List<String> logs = [];
  ConnectionType connectionType = ConnectionType.systemProxy;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            TextFormField(
              controller: link,
              decoration: const InputDecoration(
                labelText: 'V2Ray Link',
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    final outbound = SingOutbound.fromUri(link.text);
                    v2ray.startV2Ray(
                      config: V2raySingParser.quick(outbound).json(),
                      connectionType: connectionType,
                    );
                  },
                  child: const Text('Start'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    v2ray.stopV2Ray();
                  },
                  child: const Text('Stop'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () async {
                    final delay = await v2ray.getServerDelay(url: link.text);
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('${delay}ms'),
                    ));
                  },
                  child: const Text('Get Delay'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (connectionType.index ==
                      ConnectionType.values.length - 1) {
                    connectionType = ConnectionType.values[0];
                  } else {
                    connectionType =
                        ConnectionType.values[connectionType.index + 1];
                  }
                });
              },
              child: Text(connectionType.name),
            ),
            const SizedBox(height: 10),
            Container(
              color: Colors.blueGrey[50],
              width: double.infinity,
              height: 300,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    logs.length,
                    (index) => SelectableText(
                      logs[index],
                    ),
                  ).reversed.toList(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
