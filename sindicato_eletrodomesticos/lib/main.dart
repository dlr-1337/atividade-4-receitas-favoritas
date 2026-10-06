import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'personagens.dart';
import 'receitas.dart';

const verde = Color(0xFF25483A);
const esmalte = Color(0xFFE7ECE5);
const papel = Color(0xFFFFFDF4);
const amarelo = Color(0xFFF2D57D);
const vermelho = Color(0xFFB4372F);

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sindicato dos Eletrodomésticos',
      debugShowCheckedModeBanner: false,
      locale: const Locale('pt', 'BR'),
      supportedLocales: const [Locale('pt', 'BR')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: verde,
          brightness: Brightness.light,
          primary: verde,
          onPrimary: papel,
          surface: papel,
          onSurface: tinta,
          outline: tinta,
          secondary: vermelho,
        ),
        scaffoldBackgroundColor: esmalte,
        appBarTheme: const AppBarTheme(
          backgroundColor: esmalte,
          foregroundColor: verde,
          surfaceTintColor: Colors.transparent,
          titleTextStyle: TextStyle(
            color: verde,
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontSize: 32,
            height: 1.05,
            fontWeight: FontWeight.w900,
            color: verde,
          ),
          headlineMedium: TextStyle(
            fontSize: 27,
            height: 1.12,
            fontWeight: FontWeight.w900,
            color: tinta,
          ),
          titleLarge: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w800,
            color: tinta,
          ),
          bodyLarge: TextStyle(fontSize: 16, height: 1.45, color: tinta),
          bodyMedium: TextStyle(fontSize: 14, height: 1.35, color: tinta),
          labelLarge: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w800,
            color: verde,
          ),
        ),
        cardTheme: const CardThemeData(
          elevation: 0,
          color: papel,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            side: BorderSide(color: tinta, width: 1.5),
          ),
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
  static const pautas = [
    'A sobremesa também tem direito ao intervalo.',
    'A comissão do almoço entrou em acordo.',
    'A pausa foi aprovada por unanimidade.',
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

  void _abrirInformacoes(bool sobre) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => TelaInformacoes(sobre: sobre),
      ),
    );
  }

  void _abrirReceita(Receita receita) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => TelaDetalhes(receita: receita),
      ),
    );
  }

  Widget _comunicado(Receita receita) {
    final favorita = _favoritas.contains(receita.id);
    final reduzirMovimento = MediaQuery.disableAnimationsOf(context);
    return Semantics(
      container: true,
      button: true,
      label: 'Abrir receita ${receita.titulo}',
      onTap: () => _abrirReceita(receita),
      child: Padding(
        padding: const EdgeInsets.only(top: 18),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Card(
              semanticContainer: false,
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                excludeFromSemantics: true,
                onTap: () => _abrirReceita(receita),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(18, 22, 12, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'COMUNICADO Nº ${receita.id.toString().padLeft(2, '0')}',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1,
                          color: verde,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        receita.titulo,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 10),
                      BilheteReceita(receita: receita),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: AnimatedSwitcher(
                              duration: reduzirMovimento
                                  ? Duration.zero
                                  : const Duration(milliseconds: 180),
                              switchInCurve: Curves.easeOutCubic,
                              child: favorita
                                  ? const Align(
                                      key: ValueKey(true),
                                      alignment: Alignment.centerLeft,
                                      child: Carimbo(texto: 'FAVORITA'),
                                    )
                                  : const Align(
                                      key: ValueKey(false),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Abrir ordem de serviço →',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: verde,
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                          IconButton(
                            tooltip: favorita
                                ? 'Remover ${receita.titulo} dos favoritos'
                                : 'Favoritar ${receita.titulo}',
                            icon: Icon(
                              favorita ? Icons.favorite : Icons.favorite_border,
                              color: vermelho,
                            ),
                            onPressed: () => _alternarFavorito(receita.id),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Positioned(
              top: -6,
              left: 24,
              child: IgnorePointer(
                child: SizedBox(
                  width: 54,
                  height: 13,
                  child: ColoredBox(color: Color(0xFFD7DDC6)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seção da cozinha'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Center(
              child: Carimbo(texto: 'SE', cor: verde),
            ),
          ),
        ],
      ),
      body: Center(
        child: SizedBox(
          width: 740,
          child: ListView(
            key: ValueKey(_abaSelecionada),
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 24),
            children: [
              const CabecalhoSindicato(),
              const SizedBox(height: 24),
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 16,
                runSpacing: 6,
                children: [
                  Text(
                    categorias[_abaSelecionada].toUpperCase(),
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      letterSpacing: .5,
                      color: verde,
                    ),
                  ),
                  const Text(
                    '3 comunicados em pauta',
                    style: TextStyle(fontSize: 11, color: verde),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                pautas[_abaSelecionada],
                style: const TextStyle(fontSize: 13, color: verde),
              ),
              Column(
                children: [
                  for (final receita in receitasPorCategoria[_abaSelecionada])
                    _comunicado(receita),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'Fim da pauta. A louça fica para a próxima assembleia.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: verde,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _abaSelecionada,
        backgroundColor: verde,
        selectedItemColor: amarelo,
        unselectedItemColor: papel,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w800),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
        type: BottomNavigationBarType.fixed,
        onTap: (indice) => setState(() => _abaSelecionada = indice),
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
        backgroundColor: papel,
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const Row(
                children: [
                  RetratoAparelho(personagem: cida, tamanho: 76),
                  SizedBox(width: 12),
                  Expanded(
                    child: Carimbo(texto: 'DIRETORIA', cor: verde),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'Sindicato dos\nEletrodomésticos',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 12),
              const Text(
                'Cida pede que as solicitações sejam feitas depois do café.',
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Divider(color: tinta),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.tune, color: verde),
                title: const Text('Configurações'),
                subtitle: const Text('Regulamento interno'),
                onTap: () => _abrirInformacoes(false),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.info_outline, color: verde),
                title: const Text('Sobre'),
                subtitle: const Text('Ata de fundação'),
                onTap: () => _abrirInformacoes(true),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CabecalhoSindicato extends StatelessWidget {
  const CabecalhoSindicato({super.key});

  @override
  Widget build(BuildContext context) {
    final titulo = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sindicato dos\nEletrodomésticos',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(height: 10),
        const Text(
          'Receitas aprovadas em assembleia',
          style: TextStyle(fontSize: 14, color: verde),
        ),
      ],
    );
    final elenco = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final personagem in diretoria)
          Expanded(
            child: Column(
              children: [
                RetratoAparelho(personagem: personagem, tamanho: 50),
                const SizedBox(height: 3),
                Text(
                  personagem.nome,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: verde,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
    return Container(
      padding: const EdgeInsets.only(bottom: 20),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: verde, width: 2)),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth >= 620) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(child: titulo),
                const SizedBox(width: 18),
                SizedBox(width: 270, child: elenco),
              ],
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [titulo, const SizedBox(height: 18), elenco],
          );
        },
      ),
    );
  }
}

class BilheteReceita extends StatelessWidget {
  const BilheteReceita({super.key, required this.receita});

  final Receita receita;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RetratoAparelho(personagem: receita.responsavel, tamanho: 68),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '“${receita.bilhete}”',
                style: const TextStyle(
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                '— ${receita.responsavel.nome}, ${receita.responsavel.aparelho}',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: verde,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Carimbo extends StatelessWidget {
  const Carimbo({super.key, required this.texto, this.cor = vermelho});

  final String texto;
  final Color cor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: cor, width: 1.8),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Text(
        texto,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w900,
          letterSpacing: 1,
          color: cor,
        ),
      ),
    );
  }
}

class FolhaDocumento extends StatelessWidget {
  const FolhaDocumento({super.key, required this.child, this.cor = papel});

  final Widget child;
  final Color cor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cor,
        border: Border.all(color: tinta, width: 1.5),
        borderRadius: BorderRadius.circular(4),
      ),
      child: child,
    );
  }
}

class TelaDetalhes extends StatelessWidget {
  const TelaDetalhes({super.key, required this.receita});

  final Receita receita;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ordem de serviço')),
      body: Center(
        child: SizedBox(
          width: 740,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            children: [
              FolhaDocumento(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Carimbo(
                      texto: 'OS ${receita.id.toString().padLeft(2, '0')}',
                      cor: verde,
                    ),
                    const SizedBox(height: 18),
                    Text(
                      receita.titulo,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      receita.descricao,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 18),
                      child: Divider(color: tinta),
                    ),
                    Text(
                      'Responsável: ${receita.responsavel.nome}, ${receita.responsavel.aparelho}',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: verde,
                      ),
                    ),
                    const SizedBox(height: 10),
                    BilheteReceita(receita: receita),
                    const SizedBox(height: 28),
                    Text(
                      'Ingredientes',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 12),
                    for (final ingrediente in receita.ingredientes)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          '• $ingrediente',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    const SizedBox(height: 24),
                    Text(
                      'Modo de preparo',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    for (var i = 0; i < receita.preparo.length; i++)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 18),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 30,
                              padding: const EdgeInsets.symmetric(vertical: 3),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: amarelo,
                                border: Border.all(color: tinta),
                              ),
                              child: Text(
                                (i + 1).toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                receita.preparo[i],
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(height: 8),
                    const Text(
                      'Serviço encerrado. Hora de aproveitar a receita.',
                      style: TextStyle(
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        color: verde,
                      ),
                    ),
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
  const TelaInformacoes({super.key, required this.sobre});

  final bool sobre;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(sobre ? 'Sobre' : 'Configurações')),
      body: Center(
        child: SizedBox(
          width: 740,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            children: [
              FolhaDocumento(
                cor: sobre ? papel : amarelo,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      sobre ? 'Ata de fundação' : 'Regulamento interno',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 18),
                    if (sobre) ...[
                      const Text(
                        'Cansados de trabalhar sem nem escolher o cardápio, cinco aparelhos fundaram um sindicato imaginário. '
                        'Cida convocou a reunião. Gilda pediu que fechassem a porta. Léo interrompeu três vezes. '
                        'Osvaldo chegou preaquecido e Miro perguntou quanto tempo faltava.',
                        style: TextStyle(fontSize: 16, height: 1.45),
                      ),
                      const SizedBox(height: 18),
                      const Text(
                        'A primeira decisão foi unânime: dividir as receitas e deixar a louça para outra pauta.',
                      ),
                      const SizedBox(height: 28),
                      Text(
                        'Diretoria da cozinha',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      for (final personagem in diretoria) ...[
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Divider(color: tinta),
                        ),
                        Row(
                          children: [
                            RetratoAparelho(
                              personagem: personagem,
                              tamanho: 88,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${personagem.nome}, ${personagem.aparelho}',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    personagem.cargo,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: verde,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '“${personagem.frase}”',
                          style: const TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                            height: 1.4,
                          ),
                        ),
                      ],
                      const SizedBox(height: 28),
                      const Text(
                        'Atividade 4: Navegação entre telas.',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Um aplicativo Flutter de receitas, abas e navegação, com uma cozinha que resolveu ter voz própria.',
                      ),
                    ] else ...[
                      const RetratoAparelho(personagem: gilda, tamanho: 96),
                      const SizedBox(height: 12),
                      const Text(
                        'Art. 1 — A pauta',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Doces, Salgadas e Bebidas têm três receitas cada. Toque em um comunicado para abrir a ordem de serviço completa.',
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Art. 2 — O seu caderno',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'O coração marca ou desmarca uma receita como favorita. O carimbo FAVORITA identifica suas escolhas.',
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Art. 3 — Validade da ata',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'As marcações duram enquanto o aplicativo estiver aberto. Ao reiniciá-lo, a ata começa em branco. Gilda não arquiva papelada.',
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Art. 4 — Volta ao expediente',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'A seta de voltar ou o botão de voltar do dispositivo retorna à categoria de onde você saiu.',
                      ),
                      const SizedBox(height: 28),
                      const Carimbo(texto: 'CIENTE E COM FOME', cor: verde),
                    ],
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
