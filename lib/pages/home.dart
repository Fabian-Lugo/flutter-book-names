import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:book_name/models/book.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Book> books = [
    Book(id: "1", name: "Andromeda", votes: 5),
    Book(id: "2", name: "Rick & Morty", votes: 9),
    Book(id: "3", name: "La casa verde", votes: 3),
    Book(id: "4", name: "Paco Yunque", votes: 15),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'BookNames',
          style: GoogleFonts.poppins(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, i) => bookTile(books[i]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addNewBook,
        elevation: 1,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget bookTile(Book book) {
    final name = book.name ?? 'Sin nombre';

    return Dismissible(
      key: Key(book.id!),
      direction: DismissDirection.startToEnd,
      onDismissed: (DismissDirection direction) {
        debugPrint('direction: $direction');
        debugPrint('id: ${book.id}');
        debugPrint('name: ${book.name}');
        debugPrint('votes: ${book.votes}'); 
        //Llamar el borrado
      },
      background: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(color: Colors.red),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [Icon(Icons.delete, color: Colors.white)],
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.deepPurpleAccent[300],
          child: Text(
            name.substring(0, 2),
            style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
          ),
        ),
        title: Text(
          name,
          style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
        ),
        trailing: Text(
          '${book.votes}',
          style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600),
        ),
        onTap: () => debugPrint(name),
      ),
    );
  }

  void addNewBook() {
    final textController = TextEditingController();

    if (Platform.isIOS) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('New book name', textAlign: TextAlign.center),
          content: TextField(controller: textController),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  textColor: Colors.blue,
                  child: const Text('Add'),
                  onPressed: () => addBookToList(textController.text),
                ),
                MaterialButton(
                  textColor: Colors.red,
                  child: const Text('Dismiss'),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ],
        ),
      );
    } else {
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
    }
  }

  void addBookToList(String name) {
    
    if (name.trim().length > 1) {
      books.add(Book(id: DateTime.now().toString(), name: name, votes: 0));
      setState(() {});
    }
    Navigator.pop(context);
  }
}
