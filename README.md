# AdventureWorks Indicium — Projeto de Analytics Engineering

Este repositório contém a implementação do desafio de **Analytics Engineer** da Indicium, utilizando práticas do **Modern Analytics Stack** com **dbt** para modelagem de dados e preparação de camadas analíticas.

## 🎯 Objetivo do projeto

Construir uma plataforma analítica confiável para a Adventure Works, permitindo responder perguntas de negócio sobre:

- volume de pedidos e quantidades vendidas;
- faturamento e ticket médio por diferentes granularidades;
- desempenho por produto, cliente e localização;
- análise temporal (mês/ano);
- comportamento de vendas por motivo (ex.: *Promotion*).

Além de responder às perguntas analíticas, o projeto também prioriza:

- **qualidade e confiabilidade dos dados** (testes e validações);
- **rastreabilidade** da transformação dos dados;
- **documentação técnica** dos modelos analíticos.

---

## 🧱 Arquitetura de camadas

A modelagem segue uma arquitetura em camadas no dbt:

### 1) `sources` (origem)
Definição e documentação das tabelas brutas disponibilizadas no ambiente de dados (Databricks), com testes básicos de integridade.

### 2) `staging` (padronização)
Camada para limpeza e padronização inicial:
- renomeia colunas;
- padroniza tipos;
- remove ambiguidades de nomenclatura;
- mantém granularidade próxima da origem.

### 3) `intermediate` (regras de negócio)
Camada para:
- aplicar regras de negócio reutilizáveis;
- preparar joins e enriquecimentos;
- reduzir complexidade dos marts finais.

### 4) `marts` (consumo analítico)
Camada final com modelos dimensionais e métricas para BI:
- **fatos** com métricas de vendas/pedidos;
- **dimensões** (produto, cliente, localidade, calendário, etc.);
- tabelas prontas para responder às perguntas do desafio.

---

## 🗂️ Fontes de dados

As fontes são dados transacionais e cadastrais da Adventure Works, incluindo domínios como:

- pedidos e itens de pedidos;
- produtos e categorias;
- clientes;
- cartões/tipos de pagamento;
- motivos de venda;
- endereços (cidade, estado, país);
- status de pedidos;
- datas de venda.

> As tabelas de origem e seus campos estão documentados no projeto dbt via `sources` + `docs`.

---

## 📊 Principais modelos analíticos

A estrutura analítica foi desenhada para suportar as perguntas de negócio do desafio.

### Fatos (exemplo)
- **fct_sales** (ou equivalente): granularidade por item de pedido/venda, contendo:
  - número de pedidos;
  - quantidade comprada;
  - valor bruto, descontos e valor negociado;
  - chaves para produto, cliente, data, localização, motivo de venda, status e tipo de cartão.

### Dimensões (exemplo)
- **dim_product**
- **dim_customer**
- **dim_date**
- **dim_location** (cidade/estado/país)
- **dim_sales_reason**
- **dim_card_type**
- **dim_status**

### Métricas derivadas
- **Ticket médio** por período/localidade/produto:
  - `ticket_medio = (faturamento_bruto - descontos) / número_pedidos`

> Os nomes exatos dos modelos podem variar conforme a implementação no diretório `models/`.

---

## ✅ Qualidade de dados

O projeto inclui testes em dbt para garantir confiabilidade:

- testes em **sources** (ex.: `not_null`, `relationships`);
- testes de **chave primária** nas dimensões e fatos (unicidade e não nulidade);
- testes de consistência de dados e regras de negócio;
- documentação de tabelas e colunas nos marts.

---

## 🚀 Como executar o projeto

### Pré-requisitos
- Python 3.9+  
- dbt instalado (adapter compatível com Databricks)
- perfil configurado em `~/.dbt/profiles.yml` para o ambiente alvo

### 1) Instalar dependências do dbt
```bash
dbt deps
```

### 2) Validar conexão (opcional, recomendado)
```bash
dbt debug
```

### 3) Executar build completo (modelos + testes + snapshots/seeds quando aplicável)
```bash
dbt build
```

### 4) Gerar e visualizar documentação (opcional)
```bash
dbt docs generate
dbt docs serve
```

---

## 📁 Estrutura sugerida do repositório

```text
.
├── models/
│   ├── staging/
│   ├── intermediate/
│   └── marts/
├── tests/
├── macros/
├── seeds/
├── snapshots/
├── dbt_project.yml
└── README.md
```

---

## 🧠 Perguntas de negócio atendidas

Este projeto foi desenvolvido para responder, entre outras, às seguintes perguntas:

1. Número de pedidos, quantidade e valor total negociado por produto/cartão/motivo/data/cliente/status/cidade/estado/país.  
2. Produtos com maior ticket médio por mês/ano/cidade/estado/país.  
3. Top 10 clientes por valor total negociado com filtros analíticos.  
4. Top 5 cidades por valor total negociado com filtros analíticos.  
5. Evolução temporal (mês/ano) de pedidos, quantidade e valor negociado.  
6. Produto com maior quantidade vendida para o motivo de venda **Promotion**.

---

## 🛠️ Stack utilizada

- **dbt** — transformação e modelagem analítica  
- **Databricks** — data warehouse/lakehouse em nuvem  
- **Looker Studio / Data Studio** — visualização e dashboards
- https://datastudio.google.com/reporting/3357eb81-0ed7-4e14-a8ec-7c7a209676cd

---

## 👥 Público-alvo

- Time de Analytics Engineering  
- Stakeholders de negócio (diretoria, áreas comerciais e de inovação)  
- Time de BI e Analytics Consumers

---

