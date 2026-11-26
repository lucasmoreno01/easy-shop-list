class ListModel {
  final String id;
  final String name;
  final int qtdItens;
  final double totalPrice;

  ListModel({
    required this.id,
    required this.name,
    this.qtdItens = 0,
    this.totalPrice = 0,
  });

}
