import { Controller, Get, Post, Body, Param } from '@nestjs/common';
import { UserAnswersService } from './user-answers.service';
import { CreateUserAnswerDto } from './dto/create-user-answer.dto';
import { ActiveUserId } from 'src/shared/decorators/ActiveUserId';

@Controller('user-answers')
export class UserAnswersController {
  constructor(private readonly userAnswersService: UserAnswersService) {}

  @Post()
  create(
    @ActiveUserId() userId: string,
    @Body() createUserAnswerDto: CreateUserAnswerDto,
  ) {
    return this.userAnswersService.create(userId, createUserAnswerDto);
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.userAnswersService.findOne(+id);
  }
}
