class Transaction {
  final String id;
  final double value;
  final String categoria;
  final String carteira;
  final DateTime date;
  final String nota;
  final String descricao;

  const Transaction({
    required this.id,
    required this.value,
    required this.categoria,
    required this.carteira,
    required this.date,
    required this.descricao,
    required this.nota,
  });
}
