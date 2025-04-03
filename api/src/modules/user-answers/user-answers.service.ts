import { Injectable } from '@nestjs/common';
import { CreateUserAnswerDto } from './dto/create-user-answer.dto';
import { UserAnswerRepository } from 'src/shared/database/repositories/userAnswers.repositories';

@Injectable()
export class UserAnswersService {
  constructor(private readonly userAnswersRepo: UserAnswerRepository) {}

  create(userId: string, createUserAnswerDto: CreateUserAnswerDto) {
    const { answerId, questionId } = createUserAnswerDto;
    return this.userAnswersRepo.create({
      data: { userId, answerId, questionId },
    });
  }

  findOne(id: number) {
    return `This action returns a #${id} userAnswer`;
  }

  // update(id: number, updateUserAnswerDto: UpdateUserAnswerDto) {
  //   return `This action updates a #${id} userAnswer`;
  // }
}
