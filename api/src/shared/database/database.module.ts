import { Global, Module } from '@nestjs/common';
import { PrismaService } from './prisma.service';
import { UsersRepository } from './repositories/users.repositories';
import { CategoriesRepository } from './repositories/categories.repositories';
import { BankAccountsRepository } from './repositories/bankAccounts.repositories';
import { TransactionRepository } from './repositories/transactions.repositories';
import { QuestionsRepository } from './repositories/questions.repositories';
import { AnswerRepository } from './repositories/answers.repositories';
import { UserAnswerRepository } from './repositories/userAnswers.repositories';

@Global()
@Module({
  providers: [
    PrismaService,
    UsersRepository,
    CategoriesRepository,
    BankAccountsRepository,
    TransactionRepository,
    QuestionsRepository,
    AnswerRepository,
    UserAnswerRepository,
  ],
  exports: [
    UsersRepository,
    CategoriesRepository,
    BankAccountsRepository,
    TransactionRepository,
    QuestionsRepository,
    AnswerRepository,
    UserAnswerRepository,
  ],
})
export class DatabaseModule {}
