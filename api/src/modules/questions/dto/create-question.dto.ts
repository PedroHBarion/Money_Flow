import { IsNotEmpty, IsString, MaxLength } from 'class-validator';

export class CreateQuestionDto {
  @IsString()
  @IsNotEmpty()
  @MaxLength(200)
  text: string;
}
