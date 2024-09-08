import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'visibility_thumbnail_state.dart';

class VisibilityThumbnailCubit extends Cubit<VisibilityThumbnailState> {
  VisibilityThumbnailCubit() : super(VisibilityThumbnailInitial());

  void setVisibilityThumbnail({required bool isVisible}) {
    emit(VisibilityThumbnail(isVisible: isVisible));
  }

}
