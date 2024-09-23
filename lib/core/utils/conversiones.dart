


 double hgtokg(int hectogramos) {
    return hectogramos / 10;
  }

  double dmtom(int decimetros) {
    return decimetros / 10;
  }

  extension CapitalizeExtension on String {
  String capitalize() {
    if (this.isEmpty) return this;
    return this[0].toUpperCase() + this.substring(1);
  }
}

extension CapitalizeFirstLetter on String {
  String capitalizeFirstLetter() {
    if (this.isEmpty) return this;
    return this[0].toUpperCase() + this.substring(1).toLowerCase();
  }
}
