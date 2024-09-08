import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'visibility_speeds_state.dart';

class VisibilitySpeedsCubit extends Cubit<VisibilitySpeedsState> {
  VisibilitySpeedsCubit() : super(VisibilitySpeedsInitial());
}
