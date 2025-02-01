class PricingView {
  final String title;
  final String capString;
  final String description;
  final String imageString;
  final DropdownOption dropdownOptions;
  String selectedDropdownValue;
  bool isDropDownSelected;
  final double pAmount;
  final double discountedAmount;
  final double discounte;

  PricingView(
      {required this.title,
      required this.capString,
      required this.description,
      required this.imageString,
      required this.dropdownOptions,
      required this.selectedDropdownValue,
      required this.pAmount,
      required this.discounte,
      required this.discountedAmount,
      this.isDropDownSelected = false});
}

class DropdownOption {
  final List<String> value;
  String label;

  DropdownOption({required this.value, required this.label});
}
