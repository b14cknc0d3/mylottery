import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:my_lottery/src/ui/login/login_bloc/login_event.dart';
import './bloc.dart';
import 'package:rxdart/rxdart.dart';
class BottomNavBarBloc extends Bloc<BottomNavBarEvent, BottomNavBarState> {
  @override
  BottomNavBarState get initialState => BnbIndexZeroState( );

  @override
  Stream<BottomNavBarState> transformEvents (Stream<BottomNavBarEvent> events,
      Stream<BottomNavBarState> Function(BottomNavBarEvent event) next,) {
    final observableStream = events as Observable<BottomNavBarEvent>;
    final nonDebounceStream = observableStream.where( (event) {
      return (event is! BnbIndexChangedEvent);
    } );
    final debounceStream = observableStream.where( (event) {
      return (event is BnbIndexChangedEvent);
    } ).debounceTime( Duration( milliseconds: 300 ) );
    return super
        .transformEvents(
        nonDebounceStream.mergeWith( [debounceStream] ), next );
  }

  @override
  Stream<BottomNavBarState> mapEventToState (BottomNavBarEvent event,) async* {
    if (event is BnbIndexChangedEvent) {
      yield BottomNavBarLoadingState();
      switch (event.index) {
        case 1:
         await Future.delayed(Duration(milliseconds: 300));
          yield BnbIndexOneState(index: 1);
          break;
        case 2:
        await  Future.delayed(Duration(milliseconds: 300));
          yield BnbIndexTwoState(index: 2);
          break;
        case 3:
         await Future.delayed(Duration(milliseconds: 300));
          yield BnbIndexThreeState(index: 3);
          break;
         default:
         await  Future.delayed(Duration(milliseconds: 300));
           yield BnbIndexZeroState();
      }
//    yield* _mapTopBnbState(event.index);
    }
  }

}
