class CurrentUserDataModel {
  const CurrentUserDataModel({
    required this.uid,
    this.email,
    this.displayName,
  });

  final String uid;
  final String? email;
  final String? displayName;
}
