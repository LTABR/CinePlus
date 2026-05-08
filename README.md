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
| JavaX Servlet API / JSP | Camada web |
| MySQL | Banco de dados relacional |

## Arquitetura e padrões

- **Front Controller** — servlet único [`Controller`](src/java/controller/Controller.java) mapeado em `/controle`, que despacha para comandos via parâmetros `model` e `op`.
- **Command** — cada operação (por exemplo `ClienteCadastrar`, `FilmeConsultarTodos`) implementa [`ICommand`](src/java/command/ICommand.java) em pacotes por domínio (`command.cliente`, `command.filme`, …).
- **DAO** — acesso a dados em [`dao`](src/java/dao).
- **MVC** — segmentação entre entidades e manipulação de dados e abstração de lógicas de negócio da interface de usuário;
- **Strategy** — alteração de ação sem afetar seu uso ([`IPagamento`](src/java/model/pagamento/IPagamento.java));
- **Builder** — classes Builder internos que simplificam o instanciamento de classes de modelo ([`PagamentoBuilder`](src/java/model/pagamento/PagamentoBuilder.java)).

Fluxo típico de requisição: navegador → `/controle?model=Cliente&op=Cadastrar` → instanciação reflexa do comando → JSP de destino.

## Dependências

- [JDK 24](https://openjdk.org/) (ou ajuste `maven.compiler.*` no `pom.xml` se usar outra versão LTS).
- [Maven 3.x](https://maven.apache.org/).
- [MySQL](https://dev.mysql.com/) em execução (porta padrão `3306`).
- Servidor de aplicação **Servlet 4** Apache Tomcat 9.


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
- **`op`** — ação (por exemplo `Cadastrar`, `ConsultarTodos`, `Atualizar`, `Deletar`, `ConsultarId` ou `ConsultarCadastro` quando existir).

## Estrutura do repositório (resumo)

```
CinePlus/
├── pom.xml
├── src/java/          # controller, commands, DAO, model, util
└── web/view           # JSP, CSS, WEB-INF, index.html
```

## Licença

Uso educacional. Todos os direitos reservados para os autores.


## VERSÃO ALTERNATIVA
# 🎬 CinePlus

Sistema web para gestão de cinema: cadastro de clientes, filmes, salas, sessões e venda de ingressos com registro de pagamentos.  
Projeto acadêmico desenvolvido na disciplina de **Padrões de Projetos**, aplicando padrões estruturais e comportamentais em uma aplicação Java EE (Servlet + JSP + MySQL).

---

## ✨ Funcionalidades

- 👤 **Clientes** — cadastro, listagem, edição e exclusão.  
- 🎞️ **Filmes** — cadastro e vínculo com sessões.  
- 🏟️ **Salas** — capacidade e associação com sessões.  
- 📅 **Sessões** — data/hora, filme associado e consulta de vagas disponíveis.  
- 🎟️ **Ingressos** — emissão vinculando cliente, sessão e forma de pagamento.  
- 💳 **Pagamentos** — abstração por interface e implementações (cartão, dinheiro, PIX etc.), com uso de **Builder** para montagem dos objetos de pagamento.

---

## 🛠️ Stack tecnológica

| Tecnologia | Uso |
|------------|-----|
| Java 24 | Linguagem principal |
| Maven | Build e empacotamento WAR |
| JavaX Servlet API / JSP | Camada web |
| MySQL | Banco de dados relacional |

---

## 🏗️ Arquitetura e padrões

- **Front Controller** — servlet único `Controller` mapeado em `/controle`.  
- **Command** — cada operação implementa `ICommand`, organizada por domínio.  
- **DAO** — acesso a dados em `dao`.  
- **MVC** — segmentação entre entidades e manipulação de dados e abstração de lógicas de negócio da interface de usuário;
- **Strategy** — alteração de ação sem afetar seu uso ([`IPagamento`](src/java/model/pagamento/IPagamento.java));
- **Builder** — classes Builder internos que simplificam o instanciamento de classes de modelo ([`PagamentoBuilder`](src/java/model/pagamento/PagamentoBuilder.java)).

Fluxo típico: navegador → `/controle?model=Cliente&op=Cadastrar` → instanciação reflexiva do comando → JSP de destino.

---

## 📋 Dependências

- [JDK 24](https://openjdk.org/) (ou ajuste no `pom.xml`).  
- [Maven 3.x](https://maven.apache.org/).  
- [MySQL](https://dev.mysql.com/) rodando na porta padrão `3306`.  
- Servidor de aplicação compatível com **Servlet 4** (ex.: Tomcat 9).

---

## 🗄️ Banco de dados

1. Execute o script `sql/cineplus_schema.sql` no MySQL Workbench.  
2. Ajuste credenciais em `FabricaConexao.java` se necessário:  
   - URL: `jdbc:mysql://localhost:3306/db_cineplus`  
   - Usuário: `root`  
   - Senha: *(vazia por padrão)*  

---

## 🚀 Build e deploy

No diretório do projeto:

```bash
mvn clean package
