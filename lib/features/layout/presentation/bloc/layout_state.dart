sealed class LayoutState {}

final class LayoutInitialState extends LayoutState {}

final class BottomNavigationBarState extends LayoutState {}

final class CreateDatabaseSuccessState extends LayoutState {}

final class CreateDatabaseErrorState extends LayoutState {
  final String error;
  CreateDatabaseErrorState({required this.error});
}

final class InsertDatabaseSuccessState extends LayoutState {}

final class InsertDatabaseErrorState extends LayoutState {
  final String error;
  InsertDatabaseErrorState({required this.error});
}

final class GetDatabaseSuccessState extends LayoutState {}
final class GetDatabaseErrorState extends LayoutState {
  final String error;
  GetDatabaseErrorState({required this.error});
}

final class UpdateDatabaseSuccessState extends LayoutState {}
final class UpdateDatabaseErrorState extends LayoutState {
  final String error;
  UpdateDatabaseErrorState({required this.error});
}

final class DeleteDatabaseSuccessState extends LayoutState {}
final class DeleteDatabaseErrorState extends LayoutState {
  final String error;
  DeleteDatabaseErrorState({required this.error});
}

final class ChangeBottomSheetState extends LayoutState {
  final bool isShow;
  ChangeBottomSheetState({required this.isShow});
}
