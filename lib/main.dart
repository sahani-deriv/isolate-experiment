import 'package:example/person.dart';
import 'package:example/person_json.dart';
import 'package:example/propose_contract_json.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deriv_api/api/response/proposal_open_contract_response_result.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int withoutIsolate = 0;
  int withIsolate = 0;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    getLoadTimeWithoutIsolate() {
      final stopwatch = Stopwatch()..start();
      setState(() {
        isLoading = true;
      });

      for (var i = 0; i < 10; i++) {
        ProposalOpenContract.fromJson(proposeContractJson);
        print(i);
      }
      stopwatch.stop();
      setState(() {
        isLoading = false;
        withoutIsolate = stopwatch.elapsedMilliseconds;
      });
    }

    Future<void> getLoadTimeWithIsolate() async {
      final stopwatch = Stopwatch()..start();
      setState(() {
        isLoading = true;
      });
      for (var i = 0; i < 10; i++) {
        await ProposalOpenContract.parseJsoninIsolate(proposeContractJson);
        print(i);
      }
      stopwatch.stop();
      setState(() {
        isLoading = false;
        withIsolate = stopwatch.elapsedMilliseconds;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (isLoading) const CircularProgressIndicator(),
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    getLoadTimeWithoutIsolate();
                  },
                  child: const Text('Get Time To Load Without Isolate'),
                ),
                const SizedBox(width: 20),
                Text('$withoutIsolate ms'),
              ],
            ),
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    getLoadTimeWithIsolate();
                  },
                  child: const Text('Get Time To Load With Isolate'),
                ),
                const SizedBox(width: 20),
                Text('$withIsolate ms'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
