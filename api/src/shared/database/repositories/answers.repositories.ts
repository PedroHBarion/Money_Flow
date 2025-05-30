import { Injectable } from '@nestjs/common';
import { type Prisma } from '@prisma/client';
import { PrismaService } from '../prisma.service';

@Injectable()
export class AnswerRepository {
  constructor(private readonly prismaService: PrismaService) {}

  create(createDto: Prisma.AnswerCreateArgs) {
    return this.prismaService.answer.create(createDto);
  }

  findFirst(findFirstDto: Prisma.AnswerFindFirstArgs) {
    return this.prismaService.answer.findFirst(findFirstDto);
  }

  findMany<T extends Prisma.AnswerFindManyArgs>(
    findManyDto: Prisma.SelectSubset<T, Prisma.AnswerFindManyArgs>,
  ) {
    return this.prismaService.answer.findMany(findManyDto);
  }

  update(updateDto: Prisma.AnswerUpdateArgs) {
    return this.prismaService.answer.update(updateDto);
  }

  delete(deleteDto: Prisma.AnswerDeleteArgs) {
    return this.prismaService.answer.delete(deleteDto);
  }
}
