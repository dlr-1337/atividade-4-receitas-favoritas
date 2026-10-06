enum TipoAparelho { geladeira, forno, liquidificador, cafeteira, microondas }

class Eletrodomestico {
  const Eletrodomestico({
    required this.nome,
    required this.aparelho,
    required this.cargo,
    required this.frase,
    required this.tipo,
    required this.cor,
  });

  final String nome;
  final String aparelho;
  final String cargo;
  final String frase;
  final TipoAparelho tipo;
  final int cor;
}

const gilda = Eletrodomestico(
  nome: 'Gilda',
  aparelho: 'geladeira',
  cargo: 'Fiscal de energia',
  frase: 'Porta aberta não é ventilador.',
  tipo: TipoAparelho.geladeira,
  cor: 0xFF9BB6A0,
);
const osvaldo = Eletrodomestico(
  nome: 'Osvaldo',
  aparelho: 'forno',
  cargo: 'Veterano do turno quente',
  frase: 'Preaquecer também conta como expediente.',
  tipo: TipoAparelho.forno,
  cor: 0xFFC58460,
);
const leo = Eletrodomestico(
  nome: 'Léo',
  aparelho: 'liquidificador',
  cargo: 'Porta-voz barulhento',
  frase: 'Não bato boca. Bato vitamina.',
  tipo: TipoAparelho.liquidificador,
  cor: 0xFF9AB7BE,
);
const cida = Eletrodomestico(
  nome: 'Cida',
  aparelho: 'cafeteira',
  cargo: 'Presidente do sindicato',
  frase: 'Sem café, essa assembleia nem começa.',
  tipo: TipoAparelho.cafeteira,
  cor: 0xFFD58B77,
);
const miro = Eletrodomestico(
  nome: 'Miro',
  aparelho: 'micro-ondas',
  cargo: 'Negociador de intervalos',
  frase: 'Dá para resolver isso em noventa segundos?',
  tipo: TipoAparelho.microondas,
  cor: 0xFFE5C56D,
);

const diretoria = [gilda, osvaldo, leo, cida, miro];

class Receita {
  const Receita({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.responsavel,
    required this.bilhete,
    required this.ingredientes,
    required this.preparo,
  });

  final int id;
  final String titulo;
  final String descricao;
  final Eletrodomestico responsavel;
  final String bilhete;
  final List<String> ingredientes;
  final List<String> preparo;
}

