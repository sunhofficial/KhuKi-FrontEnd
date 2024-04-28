enum NameTag {
  big(24.0, 216, 48),
  small(14.0, 118, 24);

  const NameTag(this.sizeofFont, this.tagWidth, this.tagHeight);

  final double sizeofFont;
  final double tagWidth;
  final double tagHeight;
}
