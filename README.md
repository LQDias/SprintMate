# ToDoList

**Gerenciador de tarefas desenvolvido em Swift**, com persistência local em JSON, integração com API REST e testes automatizados.

O ToDoList é um projeto desenvolvido para praticar conceitos de desenvolvimento de software utilizando Swift, aplicando organização em camadas, orientação a objetos, injeção de dependência e programação assíncrona.

## Funcionalidades

- Criar tarefas com título e prioridade.
- Listar tarefas cadastradas e seus respectivos status.
- Marcar tarefas como concluídas.
- Excluir tarefas.
- Validar títulos e prioridades.
- Salvar e recuperar tarefas utilizando arquivos JSON.
- Consultar tarefas externas por meio de uma API REST.

## Tecnologias utilizadas

- **Swift 6.4.2** — linguagem de programação.
- **Foundation** — manipulação de arquivos, JSON e requisições HTTP.
- **URLSession** — comunicação com API REST.
- **async/await** — programação assíncrona.
- **Swift Testing** — testes automatizados.
- **Swift Package Manager** — gerenciamento e estruturação do projeto.
- **Git e GitHub** — versionamento de código.
- **GitHub Actions** — integração contínua (CI).

## Arquitetura

O projeto utiliza uma organização inspirada no padrão MVVM, separando responsabilidades entre interface, gerenciamento de estado e regras de negócio.

```text
Sources/ToDo/
├── ToDoList.swift
├── TaskManager.swift
├── TaskListViewModel.swift
├── ToDoListCLI.swift
├── TaskStorage.swift
├── RemoteTask.swift
├── TaskAPIService.swift
└── main.swift
```

### Principais componentes

| Componente | Responsabilidade |
|---|---|
| ToDoList | Modelo que representa uma tarefa. |
| TaskManager | Gerencia as operações e regras de negócio. |
| TaskListViewModel | Intermediário entre a interface e o gerenciador. |
| ToDoListCLI | Interface de interação pelo terminal. |
| TaskStorage | Persistência local utilizando JSON. |
| TaskStorageProtocol | Abstração para operações de armazenamento. |
| RemoteTask | Modelo dos dados recebidos da API. |
| TaskAPIService | Responsável pelas requisições HTTP. |

O armazenamento utiliza um protocolo, permitindo substituir a implementação de persistência sem modificar as regras de negócio do `TaskManager`.

## API REST

O projeto utiliza a [JSONPlaceholder](https://jsonplaceholder.typicode.com/) para demonstrar a comunicação com serviços externos.

Endpoint utilizado:

```text
GET https://jsonplaceholder.typicode.com/todos/1
```

A resposta JSON é convertida para o modelo `RemoteTask` utilizando `Codable`.

A comunicação é realizada com `URLSession` e `async/await`, incluindo verificação da resposta HTTP e tratamento de erros.

## Testes automatizados

O projeto utiliza o framework Swift Testing para verificar o comportamento das funcionalidades.

Atualmente, são **15 testes automatizados**, cobrindo:

- Validação na criação de tarefas.
- Conclusão e exclusão de tarefas.
- Tratamento de índices inválidos.
- Persistência e recuperação de dados.
- Comportamento do ViewModel.
- Conversão de JSON em objetos Swift.
- Tratamento de JSON inválido.

## Integração contínua (CI)

O projeto utiliza GitHub Actions para automatizar a compilação e a execução dos testes.

O workflow é executado em um ambiente macOS quando há atualizações na branch `main` ou abertura de Pull Requests direcionados a ela.

As etapas incluem:

1. Preparação do ambiente e instalação do Swift.
2. Compilação do projeto com `swift build`.
3. Execução dos testes com `swift test`.

**Status:** CI configurado e execução validada com sucesso.

## Como executar

### Pré-requisitos

- Swift 6.4.2 ou compatível com a versão mínima definida no `Package.swift`.
- Git.

### Clonar o repositório

```bash
git clone https://github.com/LQDias/ToDoList.git
cd ToDoList
```

### Compilar o projeto

```bash
swift build
```

### Executar

```bash
swift run
```

### Executar os testes

```bash
swift test
```
