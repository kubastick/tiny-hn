part of 'home_page_cubit.dart';

@freezed
sealed class HomePageState with _$HomePageState {
  const factory HomePageState.loading() = HomePageStateLoading;

  const factory HomePageState.idle({
    required List<Story> stories,
  }) = HomePageStateIdle;
}
