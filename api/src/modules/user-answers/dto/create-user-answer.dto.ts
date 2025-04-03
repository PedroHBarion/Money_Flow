import { IsNotEmpty, IsString, IsUUID } from 'class-validator';

export class CreateUserAnswerDto {
  @IsString()
  @IsNotEmpty()
  @IsUUID()
  questionId: string;

  @IsString()
  @IsNotEmpty()
  @IsUUID()
  answerId: string;
}
