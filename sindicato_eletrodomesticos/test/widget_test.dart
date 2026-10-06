import 'dart:ui' show SemanticsAction;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sindicato_eletrodomesticos/main.dart';

void main() {
  testWidgets('Nove comunicados abrem a receita e o responsável corretos', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    const categorias = {
      'Doces': [
        ['Bolo de caneca', 'Miro', 'micro-ondas'],
        ['Brownie', 'Osvaldo', 'forno'],
        ['Pavê', 'Gilda', 'geladeira'],
      ],
      'Salgadas': [
        ['Torta de liquidificador', 'Léo', 'liquidificador'],
        ['Batata gratinada', 'Osvaldo', 'forno'],
        ['Nachos com queijo', 'Miro', 'micro-ondas'],
      ],
      'Bebidas': [
        ['Café coado', 'Cida', 'cafeteira'],
        ['Cappuccino caseiro', 'Cida', 'cafeteira'],
        ['Vitamina de morango', 'Léo', 'liquidificador'],
      ],
    };
    expect(find.text('Sindicato dos\nEletrodomésticos'), findsOneWidget);
    var indice = 0;
    for (final categoria in categorias.entries) {
      await tester.tap(
        find.descendant(
          of: find.byType(BottomNavigationBar),
          matching: find.text(categoria.key),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(Card), findsNWidgets(3));
      for (final dados in categoria.value) {
        await tester.scrollUntilVisible(find.text(dados[0]), 160);
        await tester.pumpAndSettle();
        await tester.tap(find.text(dados[0]));
        await tester.pumpAndSettle();
        expect(find.text(dados[0]), findsOneWidget);
        expect(
          find.text('Responsável: ${dados[1]}, ${dados[2]}'),
          findsOneWidget,
        );
        await tester.scrollUntilVisible(find.text('Ingredientes'), 160);
        await tester.pumpAndSettle();
        expect(find.text('Ingredientes'), findsOneWidget);
        await tester.scrollUntilVisible(find.text('Modo de preparo'), 200);
        await tester.pumpAndSettle();
        expect(find.text('Modo de preparo'), findsOneWidget);
        await tester.tap(find.byType(BackButton));
        await tester.pumpAndSettle();
        expect(
          tester
              .widget<BottomNavigationBar>(find.byType(BottomNavigationBar))
              .currentIndex,
          indice,
        );
      }
      indice++;
    }
  });

  testWidgets(
    'Coração carimba a favorita sem abrir a receita e preserva a sessão',
    (tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.scrollUntilVisible(
        find.byTooltip('Favoritar Bolo de caneca'),
        160,
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip('Favoritar Bolo de caneca'));
      await tester.pumpAndSettle();
      expect(find.text('FAVORITA'), findsOneWidget);
      expect(find.text('Ingredientes'), findsNothing);
      await tester.tap(find.text('Salgadas').last);
      await tester.pumpAndSettle();
      await tester.scrollUntilVisible(
        find.text('Torta de liquidificador'),
        160,
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('Torta de liquidificador'));
      await tester.pumpAndSettle();
      await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();
      expect(
        tester
            .widget<BottomNavigationBar>(find.byType(BottomNavigationBar))
            .currentIndex,
        1,
      );
      await tester.tap(find.text('Doces').last);
      await tester.pumpAndSettle();
      await tester.scrollUntilVisible(
        find.byTooltip('Remover Bolo de caneca dos favoritos'),
        160,
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip('Remover Bolo de caneca dos favoritos'));
      await tester.pumpAndSettle();
      expect(find.text('FAVORITA'), findsNothing);
      await tester.tap(find.byTooltip('Favoritar Bolo de caneca'));
      await tester.pump();
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();
      await tester.scrollUntilVisible(
        find.byTooltip('Favoritar Bolo de caneca'),
        160,
      );
      await tester.pumpAndSettle();
      expect(find.text('FAVORITA'), findsNothing);
    },
  );

  testWidgets('Drawer abre o regulamento e a ata e retorna à mesma aba', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.text('Bebidas'));
    await tester.pumpAndSettle();
    for (final tela in {
      'Configurações': 'Regulamento interno',
      'Sobre': 'Ata de fundação',
    }.entries) {
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();
      await tester.tap(find.text(tela.key));
      await tester.pumpAndSettle();
      expect(find.text(tela.value), findsOneWidget);
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();
      expect(find.text(tela.key), findsNothing);
      expect(
        tester
            .widget<BottomNavigationBar>(find.byType(BottomNavigationBar))
            .currentIndex,
        2,
      );
    }
  });

  testWidgets('Os cinco integrantes têm retrato e voz próprios', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    for (final nome in ['Gilda', 'Osvaldo', 'Léo', 'Cida', 'Miro']) {
      expect(find.text(nome), findsOneWidget);
      expect(find.bySemanticsLabel(RegExp('Retrato de $nome,')), findsWidgets);
    }
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Sobre'));
    await tester.pumpAndSettle();
    for (final frase in [
      'Porta aberta não é ventilador.',
      'Preaquecer também conta como expediente.',
      'Não bato boca. Bato vitamina.',
      'Sem café, essa assembleia nem começa.',
      'Dá para resolver isso em noventa segundos?',
    ]) {
      await tester.scrollUntilVisible(find.textContaining(frase), 180);
      await tester.pumpAndSettle();
      expect(find.textContaining(frase), findsOneWidget);
    }
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'Comunicados são botões e ingredientes são texto para leitores de tela',
    (tester) async {
      await tester.pumpWidget(const MyApp());
      expect(
        tester
            .getSemantics(find.bySemanticsLabel('Abrir receita Bolo de caneca'))
            .flagsCollection
            .isButton,
        isTrue,
      );
      expect(
        tester
            .getSemantics(find.bySemanticsLabel('Abrir receita Bolo de caneca'))
            .getSemanticsData()
            .hasAction(SemanticsAction.tap),
        isTrue,
      );
      await tester.scrollUntilVisible(find.text('Bolo de caneca'), 160);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Bolo de caneca'));
      await tester.pumpAndSettle();
      await tester.scrollUntilVisible(find.text('Ingredientes'), 160);
      await tester.pumpAndSettle();
      expect(
        tester.getSemantics(find.text('Ingredientes')).flagsCollection.isImage,
        isFalse,
      );
    },
  );

  testWidgets('320 e 390 px com fonte ampliada permitem ler e navegar', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.platformDispatcher.textScaleFactorTestValue = 1.3;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    for (final largura in [320.0, 390.0]) {
      await tester.pumpWidget(const SizedBox.shrink());
      tester.view.physicalSize = Size(largura, 700);
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      await tester.tap(find.text('Salgadas').last);
      await tester.pumpAndSettle();
      await tester.scrollUntilVisible(
        find.text('Torta de liquidificador'),
        160,
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('Torta de liquidificador'));
      await tester.pumpAndSettle();
      await tester.scrollUntilVisible(find.textContaining('Asse por'), 200);
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Sobre'));
      await tester.pumpAndSettle();
      await tester.scrollUntilVisible(
        find.textContaining('Dá para resolver'),
        200,
      );
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    }
  });
}
