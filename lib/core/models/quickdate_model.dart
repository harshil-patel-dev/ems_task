class QuickDateOption {
  final String text;
  final DateTime Function() getDate;
  final bool isSelected;
  final bool isNoDate;

  QuickDateOption({
    required this.text,
    required this.getDate,
    this.isSelected = false,
    this.isNoDate = false,
  });
}
