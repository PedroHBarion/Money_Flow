import { Controller, Get } from '@nestjs/common';
import { UsersService } from './users.service';
import { ActiveUserId } from 'src/shared/decorators/ActiveUserId';

@Controller('users')
export class UsersController {
  constructor(private readonly usersService: UsersService) {}

  @Get('/me')

  // Get current user by acess token
  me(@ActiveUserId() userId: string) {
    return this.usersService.getUserById(userId);
  }
}
