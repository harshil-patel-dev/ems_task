class QuickDateOption {
  final String text;
  final DateTime Function() getDate;
  final bool isSelected;

  QuickDateOption({
    required this.text,
    required this.getDate,
    this.isSelected = false,
  });
}