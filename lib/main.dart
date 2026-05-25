import 'package:flutter/material.dart';
import 'dart:async';

import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:pdfx/pdfx.dart';
import 'package:share_plus/share_plus.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StreamSubscription _intentSub;
  String? _pdfPath;
  PdfController? _pdfController;

  @override
  void initState() {
    super.initState();
    _intentSub = ReceiveSharingIntent.instance.getMediaStream().listen((files) {
      if (files.isNotEmpty) {
        setState(() {
          _pdfPath = files.first.path;
          _pdfController?.dispose();
          _pdfController = PdfController(
            document: PdfDocument.openFile(_pdfPath!),
          );
        });
      }
    }, onError: (err) {});
    ReceiveSharingIntent.instance.getInitialMedia().then((files) {
      if (files.isNotEmpty) {
        setState(() {
          _pdfPath = files.first.path;
          _pdfController?.dispose();
          _pdfController = PdfController(
            document: PdfDocument.openFile(_pdfPath!),
          );
        });
      }
      ReceiveSharingIntent.instance.reset();
    });
  }

  @override
  void dispose() {
    _intentSub.cancel();
    _pdfController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: const Color(0xFF22223B),
        scaffoldBackgroundColor: const Color(0xFF2A2A40),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF22223B),
          foregroundColor: Colors.white,
          elevation: 2,
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white70, fontSize: 18),
        ),
        iconTheme: const IconThemeData(color: Colors.white70),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Visualizador PDF'),
          actions: [
            if (_pdfPath != null)
              IconButton(
                icon: const Icon(Icons.share),
                tooltip: 'Compartilhar',
                onPressed: () async {
                  await SharePlus.instance.share(
                    ShareParams(
                      text: 'Compartilhando PDF',
                      files: [XFile(_pdfPath!)],
                    ),
                  );
                },
              ),
          ],
        ),
        drawer: Drawer(
          backgroundColor: const Color(0xFF22223B),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
                DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Color(0xFF2A2A40),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        'freepdfreader',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'v1.0.0',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.5),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.info_outline, color: Colors.white70),
                  title: const Text(
                    'SOBRE',
                    style: TextStyle(color: Colors.white70),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    showAboutDialog(
                      context: context,
                      applicationName: 'freepdfreader',
                      applicationVersion: '1.0.0',
                      applicationIcon: const Icon(
                        Icons.picture_as_pdf,
                        color: Colors.amberAccent,
                        size: 40,
                      ),
                      children: [
                        const Text(
                          'Um visualizador de PDF simples, leve e moderno desenvolvido em Flutter.\n\n'
                          'Este aplicativo é GRATUITO para uso pessoal e educacional.',
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Contato para suporte ou licenciamento comercial:',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const SelectableText(
                          'rtyker@gmail.com',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
        ),
        body: _pdfPath == null
            ? Center(
                child: Text(
                  'Nenhum PDF recebido',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              )
            : Column(
                children: [
                  Container(
                    width: double.infinity,
                    color: const Color(0xFF22223B),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 16,
                    ),
                    child: Text(
                      _pdfPath != null ? _pdfPath!.split('/').last : '',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 14,
                        color: Colors.amberAccent,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: const Color(0xFF2A2A40),
                      child: PdfView(
                        controller: _pdfController!,
                        scrollDirection: Axis.vertical,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
