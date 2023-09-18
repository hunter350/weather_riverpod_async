import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  //SearchPage._();

  // static Route<String> route() {
  //   return MaterialPageRoute(builder: (_) => const SearchPage._());
  // }

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final TextEditingController _textController = TextEditingController();

  String get _text => _textController.text;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final status = ref.watch(weatherNotifier.notifier).state.status;
    // final status = ref.watch(weatherNotifier).status;
    // print('search_page_status 1: ${status}');

    return Scaffold(
      appBar: AppBar(title: const Text('City Search')),
      body: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: TextField(
                controller: _textController,
                decoration: const InputDecoration(
                  labelText: 'City',
                  hintText: 'Chicago',
                ),
              ),
            ),
          ),
          IconButton(
              key: const Key('searchPage_search_iconButton'),
              icon: const Icon(Icons.search, semanticLabel: 'Submit'),
              onPressed: () async {
                final weatherNotifier1 = ref.read(weatherNotifier.notifier);
                //Основная проблема была в том, что возвращалось будущее
                // и нужно было обыграть с  async await. И затем сделать then
                //И после этого все заработало!!!
                if(_text.isNotEmpty){
                  sharedPref.setString('city', _text);
                }
                await weatherNotifier1.fetchWeather(_text).then((value) {
                  final theme1 = ref
                      .read(themeState.notifier)
                      .updateTheme(ref.read(weatherNotifier).weatherModels);

                  Navigator.of(context).pop();
                });
              })
        ],
      ),
    );
  }
}
