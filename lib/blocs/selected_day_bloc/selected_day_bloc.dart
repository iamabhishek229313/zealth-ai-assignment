// import 'dart:developer';

// import 'package:flutter_bloc/flutter_bloc.dart';

// class SelectedDateEvent {}

// class ChangeSelectedDateEvent extends SelectedDateEvent {
//   final DateTime dateTime;
//   ChangeSelectedDateEvent(this.dateTime);
// }

// class SelectedDateBloc extends Bloc<SelectedDateEvent, DateTime> {
//   SelectedDateBloc()
//       : super(DateTime(
//           2000,
//         )) {
//     on<ChangeSelectedDateEvent>((event, emit) => emit(event.dateTime));
//   }

//   @override
//   void onTransition(Transition<SelectedDateEvent, DateTime> transition) {
//     super.onTransition(transition);
//     log(transition.toString());
//   }
// }

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zealth_ai_assign/constants/local_storage_constants.dart';

class SelectedDateState extends Equatable {
  final DateTime dateTime;

  SelectedDateState(this.dateTime) : assert(dateTime != null);

  @override
  List<Object> get props => [dateTime];
}

abstract class SelectedDateEvent extends Equatable {
  const SelectedDateEvent();

  @override
  List<Object> get props => [];
}

class SelectedDateChanged extends SelectedDateEvent {
  final DateTime dateTime;

  SelectedDateChanged(this.dateTime) : assert(dateTime != null);

  @override
  List<Object> get props => [dateTime];
}

class SelectedDateLoadStarted extends SelectedDateEvent {}

class SelectedDateBloc extends Bloc<SelectedDateEvent, SelectedDateState> {
  SelectedDateBloc(SelectedDateState initialState) : super(initialState);

  @override
  SelectedDateState get initialState => SelectedDateState(DateTime(2000));

  @override
  Stream<SelectedDateState> mapEventToState(SelectedDateEvent event) async* {
    if (event is SelectedDateLoadStarted) {
      yield* _mapSelectedDateLoadStartedToState();
    } else if (event is SelectedDateChanged) {
      yield* _mapSelectedDateChangedToState(event.dateTime);
    }
  }

  Stream<SelectedDateState> _mapSelectedDateLoadStartedToState() async* {
    final _prefs = await SharedPreferences.getInstance();
    final recentSelectedDate = _prefs.getString(LocalStorageConstants.recentSelectedDate);

    if (recentSelectedDate == null) {
      _prefs.setBool(LocalStorageConstants.darkMode, false);
      yield SelectedDateState(DateTime(2000));
    } else {
      yield SelectedDateState(DateTime.parse(recentSelectedDate));
    }
  }

  Stream<SelectedDateState> _mapSelectedDateChangedToState(DateTime dateTime) async* {
    final _prefs = await SharedPreferences.getInstance();
    _prefs.setString(LocalStorageConstants.recentSelectedDate, dateTime.toString());
    yield SelectedDateState(dateTime);
  }
}
