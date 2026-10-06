# Sindicato dos Eletrodomésticos

Um mural de receitas na porta da geladeira. Gilda, Osvaldo, Léo, Cida e Miro dividiram o trabalho da cozinha e resolveram apresentar suas receitas em comunicados assinados.

Aplicativo Flutter da Atividade 4: Navegação entre telas.

## O app

- Doces, Salgadas e Bebidas, com três receitas em cada aba.
- Cards como comunicados, com retratos desenhados usando widgets Flutter.
- Detalhes com descrição, ingredientes e modo de preparo.
- Coração para marcar favoritas, identificadas por um carimbo durante a sessão.
- Drawer com Configurações (regulamento) e Sobre (ata de fundação e personagens).
- Retorno por seta ou botão do dispositivo, preservando a aba selecionada.

## Executar

Projeto verificado com Flutter 3.47.6.

```bash
cd sindicato_eletrodomesticos
flutter pub get
flutter run
```

Para abrir no navegador:

```bash
flutter run -d chrome
```

## Verificar

```bash
cd sindicato_eletrodomesticos
flutter analyze
flutter test
flutter build web
```

Se o `flutter analyze` dessa versão apresentar um erro de JSON em um caminho com acentos, use `dart analyze` ou execute a análise por um caminho sem acentos.

## Organização

`lib/main.dart` contém as telas; `lib/receitas.dart` contém o catálogo e os personagens; `lib/personagens.dart` monta os retratos com `Stack`, `Container` e outros widgets.

O projeto utiliza classes e listas em Dart, `StatefulWidget`, `setState`, `Card`, `BottomNavigationBar`, `Drawer`, `Navigator.push`, `MaterialPageRoute` e retorno pela pilha de navegação. Há suporte a Android e web; a prévia e os testes de interface foram verificados na versão web e em testes de widgets.
