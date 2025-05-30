import { Injectable } from '@nestjs/common';
import { CreateUserAnswerDto } from './dto/create-user-answer.dto';
import { UserAnswerRepository } from 'src/shared/database/repositories/userAnswers.repositories';

@Injectable()
export class UserAnswersService {
  constructor(private readonly userAnswersRepo: UserAnswerRepository) {}

  createMany(userId: string, answers: CreateUserAnswerDto[]) {
    return this.userAnswersRepo.createMany({
      data: answers.map((a) => ({
        questionId: a.questionId,
        answerId: a.answerId,
        userId,
      })),
      skipDuplicates: true,
    });
  }
}