const List<List<Receita>> receitasPorCategoria = [
  [
    Receita(
      id: 1,
      titulo: 'Bolo de caneca',
      descricao: 'Um bolo de chocolate individual, feito na própria caneca.',
      responsavel: miro,
      bilhete: 'Solicito que a sobremesa respeite meu expediente de noventa segundos.',
      ingredientes: [
        '3 colheres de sopa de farinha de trigo',
        '2 colheres de sopa de açúcar',
        '1 colher de sopa de chocolate em pó',
        '3 colheres de sopa de leite',
        '1 colher de sopa de óleo',
        '1/2 colher de chá de fermento em pó',
      ],
      preparo: [
        'Em uma caneca grande própria para micro-ondas, sem partes metálicas, misture a farinha, o açúcar e o chocolate.',
        'Junte o leite e o óleo. Mexa até não sobrar farinha seca e acrescente o fermento.',
        'Leve ao micro-ondas por 90 segundos em potência alta. Se a superfície ainda estiver líquida, aqueça em intervalos de 15 segundos.',
        'Espere amornar antes de comer: a caneca também fica quente.',
      ],
    ),
    Receita(
      id: 2,
      titulo: 'Brownie',
      descricao: 'Chocolate intenso, casquinha fina e um miolo macio.',
      responsavel: osvaldo,
      bilhete:
          'Aceito trabalhar vinte minutos. A casquinha sai por minha conta.',
      ingredientes: [
        '2 ovos',
        '1/2 xícara de açúcar',
        '4 colheres de sopa de manteiga derretida',
        '1/2 xícara de chocolate em pó',
        '1/2 xícara de farinha de trigo',
        '1 pitada de sal',
      ],
      preparo: [
        'Preaqueça o forno a 180 °C e unte uma forma pequena.',
        'Misture os ovos, o açúcar e a manteiga. Acrescente o chocolate.',
        'Adicione a farinha e o sal e misture apenas até incorporar.',
        'Asse por 20 a 25 minutos, até a superfície formar uma casquinha e o centro ficar firme, mas úmido.',
        'Espere esfriar um pouco antes de cortar.',
      ],
    ),
    Receita(
      id: 3,
      titulo: 'Pavê',
      descricao: 'Camadas de creme e biscoito que ficam melhores bem geladas.',
      responsavel: gilda,
      bilhete: 'Reservei uma prateleira. Não transformem a porta em ponto de encontro.',
      ingredientes: [
        '1 lata de leite condensado (395 g)',
        '1 xícara de leite para o creme',
        '2 colheres de sopa de amido de milho',
        '1 caixa de creme de leite (200 g)',
        '200 g de biscoito maisena',
        '1/2 xícara de leite para umedecer os biscoitos',
      ],
      preparo: [
        'Dissolva o amido no leite frio e coloque em uma panela com o leite condensado.',
        'Cozinhe em fogo baixo, mexendo até engrossar. Desligue, misture o creme de leite e deixe amornar.',
        'Umedeça rapidamente os biscoitos no leite e alterne camadas de biscoito e creme em uma travessa.',
        'Cubra e leve à geladeira por pelo menos 3 horas antes de servir.',
      ],
    ),
  ],
  [
    Receita(
      id: 4,
      titulo: 'Torta de liquidificador',
      descricao:
          'Massa leve e recheio de legumes para um lanche compartilhado.',
      responsavel: leo,
      bilhete:
          'Eu faço a massa. A pauta sobre lavar meu copo fica para depois.',
      ingredientes: [
        '2 ovos',
        '1 xícara de leite',
        '1/4 de xícara de óleo',
        '1 xícara de farinha de trigo',
        '1 colher de sopa de fermento em pó',
        '1/2 colher de chá de sal',
        '1 tomate picado',
        '1/2 xícara de milho',
        '1/2 xícara de ervilha',
      ],
      preparo: [
        'Preaqueça o forno a 180 °C e unte uma forma pequena.',
        'Bata no liquidificador os ovos, o leite, o óleo, a farinha e o sal até obter uma massa lisa.',
        'Acrescente o fermento e misture com uma colher. Em outro recipiente, misture o tomate, o milho e a ervilha.',
        'Coloque metade da massa na forma, distribua o recheio e cubra com o restante.',
        'Asse por 30 a 35 minutos, até dourar e um palito sair limpo da massa.',
      ],
    ),
    Receita(
      id: 5,
      titulo: 'Batata gratinada',
      descricao: 'Batatas macias cobertas de creme e queijo dourado.',
      responsavel: osvaldo,
      bilhete: 'Gratinar é serviço especializado. Crocante não significa carbonizado.',
      ingredientes: [
        '600 g de batatas',
        '1 caixa de creme de leite (200 g)',
        '1/2 xícara de leite',
        '100 g de muçarela ralada',
        '1 colher de sopa de manteiga',
        'Sal e pimenta a gosto',
      ],
      preparo: [
        'Descasque as batatas e corte em rodelas. Cozinhe em água com sal até começarem a ficar macias e escorra.',
        'Misture o creme de leite com o leite, o sal e a pimenta.',
        'Unte um refratário com a manteiga. Distribua as batatas e despeje o creme.',
        'Cubra com a muçarela e leve ao forno preaquecido a 200 °C por 20 a 25 minutos, até gratinar.',
      ],
    ),
    Receita(
      id: 6,
      titulo: 'Nachos com queijo',
      descricao: 'Um prato de nachos com queijo derretido e tomate fresco.',
      responsavel: miro,
      bilhete: 'Esta reunião pode ser um prato. E este prato pode ficar pronto agora.',
      ingredientes: [
        '100 g de nachos de milho',
        '80 g de muçarela ralada',
        '1 colher de sopa de requeijão',
        '1/2 tomate picado',
        'Cheiro-verde a gosto',
      ],
      preparo: [
        'Distribua os nachos em um prato próprio para micro-ondas, sem partes metálicas.',
        'Espalhe pequenas porções de requeijão e cubra com a muçarela.',
        'Aqueça por 30 segundos e verifique o queijo. Se necessário, aqueça mais 15 segundos de cada vez.',
        'Finalize com tomate e cheiro-verde e sirva imediatamente.',
      ],
    ),
  ],
  [
    Receita(
      id: 7,
      titulo: 'Café coado',
      descricao: 'Café recém-passado para abrir os trabalhos da cozinha.',
      responsavel: cida,
      bilhete: 'Declaro aberta a assembleia. Primeiro o café, depois as reclamações.',
      ingredientes: [
        '300 ml de água',
        '3 colheres de sopa de café moído',
        'Açúcar a gosto (opcional)',
      ],
      preparo: [
        'Coloque a água no reservatório da cafeteira e posicione um filtro no suporte.',
        'Adicione o café moído ao filtro e encaixe a jarra.',
        'Ligue a cafeteira e aguarde a passagem da água.',
        'Sirva assim que terminar. Adoce se desejar.',
      ],
    ),
    Receita(
      id: 8,
      titulo: 'Cappuccino caseiro',
      descricao: 'Café, leite espumado e chocolate em uma xícara só.',
      responsavel: cida,
      bilhete:
          'O acordo coletivo prevê espuma. Chocolate entra como benefício.',
      ingredientes: [
        '150 ml de café coado quente',
        '150 ml de leite',
        '1 colher de chá de chocolate em pó',
        'Açúcar a gosto',
        'Canela em pó a gosto (opcional)',
      ],
      preparo: [
        'Prepare o café na cafeteira e distribua em duas xícaras pequenas.',
        'Aqueça o leite sem deixar ferver. Bata com um batedor manual para formar espuma.',
        'Misture o chocolate ao café e adoce se desejar.',
        'Despeje o leite, coloque a espuma por cima e finalize com canela.',
      ],
    ),
    Receita(
      id: 9,
      titulo: 'Vitamina de morango',
      descricao: 'Morango e leite batidos para uma pausa fresca.',
      responsavel: leo,
      bilhete: 'Não é gritaria. É minha contribuição sonora para o intervalo.',
      ingredientes: [
        '8 morangos',
        '1 xícara de leite gelado',
        '1 colher de sopa de aveia',
        '1 colher de sopa de açúcar ou mel (opcional)',
      ],
      preparo: [
        'Lave os morangos e retire as folhas.',
        'Coloque os morangos, o leite e a aveia no liquidificador.',
        'Bata até ficar cremoso. Adoce se desejar.',
        'Sirva logo após bater.',
      ],
    ),
  ],
];
