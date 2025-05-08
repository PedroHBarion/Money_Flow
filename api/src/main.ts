import 'dotenv/config';

import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { ValidationPipe } from '@nestjs/common';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  app.useGlobalPipes(new ValidationPipe());
  // arrumar para a url no deploy
  app.enableCors({
    origin: '*',
  });

  await app.listen(process.env.PORT ?? 3000);
}
bootstrap();
