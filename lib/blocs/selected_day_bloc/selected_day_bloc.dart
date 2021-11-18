import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class SelectedDateEvent {}

class ChangeSelectedDateEvent extends SelectedDateEvent {
  final DateTime dateTime;
  ChangeSelectedDateEvent(this.dateTime);
}

class SelectedDateBloc extends Bloc<SelectedDateEvent, DateTime> {
  SelectedDateBloc()
      : super(DateTime(
          2000,
        )) {
    on<ChangeSelectedDateEvent>((event, emit) => emit(event.dateTime));
  }

  @override
  void onTransition(Transition<SelectedDateEvent, DateTime> transition) {
    super.onTransition(transition);
    log(transition.toString());
  }
}
