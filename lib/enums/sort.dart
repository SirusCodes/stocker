enum Sort {
  ascAlpha,
  dscAlpha,
}

extension XSort on Sort {
  String getString() => this == Sort.ascAlpha ? "ASC" : "DESC";
}
