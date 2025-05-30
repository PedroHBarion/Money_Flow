import { Injectable } from '@nestjs/common';
import { type Prisma } from '@prisma/client';
import { PrismaService } from '../prisma.service';

@Injectable()
export class UserAnswerRepository {
  constructor(private readonly prismaService: PrismaService) {}

  createMany(createDto: Prisma.UserAnswerCreateManyArgs) {
    return this.prismaService.userAnswer.createMany(createDto);
  }

  findFirst(findFirstDto: Prisma.UserAnswerFindFirstArgs) {
    return this.prismaService.userAnswer.findFirst(findFirstDto);
  }

  findMany<T extends Prisma.UserAnswerFindManyArgs>(
    findManyDto: Prisma.SelectSubset<T, Prisma.UserAnswerFindManyArgs>,
  ) {
    return this.prismaService.userAnswer.findMany(findManyDto);
  }
}
