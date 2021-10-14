class Veiculo {
  late final String placa;
  late final String descricao;

  // Contact(
  //     this.placa,
  //     this.descricao,
  //     );

  @override
  String toString() {
    return 'Contact{name: $placa, accountNumber: $descricao}';
  }
}