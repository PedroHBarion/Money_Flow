import { Injectable, NotFoundException } from '@nestjs/common';
import { TransactionRepository } from 'src/shared/database/repositories/transactions.repositories';

@Injectable()
export class ValidateTransactionOwnershipService {
  constructor(private readonly transactionRepo: TransactionRepository) {}

  async validate(userId: string, transactionId: string) {
    const isOwner = await this.transactionRepo.findFirst({
      where: { id: transactionId, userId },
    });

    if (!isOwner) {
      throw new NotFoundException('Transaction not found');
    }
  }
}
