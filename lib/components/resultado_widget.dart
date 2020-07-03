import 'package:flutter/material.dart';

class ResultadoWidget extends StatelessWidget implements PreferredSizeWidget {
  final bool venceu;
  final Function onReiniciar;

  ResultadoWidget({
    @required this.venceu,
    @required this.onReiniciar,
  });
  Color _getColor() {
    if (venceu == null) {
      return Colors.yellow;
    }
    return venceu == true ? Colors.green[300] : Colors.red[300];
  }

  IconData _getIcon() {
    if (venceu == null) {
      return Icons.sentiment_neutral;
    }
    return venceu == true
        ? Icons.sentiment_very_satisfied
        : Icons.sentiment_very_dissatisfied;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.grey,
        child: Container(
          padding: EdgeInsets.all(10),
          child: CircleAvatar(
            backgroundColor: _getColor(),
            child: IconButton(
              padding: EdgeInsets.all(0),
              icon: Icon(
                _getIcon(),
                color: Colors.black,
                size: 35,
              ),
              onPressed: onReiniciar,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(120);
}
