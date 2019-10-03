import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:my_lottery/src/api/api_loader.dart';
import 'package:my_lottery/src/model/saledata_item.dart';
import 'package:my_lottery/src/model/search_result_list.dart';
import './bloc.dart';
import 'package:rxdart/rxdart.dart';

class SaleListAddBloc extends Bloc<SaleListAddEvent, SaleListAddState> {
  ApiLoader apiLoader;

  SaleListAddBloc(this.apiLoader):assert(apiLoader != null);
  @override
  SaleListAddState get initialState => InitialSaleListAddState();

  @override
  Stream<SaleListAddState> transformEvents(Stream<SaleListAddEvent> events,
      Stream<SaleListAddState> Function(SaleListAddEvent event) next) {
    return (events as Observable<SaleListAddEvent>)
        .debounceTime(
          Duration(milliseconds: 300),
        )
        .switchMap(next);
  }

  @override
  Stream<SaleListAddState> mapEventToState(
    SaleListAddEvent event,
  ) async* {
    if (event is SaleListAddBottomPressed) {
      yield* _mapSaleListAddBottomPressed(event.items);
    }else if(event is SaleListPatchBottomPressed){
      yield* _mapSaleListPatchBottomPressed(event.items);
    }
  }


  Stream<SaleListAddState>  _mapSaleListAddBottomPressed(OneLs items) async*{
    yield SaleListAddStateLoading();
    try{
      Future.delayed(Duration(milliseconds: 300));
     final int a = await apiLoader.addSale(items);
     if(a == 200){
       yield SaleListAddSuccessState(a);

     }else{
       yield SaleListAddErrorState(a.toString());
     }


    }catch(e){
      yield SaleListAddErrorState(e.toString());
    }
  }

  Stream<SaleListAddState>  _mapSaleListPatchBottomPressed(OneLs items) async*{
    yield SaleListAddStateLoading();
    try{
      Future.delayed(Duration(milliseconds: 300));
      final int a = await apiLoader.doPatchSale(items);
      if(a == 200){
        yield SaleListPatchSuccessState(a);

      }else{
        yield SaleListAddErrorState(a.toString());
      }


    }catch(e){
      yield SaleListAddErrorState(e.toString());
    }
  }
}
