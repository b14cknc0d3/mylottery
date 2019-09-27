import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:my_lottery/src/api/api_loader.dart';
import './bloc.dart';
import 'package:meta/meta.dart';

class SaleListBloc extends Bloc<SaleListEvent, SaleListState> {
  final ApiLoader apiLoader;

  SaleListBloc({@required this.apiLoader})
      : assert(apiLoader != null);

  @override
  SaleListState get initialState => SaleListStateEmpty();

  @override
  Stream<SaleListState> mapEventToState(
    SaleListEvent event,
  ) async* {
    if(event is SaleListRefresh){
      yield*  _mapEventIsRefresh();
    }
  }

  Stream<SaleListState> _mapEventIsRefresh() async*{
    yield SaleListStateLoading();
    try{
      final items = await apiLoader.getSaleData();
      print('SaleListBloc: item : $items');
      yield SaleListStateSuccess(items: items);
    }catch (e){
      yield SaleListStateError(e.toString());
    }
  }
}
