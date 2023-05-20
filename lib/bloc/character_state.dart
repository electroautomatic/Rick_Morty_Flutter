part of 'character_bloc.dart';

//релизуем 3 состояния через Юнион класс

@freezed
class CharacterState with _$CharacterState {
  const factory CharacterState.loading() = CharacterStateLoading;
  const factory CharacterState.loaded({required Character characterLoaded}) =
      CharacterStateLoaded;
  const factory CharacterState.error() = Error;

  factory CharacterState.fromJson(Map<String, dynamic> json) => _$CharacterStateFromJson(json);
}
