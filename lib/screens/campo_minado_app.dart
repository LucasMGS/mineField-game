import 'package:campoMinado/components/campo_widget.dart';
import 'package:campoMinado/components/resultado_widget.dart';
import 'package:campoMinado/components/tabuleiro_widget.dart';
import 'package:campoMinado/exceptions/explosao_exception.dart';
import 'package:campoMinado/models/campo.dart';
import 'package:campoMinado/models/tabuleiro.dart';
import 'package:flutter/material.dart';

class CampoMinadoApp extends StatefulWidget {
  @override
  _CampoMinadoAppState createState() => _CampoMinadoAppState();
}

class _CampoMinadoAppState extends State<CampoMinadoApp> {
  bool _venceu;
  Tabuleiro _tabuleiro;

  Tabuleiro _getTabuleiro(double altura, double largura) {
    if (_tabuleiro == null) {
      int qntdColunas = 15;
      double tamanhoCampo = largura / qntdColunas;
      int qntdLinhas = (altura / tamanhoCampo).floor();

      _tabuleiro = Tabuleiro(
        linha: qntdLinhas,
        coluna: qntdColunas,
        qntdBombas: 3,
      );
    }
    return _tabuleiro;
  }

  void _abrir(Campo campo) {
    if (_venceu != null) {
      return;
    }
    setState(() {
      try {
        campo.abrir();
        if (_tabuleiro.resolvido) {
          _venceu = true;
        }
      } on ExplosaoException {
        _venceu = false;
        _tabuleiro.revelarBomba();
      }
    });
  }

  void _alternarMarcacao(Campo campo) {
    setState(() {
      campo.alternarMarcacao();
      if (_tabuleiro.resolvido) {
        _venceu = true;
      }
    });
  }

  void _reiniciar() {
    setState(() {
      _venceu = null;
      _tabuleiro.reiniciar();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: ResultadoWidget(
          venceu: _venceu,
          onReiniciar: _reiniciar,
        ),
        body: Container(
          color: Colors.grey,
          child: LayoutBuilder(
            builder: (ctx, constraints) {
              return TabuleiroWidget(
                tabuleiro:
                    _getTabuleiro(constraints.maxHeight, constraints.maxWidth),
                onAbrir: _abrir,
                onAlterarMarcacao: _alternarMarcacao,
              );
            },
          ),
        ),
      ),
    );
  }
}
