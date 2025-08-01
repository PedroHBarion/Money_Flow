import { Injectable } from '@nestjs/common';
import { TransactionType } from '@prisma/client';
import { CategoriesRepository } from 'src/shared/database/repositories/categories.repositories';

@Injectable()
export class CategoriesService {
  constructor(private readonly categoriesRepo: CategoriesRepository) {}
  findAllByUserId(userId: string, type?: TransactionType) {
    return this.categoriesRepo.findMany({
      where: { userId, type },
    });
  }
}
