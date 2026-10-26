# Exemplo de ABAP Offstack

Um projeto de exemplo demonstrando como usar o [abaplint](https://abaplint.org) e o [abap-transpiler](https://github.com/abaplint/transpiler) para executar **análise estática (linting) e testes unitários de ABAP off-stack** — sem a necessidade de um sistema SAP.

## Objetivo

Este projeto demonstra que as verificações de qualidade de código ABAP e os testes unitários podem ser executados inteiramente de forma local ou em uma esteira CI/CD, sem se conectar a um backend SAP.

* **Análise estática de código** via `abaplint`

* **Execução de testes unitários** via `abap_transpile` + Node.js

## Como Funciona

1. **Lint**: O `abaplint` faz o *parsing* e analisa os arquivos de código-fonte ABAP em `/src` com base nas regras definidas em `abaplint.jsonc`.

2. **Transpilar**: O `abap_transpile` converte as classes ABAP (incluindo classes de teste locais) para JavaScript.

3. **Executar**: O resultado transpilado é executado com o Node.js, rodando os testes unitários ABAP de forma *off-stack*.

## Desenvolvendo com Inteligência Artificial (IA)

O ecossistema *off-stack* facilita a integração com ferramentas de IA para acelerar o desenvolvimento ABAP:

* **Geração e Refatoração de Código**: Agentes e assistentes de IA podem gerar código ABAP, aplicar boas práticas (*Clean ABAP*) e ajustar a sintaxe instantaneamente.

* **Criação Automática de Testes Unitários**: A IA pode criar rapidamente cenários de teste ABAP Unit para cobrir regras de negócio antes da execução com o `abap-transpiler`.

* **Feedback em Tempo Real**: Usando a análise do `abaplint` em conjunto com a IA, é possível identificar e corrigir desvios de padronização, gargalos e erros diretamente no editor (ex.: VS Code), sem aguardar a compilação ou transporte no SAP.

## Guia Completo do Claude Code para Desenvolvedores ABAP

O **Claude Code** atua como um desenvolvedor sênior integrado ao seu ambiente (VS Code, JetBrains, terminal ou navegador), capaz de ler todo o repositório, executar comandos, analisar short dumps e gerar objetos ABAP/CDS completos com contexto.

### Onde o Claude Code se Encaixa no Ciclo de Desenvolvimento

| 

| **Fase** | **Como o Claude Ajuda** | 
| **Descobrir** | Entender código legado, rastrear cadeias de chamadas de FM e mapear *enhancements*. | 
| **Desenhar** | Rascunhar especificações funcionais, fazer engenharia reversa de BAPIs e desenhar hierarquias de CDS views. | 
| **Construir** | Escrever classes ABAP, gerar testes ABAP Unit, criar relatórios ALV e construir serviços OData. | 
| **Implantar** | Validar atribuições de ordens de transporte, checar bloqueios de objetos e gerar documentação de transporte. | 
| **Suporte** | Analisar short dumps (ST22), encontrar gargalos de performance e identificar falta de *authority-checks*. | 

### Primeiros Passos (Primeiros 10 Minutos)

1. **Instalar**:

   ```
   npm install -g @anthropic-ai/claude-code
   
   ```

2. **Inicializar**: Abra a pasta do seu projeto e execute o comando abaixo para criar a memória do projeto (`CLAUDE.md`):

   ```
   /init
   
   ```

3. **Configurar as Regras ABAP em `CLAUDE.md`**: Adicione padrões de nomes, regras de transporte e boas práticas.

4. **Primeiro Prompt**: Peça para o Claude explicar o código existente:

   ```
   Explain the purpose and flow of report Z_MM_PURCHASE_REPORT.
   Include: tables accessed, authority checks, and any deprecated patterns.
   
   ```

5. **Configurar Permissões**: Defina as permissões da equipe no arquivo `claude/settings.json`.

### Configuração da Memória do Projeto (`CLAUDE.md`)

O arquivo `CLAUDE.md` serve como um briefing lido pelo Claude no início de cada sessão.

### Comandos do Dia a Dia

#### Comandos Nativos (`Built-in Commands`)

| **Comando** | **O que faz** | **Quando usar** | 
| `/init` | Varre o código e cria a minuta do `CLAUDE.md` | Na primeira configuração do projeto | 
| `/context` | Mostra quanto da memória do Claude foi utilizada | Antes de carregar programas grandes ou após uso prolongado | 
| `/compact` | Libera memória resumindo a conversa até o momento | Quando o uso de memória atingir entre 60% e 70% | 
| `/clear` | Reseta a sessão (início limpo) | Ao alternar para uma tarefa completamente diferente | 
| `/model` | Alterna entre Sonnet, Opus e Haiku | Para alternar entre maior raciocínio (Opus) ou velocidade (Haiku) | 
| `/resume` | Retoma a última sessão | Ao iniciar o dia para continuar o trabalho anterior | 
| `/rewind` | Desfaz as últimas alterações feitas pelo Claude | Caso o Claude siga em uma direção incorreta | 

#### Comandos Personalizados (`Custom Slash Commands`)

Crie arquivos `.md` na pasta `.claude/commands/` para compartilhar instruções reutilizáveis com a equipe.

Exemplo: `.claude/commands/abap-review.md`

Outros comandos úteis que podem criados e configurados a sua vontade:

* `/transport-check`: Verifica se os objetos estão na ordem correta com todas as dependências.

* `/bapi-review`: Checa padrão de chamadas BAPI, tratamento da tabela `RETURN` e posição do `COMMIT WORK`.

* `/abap-unit`: Gera classe de teste ABAP Unit com *test doubles*.

* `/cds-review`: Revisa anotações, associações e nomenclatura de CDS Views.

* `/dump-analysis`: Analisa causas raízes de short dumps, correções e cenários de teste.

### Escolhendo o Modelo Certo (`/model`)

| **Modelo** | **Perfil** | **Melhor para** | 
| **Sonnet** (Padrão) | O profissional do dia a dia | Escrita de código, code reviews, depuração, testes unitários, CDS views. | 
| **Opus** | O pensador profundo | Arquitetura complexa, dumps difíceis, refatoração de múltiplos módulos. | 
| **Haiku** | O especialista em velocidade | Código de suporte (boilerplate), buscas rápidas, renomeação em massa. | 

### Modos de Execução (`Shift + Tab`)

* **Plan Mode** *(Default para código em produção)*: O Claude apresenta um plano detalhado e aguarda confirmação antes de alterar arquivos.

* **Auto Mode**: O Claude executa e cria arquivos sem pedir confirmação (ideal para novos testes ou novos arquivos do zero).

* **Step Mode**: Solicita autorização a cada ação individual (ideal para código crítico ou desconhecido).

* **Bash Mode**: Permite executar comandos no terminal (`abaplint`, `npm test`, `git`).

### Gerenciamento de Contexto e Memória

* **Abaixo de 60%**: Uso normal.

* **60% - 70%**: Recomenda-se executar `/compact`.

* **70% - 85%**: Risco de perda de atenção; execute `/compact`.

* **Acima de 85%**: Degradação alta; execute `/compact` ou `/clear` imediatamente.

*Dica*: Carregue arquivos específicos usando `@nome_do_arquivo` em vez de pastas inteiras.

### Controle de Permissões (`claude/settings.json`)

Configure os limites do que o Claude pode realizar salvando em `.claude/settings.json`:

### Uso de Subagentes (`Subagents`)

É possível executar múltiplos subagentes em paralelo para revisar um pacote de forma ampla e com foco especializado:

* `transport-analyst`: Verifica dependências de ordens de transporte.

* `dependency-mapper`: Mapeia listas de onde-usado (*where-used*).

* `security-reviewer`: Valida rotinas de verificação de autorização (`AUTHORITY-CHECK`).

* `test-assessor`: Mapeia lacunas de cobertura de testes unitários.

* `tech-debt-tracker`: Identifica códigos legados e desatualizados.

### Exemplos de Prompts Rápidos para ABAP

#### 1. Entender Código Legado

```
Explain the purpose and flow of report Z_MM_PURCHASE_REPORT.
Include: main control flow, key subroutines, database tables accessed, and any authority checks.

```

#### 2. Analisar Short Dump (ST22)

```
Analyse this short dump. Identify root cause, suggest a fix, and generate a test case to prevent it.
[Cole os detalhes do dump do ST22 aqui]

```

#### 3. Criar CDS View Hierárquica

```
Create a CDS view hierarchy for Sales Order analysis:
- Basic view: join VBAK + VBAP
- Composite view: add customer (KNA1) and material (MARA)
- Consumption view: with Fiori Elements annotations for List Report

```

#### 4. Criar Wrapper para BAPI

```
Generate a wrapper class ZCL_MM_PO_CREATE for BAPI_PO_CREATE1.
Include: error handling, COMMIT WORK logic, application logging, and an ABAP Unit test with test doubles for the BAPI call.

```

### Atalhos de Teclado e Comandos Rápidos

| **Tecla / Comando** | **Ação** | 
| `Shift + Tab` | Alterna entre os modos Plan / Auto / Step | 
| `#` | Adiciona uma nota rápida ao `CLAUDE.md` durante a sessão | 
| `!` | Executa um comando de shell diretamente | 
| `@filename` | Carrega o arquivo específico para o contexto | 
| `Esc` | Interrompe a resposta atual do Claude | 
| `Double-Esc` | Navega pelo histórico de prompts | 
| `Ctrl + R` | Exibe os logs internos de raciocínio do Claude | 

## Estrutura do Projeto

```
src/                     # Arquivos de código-fonte ABAP
.claude/                 # Permissões e comandos customizados do Claude Code
.claude/commands/        # Comandos reutilizáveis (ex.: /abap-review)
CLAUDE.md                # Memória e diretrizes do projeto para a IA
abaplint.jsonc           # Configuração do abaplint (regras, versão de sintaxe, caminhos)
package.json             # Dependências do Node.js e scripts

```

## Pré-requisitos

* [Node.js](https://nodejs.org) (LTS recomendado)

## Instalação

```
npm install

```

## Scripts

| **Comando** | **Descrição** | 
| `npm run lint` | Executa a análise estática de código com o abaplint | 
| `npm run unit` | Transpila o ABAP e executa os testes unitários via Node.js | 
| `npm test` | Executa o lint + testes unitários | 

## CI/CD

O fluxo de trabalho `.github/workflows/qualitychecks.yml` executa o `abaplint` automaticamente a cada *push* e *pull request*.

## Referências

* [abaplint](https://abaplint.org)

* [abaplint/transpiler](https://github.com/abaplint/transpiler)

* [open-abap](https://github.com/open-abap)

* [Claude Code Guide for ABAP Developers](https://claude.ai)