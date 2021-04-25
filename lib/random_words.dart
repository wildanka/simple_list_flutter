import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';


class RandomWords extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return RandomWordsState();
  }
}

class RandomWordsState extends State<RandomWords>{
  final _randomWordPairs = <WordPair>[];
  final _savedWordPairs = Set<WordPair>();

  Widget _buildList(){
    return ListView.builder(
        padding: EdgeInsets.all(8.0),
        itemBuilder: (context, item){
          if(item.isOdd) return Divider();

          final index = item ~/ 2;

          if(index >= _randomWordPairs.length){
            _randomWordPairs.addAll(generateWordPairs().take(10));
          }

          return _buildRow(_randomWordPairs[index]);
        }
    );

  }

  Widget _buildRow(WordPair wordPair){
    final alreadySaved = _savedWordPairs.contains(wordPair);
    return ListTile(
      title: Text(wordPair.asPascalCase, style: TextStyle(fontSize: 18),),
      trailing: Icon(alreadySaved ? Icons.favorite : Icons.favorite_border, color: alreadySaved? Colors.pink : null),
      onTap: (){
        setState(() {
          if(alreadySaved){
            _savedWordPairs.remove(wordPair);
          }else{
            _savedWordPairs.add(wordPair);
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('WordPair Generator')),
        body: _buildList()
    );
  }
}