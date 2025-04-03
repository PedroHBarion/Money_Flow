import { PartialType } from '@nestjs/mapped-types';
import { CreateUserAnswerDto } from './create-user-answer.dto';

export class UpdateUserAnswerDto extends PartialType(CreateUserAnswerDto) {}
