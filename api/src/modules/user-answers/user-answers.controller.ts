import { Controller, Post, Body, ValidationPipe } from '@nestjs/common';
import { UserAnswersService } from './user-answers.service';
import { ActiveUserId } from 'src/shared/decorators/ActiveUserId';
import { CreateUserAnswerDto } from './dto/create-user-answer.dto';

@Controller('user-answers')
export class UserAnswersController {
  constructor(private readonly userAnswersService: UserAnswersService) {}

  @Post()
  createMany(
    @ActiveUserId() userId: string,
    @Body(
      new ValidationPipe({
        whitelist: true,
        transform: true,
        forbidNonWhitelisted: true,
      }),
    )
    body: CreateUserAnswerDto[],
  ) {
    return this.userAnswersService.createMany(userId, body);
  }
}
