import { Injectable } from '@nestjs/common';
import { type Prisma } from '@prisma/client';
import { PrismaService } from '../prisma.service';

@Injectable()
export class UserAnswerRepository {
  constructor(private readonly prismaService: PrismaService) {}

  create(createDto: Prisma.UserAnswerCreateArgs) {
    return this.prismaService.userAnswer.create(createDto);
  }

  findFirst(findFirstDto: Prisma.UserAnswerFindFirstArgs) {
    return this.prismaService.userAnswer.findFirst(findFirstDto);
  }

  findMany<T extends Prisma.UserAnswerFindManyArgs>(
    findManyDto: Prisma.SelectSubset<T, Prisma.UserAnswerFindManyArgs>,
  ) {
    return this.prismaService.userAnswer.findMany(findManyDto);
  }

  update(updateDto: Prisma.UserAnswerUpdateArgs) {
    return this.prismaService.userAnswer.update(updateDto);
  }

  delete(deleteDto: Prisma.UserAnswerDeleteArgs) {
    return this.prismaService.userAnswer.delete(deleteDto);
  }
}
