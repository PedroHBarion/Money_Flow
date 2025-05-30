import {
  ConflictException,
  Injectable,
  UnauthorizedException,
} from '@nestjs/common';
import { SinginDto } from './dto/signin.dto';
import { UsersRepository } from 'src/shared/database/repositories/users.repositories';
import { compare, hash } from 'bcryptjs';
import { SignupDto } from './dto/signup.dto';

import { JwtService } from '@nestjs/jwt';

@Injectable()
export class AuthService {
  constructor(
    private readonly usersRepo: UsersRepository,
    private readonly jwtService: JwtService,
  ) {}

  async signin(singinDto: SinginDto) {
    const { email, password } = singinDto;

    const user = await this.usersRepo.findUnique({
      where: { email: email },
    });

    if (!user) {
      throw new UnauthorizedException('Invalid credentials');
    }

    const isPasswordValid = await compare(password, user.password);

    if (!isPasswordValid) {
      throw new UnauthorizedException('Invalid credentials');
    }

    const accessToken = await this.generateAcessToken(user.id);
    return { accessToken };
  }

  async signup(signupDto: SignupDto) {
    const { name, email, password } = signupDto;

    const emailTaken = await this.usersRepo.findUnique({
      where: { email },
      select: { id: true },
    });

    const hashedPassword = await hash(password, 10);

    if (emailTaken) {
      throw new ConflictException('This email in already in use');
    }

    const user = await this.usersRepo.create({
      data: {
        name,
        email,
        password: hashedPassword,
        categories: {
          createMany: {
            data: [
              // Income
              {
                name: 'Salário',
                icon: 'salary',
                type: 'INCOME',
                color: '#2B8A3E',
              },
              {
                name: 'Freelance',
                icon: 'freelance',
                type: 'INCOME',
                color: '#2B8A3E',
              },
              {
                name: 'Outro',
                icon: 'other',
                type: 'INCOME',
                color: '#2B8A3E',
              },
              // Expense
              { name: 'Casa', icon: 'home', type: 'EXPENSE', color: '#F06595' },
              {
                name: 'Alimentação',
                icon: 'food',
                type: 'EXPENSE',
                color: '#FF6B6B',
              },
              {
                name: 'Educação',
                icon: 'education',
                type: 'EXPENSE',
                color: '#CC5DE8',
              },
              {
                name: 'Lazer',
                icon: 'fun',
                type: 'EXPENSE',
                color: ' #845EF7',
              },
              {
                name: 'Mercado',
                icon: 'grocery',
                type: 'EXPENSE',
                color: '#5C7CFA',
              },
              {
                name: 'Roupas',
                icon: 'clothes',
                type: 'EXPENSE',
                color: '#339AF0',
              },
              {
                name: 'Transporte',
                icon: 'transport',
                type: 'EXPENSE',
                color: '#FCC419',
              },
              {
                name: 'Viagem',
                icon: 'travel',
                type: 'EXPENSE',
                color: '#FF922B',
              },
              {
                name: 'Outro',
                icon: 'other',
                type: 'EXPENSE',
                color: '#C92A2A',
              },
            ],
          },
        },
      },
    });

    const accessToken = await this.generateAcessToken(user.id);
    return { accessToken };
  }

  private async generateAcessToken(userId: string) {
    return this.jwtService.signAsync({ sub: userId });
  }
}
