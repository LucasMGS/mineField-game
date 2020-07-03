import 'dart:math';

import 'package:campoMinado/models/campo.dart';
import 'package:flutter/foundation.dart';

import 'campo.dart';

class Tabuleiro {
  final int linha;
  final int coluna;
  final int qntdBombas;

  final List<Campo> _campos = [];

  Tabuleiro({
    @required this.linha,
    @required this.coluna,
    @required this.qntdBombas,
  }) {
    _criarCampos();
    _relacionarVizinhos();
    _sortearMinas();
  }

  void reiniciar() {
    _campos.forEach((campo) => campo.reiniciar());
    _sortearMinas();
  }

  void revelarBomba() {
    _campos.forEach((c) => c.revelarBomba());
  }

  void _criarCampos() {
    for (var l = 0; l < linha; l++) {
      for (var c = 0; c < coluna; c++) {
        _campos.add(Campo(linha: l, coluna: c));
      }
    }
  }

  void _relacionarVizinhos() {
    for (var campo in _campos) {
      for (var vizinho in _campos) {
        campo.adicionarVizinho(vizinho);
      }
    }
  }

  void _sortearMinas() {
    int sorteadas = 0;
    if (qntdBombas > _campos.length) {
      print('Quantidade de bombas maior que o tabuleiro!');
      return;
    }
    while (sorteadas < qntdBombas) {
      int i = Random().nextInt(_campos.length);
      if (!_campos[i].minado) {
        sorteadas++;
        _campos[i].minar();
      }
    }
  }

  List<Campo> get campos => _campos;

  bool get resolvido => _campos.every((element) => element.resolvido);
}
