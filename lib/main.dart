import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final String title = 'Copy & Paste - Clipboard';

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: title,
        theme: ThemeData(primarySwatch: Colors.deepOrange),
        home: MainPage(title: title),
      );
}

class MainPage extends StatefulWidget {
  final String title;

  const MainPage({
    @required this.title,
  });

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  TextEditingController controller = TextEditingController();
  String paste = '';

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildCopy(),
            const SizedBox(height: 16),
            buildPaste(),
          ],
        ),
      ));

  Widget buildCopy() => Builder(
        builder: (context) => Row(
          children: [
            Expanded(child: TextField(controller: controller)),
            IconButton(
              icon: Icon(Icons.content_copy),
              onPressed: () async {
                await FlutterClipboard.copy(controller.text);

                Scaffold.of(context).showSnackBar(
                  SnackBar(content: Text('✓   Copied to Clipboard')),
                );
              },
            ),
          ],
        ),
      );

  Widget buildPaste() => Row(
        children: [
          Expanded(child: Text(paste)),
          IconButton(
            icon: Icon(Icons.paste),
            onPressed: () async {
              final value = await FlutterClipboard.paste();

              setState(() {
                this.paste = value;
              });
            },
          )
        ],
      );
}
