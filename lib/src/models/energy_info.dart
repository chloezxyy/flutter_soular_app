
// to convert raw Future<http.Response into a Dart object
class EnergyInfo {
  final double energyBalance;
  final double creditBalance;
  final double energyOnSaleBalance;
  final double currentPrice;

  EnergyInfo(
      {this.energyBalance,
      this.creditBalance,
      this.energyOnSaleBalance,
      this.currentPrice});

  factory EnergyInfo.fromJson(Map<String, dynamic> json) {
    return EnergyInfo(
      energyBalance: json['energyBalance'] is int
          ? (json['energyBalance'] as int).toDouble()
          : json['energyBalance'],
      creditBalance: json['creditBalance'] is int
          ? (json['creditBalance'] as int).toDouble()
          : json['creditBalance'],
      energyOnSaleBalance: json['energyOnSale'] is int
          ? (json['energyOnSale'] as int).toDouble()
          : json['energyOnSale'],
      currentPrice: json['currentPrice'] is int
          ? (json['currentPrice'] as int).toDouble()
          : json['currentPrice'],
    );
  }
}