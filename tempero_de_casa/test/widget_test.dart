import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tempero_de_casa/main.dart';

void main() {
  testWidgets('Abas abrem as nove receitas e voltam à categoria de origem', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    const categorias = {
      'Doces': ['Brigadeiro', 'Bolo de fubá', 'Doce de banana'],
      'Salgadas': [
        'Pão de queijo',
        'Escondidinho de mandioca',
        'Cuscuz temperado',
      ],
      'Bebidas': ['Limonada', 'Vitamina de banana', 'Chocolate quente'],
    };
    expect(find.byType(BottomNavigationBar), findsOneWidget);
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
      for (final titulo in categoria.value) {
        await tester.ensureVisible(find.text(titulo));
        await tester.pumpAndSettle();
        await tester.tap(find.text(titulo));
        await tester.pumpAndSettle();
        expect(find.text(titulo), findsOneWidget);
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

  testWidgets('Coração preserva favoritos até o app ser reiniciado', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.byTooltip('Favoritar Brigadeiro'));
    await tester.pumpAndSettle();
    expect(find.byTooltip('Remover Brigadeiro dos favoritos'), findsOneWidget);
    expect(find.text('Ingredientes'), findsNothing);
    await tester.tap(find.text('Salgadas').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Pão de queijo'));
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
    await tester.ensureVisible(
      find.byTooltip('Remover Brigadeiro dos favoritos'),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Remover Brigadeiro dos favoritos'));
    await tester.pumpAndSettle();
    expect(find.byTooltip('Favoritar Brigadeiro'), findsOneWidget);
    await tester.tap(find.byTooltip('Favoritar Brigadeiro'));
    await tester.pump();
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();
    expect(find.byTooltip('Favoritar Brigadeiro'), findsOneWidget);
  });

  testWidgets('Drawer fecha antes das telas gerais e preserva a aba', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.text('Bebidas'));
    await tester.pumpAndSettle();
    for (final titulo in ['Configurações', 'Sobre']) {
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();
      await tester.tap(find.text(titulo));
      await tester.pumpAndSettle();
      expect(find.text(titulo), findsOneWidget);
      expect(find.byType(BackButton), findsOneWidget);
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();
      expect(find.text(titulo), findsNothing);
      expect(find.text('Limonada'), findsOneWidget);
      expect(
        tester
            .widget<BottomNavigationBar>(find.byType(BottomNavigationBar))
            .currentIndex,
        2,
      );
    }
  });

  testWidgets('Tela estreita permite rolar os Cards e o preparo completo', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 568);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.text('Salgadas'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Escondidinho de mandioca'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Escondidinho de mandioca'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(find.text('Modo de preparo'), 200);
    await tester.pumpAndSettle();
    await tester.drag(find.byType(ListView), const Offset(0, -1000));
    await tester.pumpAndSettle();
    expect(find.textContaining('Gratine'), findsOneWidget);
    expect(tester.takeException(), isNull);
    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Cuscuz temperado'));
    await tester.pumpAndSettle();
    expect(find.text('Cuscuz temperado').hitTestable(), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
