import 'dart:async';
import 'package:bloc/bloc.dart';

import './bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:my_lottery/src/api/api_loader.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  ApiLoader _apiLoader;

  @override
  SearchState get initialState => SearchState.empty();

  @override
  Stream<SearchState> transformEvents(
    Stream<SearchEvent> events,
    Stream<SearchState> Function(SearchEvent event) next,
  ) {
    final observableStream = events as Observable<SearchEvent>;
    final nonDebounceStream = observableStream.where((event) {
      return (event is! TextChanged);
    });
    final debounceStream = observableStream.where((event) {
      return (event is TextChanged);
    }).debounceTime(Duration(milliseconds: 300));
    return super
        .transformEvents(nonDebounceStream.mergeWith([debounceStream]), next);
  }

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is TextChanged) {
      yield* _mapTextChanged(event.text);
    }
  }

  Stream<SearchState> _mapTextChanged(String text) async* {
    yield SearchState.loading();
    try {
      final res = await _apiLoader.search(text);
      if (res.items.length != null) {
        yield SearchState.success();
      } else if (res.items.length == null) {
        yield SearchState.notWinner();
      } else {
        yield SearchState.error();
      }
    } catch (e) {
      yield SearchState.error();
    }
  }
}
