import { Injectable } from '@nestjs/common';
import { CreateQuestionDto } from './dto/create-question.dto';
import { QuestionsRepository } from 'src/shared/database/repositories/questions.repositories';

@Injectable()
export class QuestionsService {
  constructor(private readonly questionsRepo: QuestionsRepository) {}

  create(createQuestionDto: CreateQuestionDto) {
    const { text } = createQuestionDto;

    return this.questionsRepo.create({ data: { text } });
  }

  findAll() {
    return this.questionsRepo.findMany({
      include: {
        answers: {
          select: { id: true, text: true },
        },
      },
    });
  }
}
