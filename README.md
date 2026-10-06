# Tempero de Casa

Aplicativo Flutter da Atividade 4: Navegação entre telas.

O app reúne nove receitas em três categorias: Doces, Salgadas e Bebidas. Cada Card abre uma tela com a descrição, os ingredientes e o modo de preparo. O coração marca uma receita como favorita enquanto o aplicativo estiver aberto.

O menu lateral abre as telas de Configurações e Sobre. Ao voltar de uma receita ou dessas telas, a categoria selecionada é mantida.

## Executar

Projeto verificado com Flutter 3.47.6. Com o Flutter instalado:

```bash
cd tempero_de_casa
flutter pub get
flutter run
```

Para abrir no navegador:

```bash
flutter run -d chrome
```

## Verificar

```bash
cd tempero_de_casa
flutter analyze
flutter test
flutter build web
```

## Conteúdo utilizado

- Dart: classes, listas e construtores.
- Interface: MaterialApp, Scaffold, Column, ListView e Card.
- Estado: StatefulWidget e setState.
- Navegação: Navigator.push, MaterialPageRoute e Navigator.pop.
- Abas e menu: BottomNavigationBar e Drawer.

Os dados das receitas ficam em `lib/receitas.dart`, e as telas em `lib/main.dart`. O projeto contém suporte a Android e web.

Se o `flutter analyze` dessa versão apresentar um erro de JSON em um caminho com acentos, use `dart analyze` ou execute a análise por um caminho sem acentos.
