# 💸 Money Flow

Sistema de gestão financeira pessoal, com foco em consumo consciente e organização financeira. Desenvolvido como parte do Projeto Integrado da faculdade, alinhado ao ODS 12 (Consumo e Produção Responsáveis).

## 🎯 Objetivo

O **Money Flow** tem como objetivo auxiliar os usuários no controle das suas finanças pessoais, promovendo a responsabilidade no consumo, análise de gastos e definição de metas. O app permite cadastrar e visualizar despesas, extrair insights financeiros, definir metas de economia e até receber orientações de um consultor financeiro com IA.

## 🧩 Descrição da Solução

A solução é um aplicativo mobile multiplataforma (Flutter) com interface intuitiva, persistência de dados segura e testes completos. Entre os principais recursos estão:

- **Cadastro e edição de despesas**
- **Resumo de gastos por mês, semana e categoria**
- **Consultor financeiro com IA**
- **Definição de metas financeiras**
- **Visualização por gráficos de pizza**

## 🛠️ Tecnologias Utilizadas

### 🧱 Backend (API)
- **NestJS** (TypeScript)
- **PostgreSQL**
- **Prisma ORM**
- **JWT para autenticação**

### 📱 Frontend (App Flutter)
- **Flutter**
- **GetIt + ChangeNotifier**
- **flutter_secure_storage**
- **HttpClient nativo**
- **Gráficos com `fl_chart`**
- **Arquitetura MVC**
- **Testes (unitários, integração e widget) com Mockito**
- **Cobertura de testes documentada segundo IEEE 829**

## 🧪 Testes

Todos os fluxos principais foram testados com:
- **Testes Unitários**
- **Testes de Integração**
- **Testes de Widget**
- **Documentação de testes seguindo a norma IEEE 829**

## 🚀 Como Rodar o Projeto (API + App Flutter)

### Pré-requisitos

- Flutter SDK (versão latest de preferência)
- Dart
- Android Studio ou VSCode
- Emulador Android ou dispositivo físico

### 1. Baixar o projeto

Você pode clonar o repositório com o comando:

```bash
git clone https://github.com/seu-usuario/money-flow.git
```


### 2. Iniciar o Backend (API)

```bash
cd api
```

#### 📦 Instalar dependências

```bash
yarn            # ou: npm install
```

#### 🛠️ Criar banco de dados com as migrations

```bash
yarn prisma migrate dev
# ou:
npx prisma migrate dev
```

#### 🌱 Popular o banco com dados iniciais

```bash
yarn prisma db seed
# ou:
npx prisma db seed
```

#### 🔐 Criar arquivo `.env` dentro da pasta `api/` com:

```env
JWT_SECRET=sua_chave_jwt
DATABASE_URL=postgresql://usuario:senha@localhost:5432/nome_do_banco
```

#### ▶️ Rodar o servidor em modo de desenvolvimento

```bash
yarn start:dev   # ou: npm run start:dev
```

---

### 3. Iniciar o App Flutter

```bash
cd ../money_flow_app
```

#### 🔐 Criar o arquivo `.env` com:

```env
API_URL=http://localhost:3000      # ou a URL onde sua API está rodando
IA_API_KEY=sua_chave_openrouter_ai
```

#### 📦 Instalar dependências do Flutter

```bash
flutter pub get
```

#### ▶️ Executar o app no emulador ou dispositivo físico

```bash
flutter run
```

---

---

### 👥 Equipe

- Ana Tereza Rodrigues Magalhães — @anamagalhaesss(https://github.com/anamagalhaesss)
- Bruno Aparecido Pinheiro — @DevBrunoPi(https://github.com/DevBrunoPi)
- Luiz André Oliveira Almeida — @Luiz-1213(https://github.com/luiz-almeida-dev)
- Pedro Henrique Barion — @PedroHBarion(https://github.com/PedroHBarion)

---
