import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:my_lottery/src/model/search_result_list.dart';

import './bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:my_lottery/src/api/api_loader.dart';
import 'package:meta/meta.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final ApiLoader apiLoader;

  SearchBloc({@required this.apiLoader}):assert(apiLoader != null);

  @override
  SearchState get initialState => SearchStateEmpty();

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
      yield SearchStateLoading();
      try {
        await Future<void>.delayed(Duration(seconds: 2));
        final res = await apiLoader.search(event.text);
        print('SearchBloc:ApiLoader:Res ${res.oneLs.length}');
        yield SearchStateSuccess(items:res.oneLs);

      } catch (e) {
        yield SearchStateError(e.toString()) ;
      }
    }
  }


}
