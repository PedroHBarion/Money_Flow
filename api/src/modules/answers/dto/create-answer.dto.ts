import { IsNotEmpty, IsString, IsUUID } from 'class-validator';

export class CreateAnswerDto {
  @IsString()
  @IsNotEmpty()
  @IsUUID()
  questionId: string;

  @IsString()
  @IsNotEmpty()
  text: string;
}
