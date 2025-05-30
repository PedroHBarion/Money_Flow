import { IsString, IsNotEmpty, IsEmail, MinLength } from 'class-validator';

export class SinginDto {
  @IsString()
  @IsNotEmpty()
  @IsEmail()
  email: string;

  @IsString()
  @IsNotEmpty()
  @MinLength(8)
  password: string;
}
