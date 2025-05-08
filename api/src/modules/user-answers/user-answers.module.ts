import { Module } from '@nestjs/common';
import { UserAnswersService } from './user-answers.service';
import { UserAnswersController } from './user-answers.controller';

@Module({
  controllers: [UserAnswersController],
  providers: [UserAnswersService],
})
export class UserAnswersModule {}
