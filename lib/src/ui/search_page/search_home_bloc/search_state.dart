
import 'package:meta/meta.dart';

@immutable
class SearchState {
  final bool isValidSearch;
  final bool isSubmitting;

  final bool isWinner;
  final bool isFailure;

  SearchState(
      {@required this.isValidSearch,
      @required this.isSubmitting,
      @required this.isWinner,
      @required this.isFailure});

  factory SearchState.empty() {
    return SearchState(
      isValidSearch: true,
      isSubmitting: false,
      isFailure: false,
      isWinner: false,
    );
  }
  factory SearchState.notWinner(){
    return SearchState(
      isValidSearch: true,
      isSubmitting: false,
      isFailure: false,
      isWinner: false
    );
  }
  factory SearchState.loading() {
    return SearchState(
      isValidSearch: true,
      isSubmitting: true,
      isFailure: false,
      isWinner: false,
    );
  }

  factory SearchState.success() {
    return SearchState(
      isValidSearch: true,
      isSubmitting: false,
      isWinner: true,
      isFailure: false,
    );
  }

  factory SearchState.error() {
    return SearchState(
      isValidSearch: true,
      isSubmitting: false,
      isWinner: false,
      isFailure: true,
    );
  }

  SearchState update({bool isValidSearch}) {
    return copyWith(
        isValidSearch: isValidSearch,
        isSubmitting: false,
        isWinner: false,
        isFailure: false);
  }

  SearchState copyWith({
    bool isValidSearch,
    bool isSubmitting,
    bool isWinner,
    bool isFailure,
  }) {
    return SearchState(
      isValidSearch: isValidSearch ?? this.isValidSearch,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isWinner: isWinner ?? this.isWinner,
      isFailure: isFailure ?? this.isFailure,
    );
  }
@override
  String toString()=> '''SearchState{
  
                  isValidSearch:$isValidSearch,
                  isSubmitting:$isSubmitting,
                  isWinner:$isWinner,
                  isFailure:$isFailure,
                                      }''';


}
