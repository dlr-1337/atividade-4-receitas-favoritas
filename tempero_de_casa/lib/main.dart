import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'receitas.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tempero de Casa',
      debugShowCheckedModeBanner: false,
      locale: const Locale('pt', 'BR'),
      supportedLocales: const [Locale('pt', 'BR')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFAD553D)),
        scaffoldBackgroundColor: const Color(0xFFFFF8F1),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFFFF8F1),
          foregroundColor: Color(0xFF54372D),
        ),
      ),
      home: const TelaPrincipal(),
    );
  }
}

class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({super.key});

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  int _abaSelecionada = 0;
  final Set<int> _favoritas = {};

  static const categorias = ['Doces', 'Salgadas', 'Bebidas'];
  static const icones = [
    Icons.cake_outlined,
    Icons.restaurant_outlined,
    Icons.local_cafe_outlined,
  ];
  static const mensagens = [
    'Um doce para cada momento.',
    'Comida caseira para compartilhar.',
    'Uma pausa cheia de sabor.',
  ];

  void _alternarFavorito(int id) {
    setState(() {
      if (_favoritas.contains(id)) {
        _favoritas.remove(id);
      } else {
        _favoritas.add(id);
      }
    });
  }

  void _abrirInformacoes(String titulo, String texto, IconData icone) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) =>
            TelaInformacoes(titulo: titulo, texto: texto, icone: icone),
      ),
    );
  }

  Widget _cardReceita(Receita receita) {
    final favorita = _favoritas.contains(receita.id);
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 12),
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(
          receita.titulo,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(receita.descricao),
        ),
        trailing: IconButton(
          tooltip: favorita
              ? 'Remover ${receita.titulo} dos favoritos'
              : 'Favoritar ${receita.titulo}',
          icon: Icon(
            favorita ? Icons.favorite : Icons.favorite_border,
            color: const Color(0xFFAD553D),
          ),
          onPressed: () => _alternarFavorito(receita.id),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (context) => TelaDetalhes(receita: receita),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tempero de Casa')),
      body: Center(
        child: SizedBox(
          width: 680,
          child: ListView(
            key: ValueKey(_abaSelecionada),
            padding: const EdgeInsets.all(16),
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3E4D6),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Icon(
                      icones[_abaSelecionada],
                      size: 40,
                      color: const Color(0xFFAD553D),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            categorias[_abaSelecionada],
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF54372D),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(mensagens[_abaSelecionada]),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              for (final receita in receitasPorCategoria[_abaSelecionada])
                _cardReceita(receita),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _abaSelecionada,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFFAD553D),
        type: BottomNavigationBarType.fixed,
        onTap: (indice) {
          setState(() {
            _abaSelecionada = indice;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.cake_outlined),
            label: 'Doces',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_outlined),
            label: 'Salgadas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_cafe_outlined),
            label: 'Bebidas',
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFFAD553D)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.restaurant, color: Colors.white, size: 44),
                  SizedBox(height: 12),
                  Text(
                    'Tempero de Casa',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.settings_outlined),
              title: const Text('Configurações'),
              onTap: () => _abrirInformacoes(
                'Configurações',
                'As receitas estão organizadas nas abas Doces, Salgadas e Bebidas.\n\n'
                    'Toque no coração de um Card para marcar ou desmarcar uma receita como favorita. '
                    'As marcações ficam disponíveis enquanto o aplicativo estiver aberto '
                    'e são apagadas ao reiniciá-lo.\n\n'
                    'Use a seta de voltar para retornar à categoria que estava aberta.',
                Icons.settings_outlined,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('Sobre'),
              onTap: () => _abrirInformacoes(
                'Sobre',
                'Tempero de Casa\n\n'
                    'Um caderno de receitas brasileiras para os pequenos momentos do dia: '
                    'um doce depois do almoço, uma refeição em família ou uma bebida quentinha.\n\n'
                    'Atividade 4: Navegação entre telas.\n\n'
                    'O aplicativo utiliza abas, Cards, menu lateral e navegação entre telas.',
                Icons.info_outline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TelaDetalhes extends StatelessWidget {
  const TelaDetalhes({super.key, required this.receita});

  final Receita receita;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          receita.titulo,
          maxLines: 2,
          style: const TextStyle(fontSize: 18),
        ),
      ),
      body: Center(
        child: SizedBox(
          width: 680,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Text(receita.descricao, style: const TextStyle(fontSize: 17)),
              const SizedBox(height: 24),
              Text(
                'Ingredientes',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              for (final ingrediente in receita.ingredientes)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text('• $ingrediente'),
                ),
              const SizedBox(height: 16),
              Text(
                'Modo de preparo',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              for (var i = 0; i < receita.preparo.length; i++)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 14,
                        backgroundColor: const Color(0xFFF3E4D6),
                        child: Text(
                          (i + 1).toString(),
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF54372D),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(child: Text(receita.preparo[i])),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class TelaInformacoes extends StatelessWidget {
  const TelaInformacoes({
    super.key,
    required this.titulo,
    required this.texto,
    required this.icone,
  });

  final String titulo;
  final String texto;
  final IconData icone;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(titulo)),
      body: Center(
        child: SizedBox(
          width: 680,
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              Icon(icone, size: 64, color: const Color(0xFFAD553D)),
              const SizedBox(height: 24),
              Text(texto, style: const TextStyle(fontSize: 17)),
            ],
          ),
        ),
      ),
    );
  }
}
