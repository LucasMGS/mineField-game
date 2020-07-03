import 'package:campoMinado/models/campo.dart';
import 'package:flutter/material.dart';

class CampoWidget extends StatelessWidget {
  final Campo campo;
  final void Function(Campo) onAbrir;
  final void Function(Campo) onAlterarMarcacao;

  const CampoWidget({
    @required this.campo,
    @required this.onAbrir,
    @required this.onAlterarMarcacao,
  });

  Widget _getImage() {
    int qntdMinas = campo.qntdMinasNaVizinhanca;
    if (campo.minado && campo.aberto && campo.explodido) {
      return Image.asset('assets/images/bomba_0.jpeg');
    } else if (campo.aberto && campo.minado) {
      return Image.asset('assets/images/bomba_1.jpeg');
    } else if (campo.aberto) {
      return Image.asset('assets/images/aberto_$qntdMinas.jpeg');
    } else if (campo.marcado) {
      return Image.asset('assets/images/bandeira.jpeg');
    } else {
      return Image.asset('assets/images/fechado.jpeg');
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onAbrir(campo),
      onLongPress: () => onAlterarMarcacao(campo),
      child: _getImage(),
    );
  }
}
