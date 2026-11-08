import Foundation

final class ToDoListCLI {

    private let viewModel: TaskListViewModel

    init(viewModel: TaskListViewModel = TaskListViewModel()) {
        self.viewModel = viewModel
    }

    // Executa o programa
    func run() {
        while true {
            mostrarMenu()

            print("Escolha uma opção: ", terminator: "")

            guard let entrada = readLine() else {
                print("\nEntrada encerrada.")
                return
            }

            let opcao = entrada.trimmingCharacters(
                in: .whitespacesAndNewlines
            )

            switch opcao {

            case "1":
                criarTarefa()

            case "2":
                listarTarefas()

            case "3":
                concluirTarefa()

            case "4":
                excluirTarefa()

            case "5":
                print("Até logo!")
                return

            default:
                print("Opção inválida. Tente novamente.")
            }
        }
    }

    // Exibe o menu principal
    private func mostrarMenu() {
        print("\n================================")
        print("          SPRINTMATE")
        print("================================")
        print()
        print("1. Criar tarefa")
        print("2. Listar tarefas")
        print("3. Concluir tarefa")
        print("4. Excluir tarefa")
        print("5. Sair")
        print()
    }

    // Cadastra uma nova tarefa
    
    private func criarTarefa() {
        var titulo: String

        while true {
            print("Título: ", terminator: "")

            guard let entrada = readLine() else {
                print("\nEntrada encerrada.")
                return
            }

            titulo = entrada.trimmingCharacters(
                in: .whitespacesAndNewlines
            )

            if titulo.isEmpty {
                print("Erro: o título não pode ficar vazio. Tente novamente.\n")
                continue
            }

            break
        }

        while true {
            print("Prioridade (1 - Baixa, 2 - Média, 3 - Alta): ", terminator: "")

            guard let entrada = readLine() else {
                print("\nEntrada encerrada.")
                return
            }

            guard let prioridade = Int(
                entrada.trimmingCharacters(in: .whitespacesAndNewlines)
            ) else {
                print("Erro: informe um número inteiro entre 1 e 3.\n")
                continue
            }

            let result = viewModel.addTask(
                title: titulo,
                priority: prioridade
            )

            switch result {
            case .success:
                print("Tarefa adicionada com sucesso!")
                return

            case .emptyTitle:
                print("Erro: o título não pode ficar vazio.")
                return

            case .invalidPriority:
                print("Erro: a prioridade deve ser 1, 2 ou 3. Tente novamente.\n")
            }
        }
    }

    // Exibe todas as tarefas
    private func listarTarefas() {
        let tarefas = viewModel.tasks

        guard !tarefas.isEmpty else {
            print("Nenhuma tarefa cadastrada.")
            return
        }

        print("\n--- SUAS TAREFAS ---")

        for (indice, tarefa) in tarefas.enumerated() {
            let status = tarefa.isCompleted ? "Concluída" : "Pendente"

            print(
                "\(indice + 1). \(tarefa.title) | " +
                "Prioridade: \(tarefa.priority) | " +
                "Status: \(status)"
            )
        }
    }

    // Marca uma tarefa como concluída
    private func concluirTarefa() {
        guard !viewModel.tasks.isEmpty else {
            print("Não há tarefas para concluir.")
            return
        }

        listarTarefas()

        guard let indice = solicitarIndiceDaTarefa() else {
            return
        }

        guard viewModel.completeTask(at: indice) else {
            print("Número inválido. Não existe uma tarefa nessa posição.")
            return
        }

        print("Tarefa concluída com sucesso!")
    }

    // Exclui uma tarefa
    private func excluirTarefa() {
        guard !viewModel.tasks.isEmpty else {
            print("Não há tarefas para excluir.")
            return
        }

        listarTarefas()

        guard let indice = solicitarIndiceDaTarefa() else {
            return
        }

        guard viewModel.deleteTask(at: indice) else {
            print("Número inválido. Não existe uma tarefa nessa posição.")
            return
        }

        print("Tarefa excluída com sucesso!")
    }

    // Solicita o número de uma tarefa
    private func solicitarIndiceDaTarefa() -> Int? {
        print("Digite o número da tarefa: ", terminator: "")

        guard let entrada = readLine(),
              let numero = Int(
                entrada.trimmingCharacters(in: .whitespacesAndNewlines)
              ),
              numero > 0 else {

            print("Índice inválido. Digite um número inteiro positivo.")
            return nil
        }

        return numero - 1
    }
}