import { Injectable } from '@nestjs/common';
import { CreateAnswerDto } from './dto/create-answer.dto';
import { AnswerRepository } from 'src/shared/database/repositories/answers.repositories';

@Injectable()
export class AnswersService {
  constructor(private readonly anwserRepo: AnswerRepository) {}

  create(createAnswerDto: CreateAnswerDto) {
    const { questionId, text } = createAnswerDto;
    return this.anwserRepo.create({ data: { text, questionId } });
  }
}
