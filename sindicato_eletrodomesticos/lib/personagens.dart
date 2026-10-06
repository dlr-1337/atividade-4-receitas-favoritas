import 'package:flutter/material.dart';

import 'receitas.dart';

const tinta = Color(0xFF21231F);

class RetratoAparelho extends StatelessWidget {
  const RetratoAparelho({
    super.key,
    required this.personagem,
    this.tamanho = 80,
  });

  final Eletrodomestico personagem;
  final double tamanho;

  Widget _peca(
    double x,
    double y,
    double largura,
    double altura, {
    Color? cor,
    double raio = 4,
    bool contorno = true,
  }) {
    return Positioned(
      left: x,
      top: y,
      width: largura,
      height: altura,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: cor ?? Color(personagem.cor),
          borderRadius: BorderRadius.circular(raio),
          border: contorno ? Border.all(color: tinta, width: 2.4) : null,
        ),
      ),
    );
  }

  List<Widget> _silhueta() {
    switch (personagem.tipo) {
      case TipoAparelho.geladeira:
        return [
          _peca(30, 11, 61, 96, raio: 7),
          _peca(31, 48, 59, 3, cor: tinta, raio: 0, contorno: false),
          _peca(80, 23, 4, 16, cor: tinta, contorno: false),
          _peca(80, 60, 4, 19, cor: tinta, contorno: false),
          _peca(38, 107, 9, 5, cor: tinta, contorno: false),
          _peca(75, 107, 9, 5, cor: tinta, contorno: false),
          _rosto(42, 64),
          _peca(41, 17, 25, 17, cor: const Color(0xFFF2D57D), raio: 1),
        ];
      case TipoAparelho.forno:
        return [
          _peca(18, 28, 84, 79, raio: 5),
          _peca(27, 53, 66, 44, cor: const Color(0xFF38483E), raio: 3),
          _peca(28, 47, 64, 4, cor: tinta, contorno: false),
          _peca(27, 35, 9, 9, cor: const Color(0xFFFFFDF4), raio: 9),
          _peca(45, 35, 9, 9, cor: const Color(0xFFFFFDF4), raio: 9),
          _peca(78, 35, 9, 9, cor: const Color(0xFFFFFDF4), raio: 9),
          _peca(30, 19, 58, 3, cor: tinta, contorno: false),
          _peca(26, 108, 10, 5, cor: tinta, contorno: false),
          _peca(84, 108, 10, 5, cor: tinta, contorno: false),
          _rosto(39, 65, claro: true),
        ];
      case TipoAparelho.liquidificador:
        return [
          _peca(82, 27, 18, 36, cor: const Color(0xFFE7ECE5), raio: 8),
          _peca(35, 20, 52, 57, cor: const Color(0xFFD6E4DE), raio: 8),
          _peca(34, 15, 54, 8, raio: 3),
          _peca(42, 76, 38, 8, cor: tinta, raio: 2),
          _peca(27, 83, 68, 25, raio: 7),
          _peca(55, 88, 12, 12, cor: const Color(0xFFFFFDF4), raio: 12),
          _peca(
            43,
            56,
            38,
            15,
            cor: Color(personagem.cor),
            raio: 4,
            contorno: false,
          ),
          _rosto(40, 30),
        ];
      case TipoAparelho.cafeteira:
        return [
          _peca(22, 18, 77, 23, raio: 8),
          _peca(24, 37, 16, 64, raio: 3),
          _peca(34, 42, 59, 7, cor: tinta, raio: 2),
          _peca(23, 99, 77, 9, raio: 3),
          _peca(44, 56, 45, 37, cor: const Color(0xFFE1D7B5), raio: 8),
          _peca(84, 62, 17, 20, cor: const Color(0xFFE7ECE5), raio: 6),
          _peca(
            47,
            79,
            39,
            10,
            cor: const Color(0xFF6D4C39),
            raio: 2,
            contorno: false,
          ),
          _peca(60, 45, 5, 10, cor: tinta, raio: 0, contorno: false),
          _rosto(38, 22),
          _peca(42, 8, 4, 7, cor: tinta, raio: 2, contorno: false),
          _peca(56, 4, 4, 10, cor: tinta, raio: 2, contorno: false),
        ];
      case TipoAparelho.microondas:
        return [
          _peca(12, 34, 96, 62, raio: 8),
          _peca(20, 43, 64, 44, cor: const Color(0xFF38483E), raio: 5),
          _peca(78, 47, 3, 35, cor: const Color(0xFFFFFDF4), contorno: false),
          _peca(91, 46, 9, 17, cor: tinta, raio: 2, contorno: false),
          _peca(93, 72, 5, 5, cor: tinta, raio: 5, contorno: false),
          _peca(93, 81, 5, 5, cor: tinta, raio: 5, contorno: false),
          _peca(21, 97, 10, 6, cor: tinta, contorno: false),
          _peca(88, 97, 10, 6, cor: tinta, contorno: false),
          _rosto(28, 52, claro: true),
        ];
    }
  }

  Widget _rosto(double x, double y, {bool claro = false}) {
    final cor = claro ? const Color(0xFFFFFDF4) : tinta;
    final cansada = personagem.tipo == TipoAparelho.cafeteira;
    final seria = personagem.tipo == TipoAparelho.geladeira;
    return Positioned(
      left: x,
      top: y,
      width: 40,
      height: 30,
      child: Stack(
        children: [
          Positioned(
            left: 4,
            top: 5,
            child: Container(
              width: 7,
              height: cansada ? 3 : 7,
              decoration: BoxDecoration(
                color: cor,
                borderRadius: BorderRadius.circular(7),
              ),
            ),
          ),
          Positioned(
            right: 4,
            top: 5,
            child: Container(
              width: 7,
              height: cansada ? 3 : 7,
              decoration: BoxDecoration(
                color: cor,
                borderRadius: BorderRadius.circular(7),
              ),
            ),
          ),
          if (seria)
            Positioned(
              left: 1,
              top: 0,
              child: Transform.rotate(
                angle: .13,
                child: Container(width: 14, height: 2.4, color: cor),
              ),
            ),
          Positioned(
            left: 12,
            top: 16,
            child: Container(
              width: 16,
              height: seria || cansada ? 3 : 9,
              decoration: BoxDecoration(
                color: personagem.tipo == TipoAparelho.liquidificador
                    ? cor
                    : null,
                border: Border(
                  bottom: BorderSide(color: cor, width: 2.4),
                  left: seria || cansada
                      ? BorderSide.none
                      : BorderSide(color: cor, width: 2),
                  right: seria || cansada
                      ? BorderSide.none
                      : BorderSide(color: cor, width: 2),
                ),
                borderRadius: seria || cansada
                    ? null
                    : const BorderRadius.vertical(bottom: Radius.circular(9)),
              ),
            ),
          ),
          if (personagem.tipo == TipoAparelho.forno)
            Positioned(
              left: 8,
              top: 14,
              child: Container(
                width: 24,
                height: 4,
                decoration: BoxDecoration(
                  color: cor,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      label: 'Retrato de ${personagem.nome}, ${personagem.aparelho}',
      image: true,
      child: ExcludeSemantics(
        child: SizedBox(
          width: tamanho,
          height: tamanho,
          child: FittedBox(
            child: SizedBox(
              width: 120,
              height: 120,
              child: Stack(children: _silhueta()),
            ),
          ),
        ),
      ),
    );
  }
}
