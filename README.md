# CinePlus

Sistema web para gestão de cinema: cadastro de clientes, filmes, salas, sessões e venda de ingressos com registro de pagamentos. Projeto acadêmico desenvolvido no contexto da disciplina de **Padrões de Projeto**, aplicando padrões estruturais e comportamentais em uma aplicação Java EE (Servlet + JSP + MySQL).

## Funcionalidades

- **Clientes** — cadastro, listagem, edição e exclusão.
- **Filmes** — cadastro e relacionamento com sessões.
- **Salas** — capacidade e vínculo com sessões (`SessoesSala`).
- **Sessões** — data/hora, filme associado e consulta com vagas disponíveis.
- **Ingressos** — emissão vinculando cliente, sessão e forma de pagamento.
- **Pagamentos** — abstração por interface e implementações (cartão, dinheiro, PIX etc.), com **Builder** para montagem dos objetos de pagamento.

## Stack tecnológica

| Tecnologia | Uso |
|------------|-----|
| Java 24 | Linguagem |
| Maven | Build e empacotamento WAR |
| Jakarta Servlet / JSP | Camada web |
| MySQL | Banco de dados relacional |

## Arquitetura e padrões

- **Front Controller** — servlet único [`Controller`](src/java/controller/Controller.java) mapeado em `/controle`, que despacha para comandos via parâmetros `model` e `op`.
- **Command** — cada operação (por exemplo `ClienteCadastrar`, `FilmeConsultarTodos`) implementa [`ICommand`](src/java/command/ICommand.java) em pacotes por domínio (`command.cliente`, `command.filme`, …).
- **DAO** — acesso a dados em [`dao`](src/java/dao).
- **Model** — entidades e regras; pagamentos com **Strategy** ([`IPagamento`](src/java/model/pagamento/IPagamento.java)) e **Builder** ([`PagamentoBuilder`](src/java/model/pagamento/PagamentoBuilder.java)).

Fluxo típico de requisição: navegador → `/controle?model=Cliente&op=Cadastrar` → instanciação reflexa do comando → JSP de destino.

## Pré-requisitos

- [JDK 24](https://openjdk.org/) (ou ajuste `maven.compiler.*` no `pom.xml` se usar outra versão LTS).
- [Maven 3.x](https://maven.apache.org/).
- [MySQL](https://dev.mysql.com/) em execução (porta padrão `3306`).
- Servidor de aplicação **Servlet 4** (por exemplo Apache Tomcat 9+ ou compatível).


## Build e deploy

No diretório do projeto (onde está o `pom.xml`):

```bash
mvn clean package
```

O artefato gerado é `target/CinePlus.war`. Copie-o para o diretório `webapps` do Tomcat (ou faça o deploy pela interface de administração do servidor).

## Como acessar

Após o deploy com contexto `/CinePlus`:

- URL base: `http://localhost:8080/CinePlus/`
- O [`index.html`](web/index.html) redireciona para `/CinePlus/controle` (Front Controller).

Parâmetros usados pela controller:

- **`model`** — nome da entidade (`Cliente`, `Filme`, `Ingresso`, `Sala`, `Sessao`).
- **`op`** — ação (por exemplo `Cadastrar`, `ConsultarTodos`, `Atualizar`, `Deletar`, `ConsultarId`, `ConsultarCadastro` quando existir).

## Estrutura do repositório (resumo)

```
CinePlus/
├── pom.xml
├── src/java/          # Controller, commands, DAO, model, util
└── web/               # JSP, CSS, WEB-INF, index.html
```

## Licença

Uso educacional. Ajuste a licença conforme a política da sua instituição ou equipe.
