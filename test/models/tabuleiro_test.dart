import 'package:campoMinado/models/tabuleiro.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  test('Ganhar jogo', () {
    Tabuleiro tabuleiro = Tabuleiro(linha: 2, coluna: 2, qntdBombas: 0);
    tabuleiro.campos[0].minar();
    tabuleiro.campos[3].minar();

    tabuleiro.campos[0].alternarMarcacao();
    tabuleiro.campos[1].abrir();
    tabuleiro.campos[2].abrir();
    tabuleiro.campos[3].alternarMarcacao();

    expect(tabuleiro.resolvido, isTrue);
  });
}
