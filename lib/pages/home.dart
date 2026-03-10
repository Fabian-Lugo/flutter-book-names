import 'package:flutter/foundation.dart' show kIsWeb, TargetPlatform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:book_name/models/book.dart';
import 'package:book_name/services/socket_service.dart';
import 'package:provider/provider.dart';
import 'package:pie_chart/pie_chart.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  List<Book> books = [];  

  @override
  void initState() {
    super.initState();
    final socketService = Provider.of<SocketService>(context, listen: false);
    socketService.socket.on('active-books', _handleActiveBooks);
  }

  void _handleActiveBooks(dynamic data) {
    if (data is! List) return;
    final list = data
        .map((e) => e is Map ? Book.fromMap(Map<String, dynamic>.from(e)) : null)
        .whereType<Book>()
        .toList();
    if (mounted) setState(() => books = list);
  }

  @override
  void dispose() {
    super.dispose();

    final socketService = Provider.of<SocketService>(context, listen: false);
    socketService.socket.off('active-books');
  }

  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 20),
            child: (socketService.serverStatus == ServerStatus.online)
                ? const Icon(Icons.check, color: Colors.lightGreen, size: 35)
                : const Icon(Icons.block, color: Colors.red, size: 35)
          ),
        ],
        title: Text('BookNames',
          style: GoogleFonts.poppins(color: Colors.black87, fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          _showGraph(),

          Expanded(
            child: ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, i) => bookTile(books[i]),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addNewBook,
        elevation: 1,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget bookTile(Book book) {

    final socketService = Provider.of<SocketService>(context, listen: false);

    return Dismissible(
      key: Key(book.id!),
      direction: DismissDirection.startToEnd,
      onDismissed: (_) {
        socketService.socket.emit('delete-book', {'id': book.id});
        setState(() => books.removeWhere((b) => b.id == book.id));
      },
      background: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: const BoxDecoration(color: Colors.red),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [Icon(Icons.delete, color: Colors.white)],
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.deepPurpleAccent[300],
          child: Text(book.name!.substring(0, 2),
            style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
          ),
        ),
        title: Text(book.name!,
          style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
        ),
        trailing: Text('${book.votes}',
          style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600),
        ),
        onTap: () => socketService.socket.emit('vote-book', {'id': book.id}),
      ),
    );
  }

  void addNewBook() {
    final textController = TextEditingController();
    final isIOS = !kIsWeb && Theme.of(context).platform == TargetPlatform.iOS;

    if (isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
          title: const Text('New book name'),
          content: CupertinoTextField(controller: textController),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: const Text('add'),
              onPressed: () => addBookToList(textController.text),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              child: const Text('dismiss'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('New book name', textAlign: TextAlign.center),
          content: TextField(controller: textController),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  style: TextButton.styleFrom(foregroundColor: Colors.blue),
                  onPressed: () => addBookToList(textController.text),
                  child: const Text('Add'),
                ),
                TextButton(
                  style: TextButton.styleFrom(foregroundColor: Colors.red),
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Dismiss'),
                ),
              ],
            ),
          ],
        ),
      );
    }
  }

  void addBookToList(String name) {
    final socketService = Provider.of<SocketService>(context, listen: false);
    if (name.trim().length > 1) {
      socketService.socket.emit('add-book', {'name': name});
      Navigator.pop(context);
    }
  }

  Widget _showGraph() {
    final dataMap = <String, double>{};
    for (final book in books) {
      dataMap.putIfAbsent(book.name!, () => book.votes!.toDouble());
    }
    if (dataMap.isEmpty) return const SizedBox.shrink();
    return PieChart(
      dataMap: dataMap,
      chartValuesOptions: const ChartValuesOptions(
        showChartValues: true,
        showChartValuesInPercentage: true,
      ),
    );
  }
}
