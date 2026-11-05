import Foundation

final class SprintMateCLI {

    private let taskManager: TaskManager

    init(taskManager: TaskManager = TaskManager()) {
        self.taskManager = taskManager
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
        print("Título: ", terminator: "")

        guard let titulo = readLine()?.trimmingCharacters(
            in: .whitespacesAndNewlines
        ), !titulo.isEmpty else {
            print("O título não pode ficar vazio.")
            return
        }

        print("Prioridade (número inteiro positivo): ", terminator: "")

        guard let entradaPrioridade = readLine()?.trimmingCharacters(
            in: .whitespacesAndNewlines
        ),
        let prioridade = Int(entradaPrioridade),
        prioridade > 0 else {
            print("Prioridade inválida. Informe um número inteiro positivo.")
            return
        }

        guard taskManager.addTask(
            title: titulo,
            priority: prioridade
        ) else {
            print("Não foi possível cadastrar a tarefa.")
            return
        }

        print("Tarefa criada com sucesso!")
    }

    // Exibe todas as tarefas
    private func listarTarefas() {
        let tarefas = taskManager.tasks

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
        guard !taskManager.tasks.isEmpty else {
            print("Não há tarefas para concluir.")
            return
        }

        listarTarefas()

        guard let indice = solicitarIndiceDaTarefa() else {
            return
        }

        guard taskManager.completeTask(at: indice) else {
            print("Número inválido. Não existe uma tarefa nessa posição.")
            return
        }

        print("Tarefa concluída com sucesso!")
    }

    // Exclui uma tarefa
    private func excluirTarefa() {
        guard !taskManager.tasks.isEmpty else {
            print("Não há tarefas para excluir.")
            return
        }

        listarTarefas()

        guard let indice = solicitarIndiceDaTarefa() else {
            return
        }

        guard taskManager.deleteTask(at: indice) else {
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