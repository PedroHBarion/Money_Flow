import { plainToInstance } from 'class-transformer';
import { IsNotEmpty, IsString, validateSync } from 'class-validator';

class Env {
  @IsString()
  @IsNotEmpty()
  dbURL: string;

  @IsString()
  @IsNotEmpty()
  jwtSecret: string;
}

export const env: Env = plainToInstance(Env, {
  jwtSecret: process.env.JWT_SECRET,
  dbURL: process.env.DATABASE_URL,
});

const errors = validateSync(env);

if (errors.length > 0) {
  throw new Error(JSON.stringify(errors, null, 3));
}
