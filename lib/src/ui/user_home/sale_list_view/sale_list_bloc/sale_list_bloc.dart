import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:my_lottery/src/api/api_loader.dart';
import './bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

class SaleListBloc extends Bloc<SaleListEvent, SaleListState> {
  final ApiLoader apiLoader;

  SaleListBloc({@required this.apiLoader}) : assert(apiLoader != null);

  @override
  SaleListState get initialState => SaleListStateEmpty();

//  @override
//  Stream<SaleListState> transformEvents(Stream<SaleListEvent> events,
//      Stream<SaleListState> Function(SaleListEvent event) next) {
//    return (events as Observable<SaleListEvent>)
//        .debounceTime(
//          Duration(milliseconds: 300),
//        )
//        .switchMap(next);
//
////    return super.transformEvents( events, next );
//  }

  @override
  Stream<SaleListState> mapEventToState(
    SaleListEvent event,
  ) async* {
    if (event is SaleListRefresh) {
      yield* _mapEventIsRefresh();
    }
    if(event is SaleDataDeleteEvent){
      yield* _mapEventIsDeleted(event.id);
    }
  }

  Stream<SaleListState> _mapEventIsRefresh() async* {
    yield SaleListStateLoading();
    try {
      final items = await apiLoader.getSaleData();


//      print('SaleListBloc: item : $items//phone :${items[0].phone}');
      yield SaleListStateSuccess(items: items.isNotEmpty ? items : []);
    } catch (e) {
      yield SaleListStateError(e.toString());
    }
  }

  Stream<SaleListState>_mapEventIsDeleted(int id) async*{
    yield SaleListStateLoading();
    try{
      Future.delayed(Duration(milliseconds: 300));
      yield SaleListDeleteSuccess(success: await apiLoader.deleteSale(id));


    }catch(e){
      Exception(e);
    }
  }
}
