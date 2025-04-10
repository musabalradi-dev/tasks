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

final class UpdateDataBaseState extends LayoutState {}

final class DeleteDataBaseState extends LayoutState {}

final class GetDataBaseState extends LayoutState {}

final class LayoutErrorState extends LayoutState {
  final String error;
  LayoutErrorState(this.error);
}
