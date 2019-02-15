import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Hello from Flutter',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: new Scaffold(
        body: new Center(
          child: new RandWords(),
        ),
      )
    );
  }
}

class RandWordsState extends State<RandWords> { 
  @override 
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: AppBar(
        title: Text('Random Word Generator'),
        actions: <Widget>[ 
          new IconButton(icon: const Icon(Icons.list),onPressed: _pushSaved)],
                ),
                body: _buildSuggestions(),
              );
            }
          
  final List<WordPair> words = <WordPair>[];
  final Set<WordPair> saved = new Set<WordPair>();
  final TextStyle font = const TextStyle(fontSize: 18.0);
          
  void _pushSaved(){
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = saved.map(
            (WordPair word) {
              return new ListTile(
                title: new Text(
                  word.asPascalCase,
                  style: font,
                ),
              );
            }
          );

          final List<Widget> divided = ListTile.divideTiles(context: context,tiles: tiles).toList();
        
        return new Scaffold(
          appBar: new AppBar(
            title: const Text('Liked Words'),
          ),
        body:new ListView(children: divided)
        );
        }
      )
    );
  }        
  Widget _buildSuggestions(){
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (BuildContext _context, int i){
        if(i.isOdd)return new Divider();
        final int index = i~/2;
        if (index >= words.length){
          words.addAll(generateWordPairs().take(10));
        }
        return _buildRow(words[index]);
      }
                      
    );
  }
               
 Widget _buildRow(WordPair word) {
   final bool alreadySaved = saved.contains(word);
   return new ListTile(
     title: new Text(
       word.asPascalCase,
       style: font
     ),
     trailing: new Icon(
       alreadySaved? Icons.favorite:Icons.favorite_border,
       color: alreadySaved?Colors.red:null,
     ),
     onTap: (){
       setState(() {
                 if(alreadySaved) saved.remove(word);
                 else saved.add(word);               
               });
     },
    );
  }

}
          

class RandWords extends StatefulWidget {
  @override
  RandWordsState createState()=>new RandWordsState();
}


