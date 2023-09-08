part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileUpdated extends ProfileState {
  final String profileUpdated;

  ProfileUpdated(this.profileUpdated);
}

final class ProfileLoaded extends ProfileState {
  final DataProfileRequest dataProfile;

  ProfileLoaded(this.dataProfile);
}

final class ProfileError extends ProfileState {
  final String profileError;

  ProfileError(this.profileError);
}
