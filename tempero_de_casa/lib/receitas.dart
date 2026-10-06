class Receita {
  const Receita({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.ingredientes,
    required this.preparo,
  });

  final int id;
  final String titulo;
  final String descricao;
  final List<String> ingredientes;
  final List<String> preparo;
}

const List<List<Receita>> receitasPorCategoria = [
  [
    Receita(
      id: 1,
      titulo: 'Brigadeiro',
      descricao:
          'O doce de chocolate que combina com festa e com uma tarde em casa.',
      ingredientes: [
        '1 lata de leite condensado (395 g)',
        '3 colheres de sopa de chocolate em pó',
        '1 colher de sopa de manteiga',
        '1/2 xícara de chocolate granulado',
      ],
      preparo: [
        'Coloque o leite condensado, o chocolate e a manteiga em uma panela.',
        'Cozinhe em fogo baixo, mexendo sempre, até a mistura desgrudar do fundo.',
        'Deixe esfriar, unte as mãos com manteiga e faça pequenas bolinhas.',
        'Passe as bolinhas no granulado e coloque em forminhas.',
      ],
    ),
    Receita(
      id: 2,
      titulo: 'Bolo de fubá',
      descricao: 'Um bolo macio e simples para acompanhar o café da tarde.',
      ingredientes: [
        '3 ovos',
        '1 xícara de açúcar',
        '1 xícara de leite',
        '1/2 xícara de óleo',
        '1 xícara de fubá',
        '1 xícara de farinha de trigo',
        '1 colher de sopa de fermento em pó',
      ],
      preparo: [
        'Preaqueça o forno a 180 °C e unte uma forma.',
        'Bata os ovos, o açúcar, o leite e o óleo até misturar.',
        'Acrescente o fubá e a farinha. Misture e adicione o fermento por último.',
        'Despeje na forma e asse por 30 a 40 minutos, até um palito sair limpo.',
      ],
    ),
    Receita(
      id: 3,
      titulo: 'Doce de banana',
      descricao:
          'Uma forma gostosa de aproveitar as bananas maduras da fruteira.',
      ingredientes: [
        '5 bananas maduras',
        '1/2 xícara de açúcar',
        '1/4 de xícara de água',
        '1 colher de sopa de suco de limão',
        'Canela em pó a gosto',
      ],
      preparo: [
        'Descasque as bananas e corte em rodelas.',
        'Coloque as bananas, o açúcar e a água em uma panela.',
        'Cozinhe em fogo baixo por cerca de 20 minutos, mexendo até ficar cremoso.',
        'Adicione o limão e a canela. Deixe esfriar antes de servir.',
      ],
    ),
  ],
  [
    Receita(
      id: 4,
      titulo: 'Pão de queijo',
      descricao: 'Crocante por fora e macio por dentro, do jeito que um bom lanche pede.',
      ingredientes: [
        '2 xícaras de polvilho azedo',
        '1 xícara de leite',
        '1/3 de xícara de óleo',
        '2 ovos',
        '1 xícara de queijo minas ralado',
        '1 colher de chá de sal',
      ],
      preparo: [
        'Preaqueça o forno a 180 °C. Ferva o leite com o óleo e o sal.',
        'Despeje o líquido sobre o polvilho e misture. Espere amornar.',
        'Adicione os ovos aos poucos e o queijo, misturando até formar uma massa.',
        'Com as mãos untadas, faça bolinhas e distribua em uma assadeira.',
        'Asse por 25 a 30 minutos, até os pães crescerem e ficarem dourados.',
      ],
    ),
    Receita(
      id: 5,
      titulo: 'Escondidinho de mandioca',
      descricao: 'Purê de mandioca, carne bem temperada e queijo gratinado.',
      ingredientes: [
        '500 g de mandioca descascada',
        '300 g de carne moída',
        '1/2 cebola picada',
        '2 dentes de alho picados',
        '1 colher de sopa de manteiga',
        '1/2 xícara de leite',
        '100 g de muçarela ralada',
        '1 colher de sopa de óleo',
        'Sal a gosto',
      ],
      preparo: [
        'Cozinhe a mandioca em água até ficar macia. Escorra e retire o fio central.',
        'Amasse a mandioca e misture com o leite, a manteiga e uma pitada de sal.',
        'Aqueça o óleo, refogue a cebola e o alho e acrescente a carne. Cozinhe bem e ajuste o sal.',
        'Em um refratário, coloque a carne, cubra com o purê e espalhe a muçarela.',
        'Gratine no forno preaquecido a 200 °C por 15 a 20 minutos.',
      ],
    ),
    Receita(
      id: 6,
      titulo: 'Cuscuz temperado',
      descricao: 'Um cuscuz leve com tomate, cebola e cheiro-verde.',
      ingredientes: [
        '1 xícara de flocão de milho',
        '1/2 xícara de água',
        '1/2 colher de chá de sal',
        '1/2 tomate picado',
        '1/2 cebola picada',
        '1 colher de sopa de manteiga',
        '2 colheres de sopa de cheiro-verde',
      ],
      preparo: [
        'Misture o flocão, a água e o sal. Deixe hidratar por 10 minutos.',
        'Coloque na cuscuzeira com água na parte de baixo e cozinhe no vapor por 15 minutos.',
        'Em uma frigideira, derreta a manteiga e refogue a cebola e o tomate.',
        'Solte o cuscuz com um garfo, misture com o refogado e finalize com cheiro-verde.',
      ],
    ),
  ],
  [
    Receita(
      id: 7,
      titulo: 'Limonada',
      descricao: 'Uma bebida refrescante para os dias de calor.',
      ingredientes: [
        '3 limões',
        '4 xícaras de água gelada',
        '3 colheres de sopa de açúcar, ou a gosto',
        'Gelo a gosto',
      ],
      preparo: [
        'Lave os limões, corte ao meio e esprema o suco.',
        'Coe o suco para retirar as sementes e coloque em uma jarra.',
        'Adicione a água e o açúcar e mexa bem.',
        'Sirva com gelo e, se quiser, uma rodela de limão.',
      ],
    ),
    Receita(
      id: 8,
      titulo: 'Vitamina de banana',
      descricao: 'Banana, leite e aveia para começar o dia com disposição.',
      ingredientes: [
        '2 bananas maduras',
        '2 xícaras de leite',
        '1 colher de sopa de aveia',
        '1 colher de sopa de mel (opcional)',
      ],
      preparo: [
        'Descasque as bananas e corte em pedaços.',
        'Coloque as bananas, o leite e a aveia no liquidificador.',
        'Bata até ficar cremoso. Adicione o mel se desejar.',
        'Sirva logo após bater.',
      ],
    ),
    Receita(
      id: 9,
      titulo: 'Chocolate quente',
      descricao: 'Chocolate cremoso para aquecer uma noite mais fresca.',
      ingredientes: [
        '2 xícaras de leite',
        '2 colheres de sopa de chocolate em pó',
        '1 colher de sopa de açúcar',
        '1 colher de sopa de amido de milho',
        'Canela em pó a gosto (opcional)',
      ],
      preparo: [
        'Dissolva o amido em um pouco do leite ainda frio.',
        'Coloque em uma panela com o restante do leite, o chocolate e o açúcar.',
        'Leve ao fogo baixo e mexa até ferver e engrossar.',
        'Sirva quente e finalize com canela, se desejar.',
      ],
    ),
  ],
];
