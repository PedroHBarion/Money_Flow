import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

async function main() {
  const questions = [
    {
      text: 'Qual sua principal fonte de renda?',
      answers: [
        'Bolsa/Estágio',
        'Trabalho CLT',
        'Autônomo/Freelancer',
        'Ajuda de Familiares',
        'Outro(s)',
      ],
    },
    {
      text: 'Você já teve dificuldades para fechar o mês financeiramente?',
      answers: [
        'Sim, frequentemente',
        'Às vezes, depende dos gastos',
        'Não, costumo me planejar bem',
      ],
    },
    {
      text: 'Qual seu maior desafio financeiro?',
      answers: [
        'Gastar menos com lazer/compras impulsivas',
        'Economizar dinheiro para investimentos',
        'Organizar melhor as contas fixas',
        'Aprender mais sobre finanças pessoais',
      ],
    },
    {
      text: 'Você tem metas financeiras específicas?',
      answers: [
        'Sim, quero juntar dinheiro para algo específico',
        'Quero reduzir gastos desnecessários',
        'Não tenho metas definidas',
      ],
    },
    {
      text: 'O que você mais quer melhorar nas suas finanças?',
      answers: [
        'Aprender a economizar mais',
        'Criar um orçamento mensal',
        'Controlar melhor meus gastos diários',
        'Descobrir formas sustentáveis de consumir',
      ],
    },
  ];

  for (const q of questions) {
    const createdQuestion = await prisma.question.create({
      data: { text: q.text },
    });

    await prisma.answer.createMany({
      data: q.answers.map((answerText) => ({
        text: answerText,
        questionId: createdQuestion.id,
      })),
    });
  }

  console.log('Seed realizado com sucesso 🚀');
}

main()
  .catch((e) => {
    console.error('Erro no seed:', e);
    process.exit(1);
  })
  // eslint-disable-next-line @typescript-eslint/no-misused-promises
  .finally(async () => {
    await prisma.$disconnect();
  });
