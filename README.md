# Academic Manager — Web

> Sistema web de gerenciamento de disciplinas acadêmicas, desenvolvido em **Flutter (Web)** com foco em Qualidade de Software e testes orientados a comportamento (BDD).

---

## Índice

- [Visão Geral](#-visão-geral)
- [Stack & Tecnologias](#-stack--tecnologias)
- [Arquitetura](#-arquitetura)
- [Funcionalidades](#-funcionalidades)
- [Pré-requisitos](#-pré-requisitos)
- [Instalação e Configuração](#-instalação-e-configuração)
- [Banco de Dados com Docker](#-banco-de-dados-com-docker)
- [Rodando a Aplicação](#-rodando-a-aplicação)
- [Testes](#-testes)
- [Estrutura de Pastas](#-estrutura-de-pastas)
- [Scripts de Referência Rápida](#-scripts-de-referência-rápida)

---

## Visão Geral

O **Academic Manager** é uma aplicação web single-page desenvolvida em Flutter para o gerenciamento completo de disciplinas em instituições de ensino. O projeto foi construído com ênfase em **boas práticas de engenharia de software**, cobrindo desde a arquitetura até a pirâmide de testes automatizados.

---

## Stack & Tecnologias

| Camada | Tecnologia |
|---|---|
| **Frontend** | Flutter Web (Dart `^3.11.3`) |
| **Banco de Dados** | PostgreSQL 15 |
| **Containerização** | Docker & Docker Compose |
| **Testes BDD** | `bdd_widget_test ^2.1.3` |
| **Geração de código** | `build_runner ^2.4.8` |
| **Internacionalização** | `intl ^0.19.0` |
| **HTTP Client** | `http ^1.2.1` |

---

## Arquitetura

O projeto adota dois padrões de projeto combinados para garantir **separação de responsabilidades** e **testabilidade**:

### MVVM — Model · View · ViewModel

```
View  ──────▶  ViewModel  ──────▶  Model
  (UI)          (Estado &           (Entidades
                 Lógica)            de Domínio)
```

- **View:** Widgets Flutter responsáveis exclusivamente pela renderização.
- **ViewModel:** Gerencia o estado da UI e a lógica de negócio, sem conhecer detalhes de infraestrutura.
- **Model:** Entidades puras do domínio acadêmico.

### Repository Pattern

```
ViewModel  ──▶  Repository (interface)
                    │
                    ├── InMemoryRepository  (testes / dev)
                    └── ApiRepository       (produção)
```

O repositório abstrai a fonte de dados, permitindo trocar entre dados em memória e uma API REST sem alterar nenhuma linha de UI ou ViewModel.

---

## Funcionalidades

### Gerenciamento de Disciplinas (CRUD completo)

| Operação | Descrição |
|---|---|
| **Criar** | Cadastro de nova disciplina com validação completa |
| **Listar** | Visualização de todas as disciplinas cadastradas |
| **Editar** | Atualização dos dados de uma disciplina existente |
| **Excluir** | Remoção de disciplina com confirmação |

### Campos obrigatórios por disciplina

- `Título` — nome da disciplina
- `Data de Início` — formatada via `intl`
- `Data de Término` — com validação de intervalo
- `Número de Vagas` — valor inteiro positivo
- `Summer Course` — flag booleana indicando se é disciplina de verão

---

## Pré-requisitos

Antes de começar, certifique-se de ter instalado em sua máquina:

| Ferramenta | Versão mínima | Verificar instalação |
|---|---|---|
| [Flutter SDK](https://flutter.dev/docs/get-started/install) | `3.x (stable)` | `flutter --version` |
| [Dart SDK](https://dart.dev/get-dart) | `^3.11.3` | `dart --version` |
| [Docker](https://docs.docker.com/get-docker/) | `24+` | `docker --version` |
| [Docker Compose](https://docs.docker.com/compose/) | `v2+` | `docker compose version` |



---

## Instalação e Configuração

### 1. Clone o repositório

```bash
git clone https://github.com/Marcos-Codfy/academic-manager.git
cd academic_web
```

### 2. Instale as dependências do Flutter

```bash
flutter pub get
```

### 3. Habilite o suporte à Web (caso ainda não esteja ativo)

```bash
flutter config --enable-web
```

### 4. Verifique se o ambiente está saudável

```bash
flutter doctor
```

---

## Banco de Dados com Docker

O banco de dados PostgreSQL é provisionado via Docker Compose, sem necessidade de instalação local.

### Subir o banco de dados

```bash
docker compose up -d
```

### Verificar se o container está rodando

```bash
docker compose ps
```

Você deve ver o container `academic_db` com status `healthy` ou `running`.

### Conectar ao banco (opcional — para inspeção manual)

```bash
docker exec -it academic_db psql -U admin -d academic_manager
```

| Parâmetro | Valor |
|---|---|
| **Host** | `localhost` |
| **Porta** | `5432` |
| **Usuário** | `admin` |
| **Senha** | `admin_password` |
| **Database** | `academic_manager` |

### Parar o banco de dados

```bash
docker compose down
```

### Parar e remover os dados (reset total)

```bash
docker compose down -v
```

---

## ▶️ Rodando a Aplicação

### Modo desenvolvimento (com hot reload)

```bash
flutter run -d chrome
```

### Build de produção (Web)

```bash
flutter build web
```

Os arquivos gerados estarão em `build/web/`. Para servi-los localmente:

```bash
cd build/web
python3 -m http.server 8080
# Acesse: http://localhost:8080
```

### Rodando em uma porta específica

```bash
flutter run -d chrome --web-port 3000
```

---

## Testes

O projeto utiliza **BDD (Behavior-Driven Development)** com cenários escritos em **Gherkin** (linguagem natural), localizados em `test/features/`.

### Gerar os arquivos de teste a partir dos `.feature`

Sempre que criar ou alterar um arquivo `.feature`, execute o `build_runner` para regenerar os stubs de teste:

```bash
dart run build_runner build
```

Para manter a geração contínua em modo watch durante o desenvolvimento:

```bash
dart run build_runner watch
```

### Executar todos os testes

```bash
flutter test
```

### Executar testes com relatório de cobertura

```bash
flutter test --coverage
```

O relatório de cobertura é gerado em `coverage/lcov.info`. Para visualizá-lo em HTML (requer `lcov`):

```bash
# Instalar lcov (Linux/macOS)
sudo apt install lcov     # Debian/Ubuntu
brew install lcov          # macOS

# Gerar o relatório HTML
genhtml coverage/lcov.info -o coverage/html

# Abrir no navegador
open coverage/html/index.html       # macOS
xdg-open coverage/html/index.html   # Linux
```

### Executar um arquivo de teste específico

```bash
flutter test test/features/nome_do_arquivo_test.dart
```

### Executar testes com output verbose

```bash
flutter test --reporter=expanded
```

---

## Estrutura de Pastas

```
academic_web/
├── lib/
│   ├── main.dart                  # Ponto de entrada da aplicação
│   ├── models/                    # Entidades do domínio
│   │   └── discipline.dart
│   ├── repositories/              # Contratos e implementações de acesso a dados
│   │   ├── discipline_repository.dart
│   │   └── in_memory_discipline_repository.dart
│   ├── viewmodels/                # Lógica de estado e negócio
│   │   └── discipline_viewmodel.dart
│   └── views/                     # Widgets de interface
│       ├── discipline_list_view.dart
│       └── discipline_form_view.dart
│
├── test/
│   └── features/                  # Cenários BDD em Gherkin
│       ├── create_discipline.feature
│       └── create_discipline_test.dart   # Gerado pelo build_runner
│
├── docker-compose.yml             # Configuração do PostgreSQL
├── pubspec.yaml                   # Dependências do projeto
└── analysis_options.yaml          # Regras de lint
```

---

## Scripts de Referência Rápida

```bash
# --- SETUP INICIAL ---
flutter pub get                          # Instalar dependências
flutter config --enable-web              # Habilitar suporte web

# --- BANCO DE DADOS ---
docker compose up -d                     # Subir PostgreSQL
docker compose down                      # Parar PostgreSQL
docker compose down -v                   # Reset total do banco

# --- DESENVOLVIMENTO ---
flutter run -d chrome                    # Rodar no Chrome
flutter run -d chrome --web-port 3000    # Rodar em porta específica

# --- BUILD ---
flutter build web                        # Build de produção

# --- TESTES ---
dart run build_runner build              # Gerar stubs dos .feature
dart run build_runner watch              # Geração contínua (modo watch)
flutter test                             # Rodar todos os testes
flutter test --coverage                  # Rodar com cobertura
flutter test --reporter=expanded         # Verbose output

# --- QUALIDADE ---
flutter analyze                          # Análise estática de código
flutter format .                         # Formatar código automaticamente
```

---

## Licença

Este projeto está sob a licença **MIT**. Consulte o arquivo `LICENSE` para mais detalhes.

---

<div align="center">
  Feito com ☕ e Flutter
</div>