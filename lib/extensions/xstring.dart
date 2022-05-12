extension XString on String {
  String get avatarString {
    final chars = trim().split(" ").map((part) => part[0]).join().toUpperCase();
    return chars.length > 3 ? chars.substring(0, 3) : chars;
  }
}
