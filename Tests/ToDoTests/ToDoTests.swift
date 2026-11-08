import Testing
import Foundation
@testable import ToDo

// Rejeitar tarefa com título vazio
@Test
func testAddTaskWithEmptyTitle() {
    let manager = TaskManager(storage: MockTaskStorage())

    let result = manager.addTask(
        title: "",
        priority: 2
    )

    #expect(result == .emptyTitle)
    #expect(manager.tasks.isEmpty)
}

// Concluir tarefa com índice válido
@Test
func testCompleteTask() {
    let manager = TaskManager(storage: MockTaskStorage())

    manager.addTask(
        title: "Estudar Swift",
        priority: 2
    )

    let result = manager.completeTask(at: 0)

    #expect(result == true)
    #expect(manager.tasks[0].isCompleted == true)
}

// Concluir tarefa com índice inválido
@Test
func testCompleteTaskWithInvalidIndex() {
    let manager = TaskManager(storage: MockTaskStorage())

    let result = manager.completeTask(at: 0)

    #expect(result == false)
    #expect(manager.tasks.isEmpty)
}

// Adicionar tarefa com título válido
@Test
func testAddTask() {
    let manager = TaskManager(storage: MockTaskStorage())

    let result = manager.addTask(
        title: "Estudar Swift",
        priority: 2
    )

    #expect(result == .success)
    #expect(manager.tasks.count == 1)
    #expect(manager.tasks[0].title == "Estudar Swift")
    #expect(manager.tasks[0].priority == 2)
    #expect(manager.tasks[0].isCompleted == false)
}

// Deletar tarefa com índice válido
@Test
func testDeleteTaskKeepsOtherTasks() {
    let manager = TaskManager(storage: MockTaskStorage())

    manager.addTask(title: "Estudar Swift", priority: 1)
    manager.addTask(title: "Estudar Git", priority: 2)
    manager.addTask(title: "Estudar APIs", priority: 3)

    let result = manager.deleteTask(at: 1)

    #expect(result == true)
    #expect(manager.tasks.count == 2)
    #expect(manager.tasks[0].title == "Estudar Swift")
    #expect(manager.tasks[1].title == "Estudar APIs")
}

// Rejeitar tarefa com prioridade inválida
@Test
func testAddTaskWithInvalidPriority() {
    let manager = TaskManager(storage: MockTaskStorage())

    let result = manager.addTask(
        title: "Estudar Swift",
        priority: 0
    )

    #expect(result == .invalidPriority)
    #expect(manager.tasks.isEmpty)
}

// Deletar tarefa com índice inválido
@Test
func testDeleteTaskWithInvalidIndex() {
    let manager = TaskManager(storage: MockTaskStorage())

    manager.addTask(title: "Estudar Swift", priority: 1)
    manager.addTask(title: "Estudar Git", priority: 2)

    let result = manager.deleteTask(at: 5)

    #expect(result == false)
    #expect(manager.tasks.count == 2)
    #expect(manager.tasks[0].title == "Estudar Swift")
    #expect(manager.tasks[1].title == "Estudar Git")
}

// Salvar e recuperar tarefas de um arquivo JSON
@Test
func testSaveAndLoadTasks() {
    let directory = FileManager.default.temporaryDirectory
        .appendingPathComponent(UUID().uuidString)

    let fileURL = directory.appendingPathComponent("tasks.json")

    defer {
        try? FileManager.default.removeItem(at: directory)
    }

    let storage = TaskStorage(fileURL: fileURL)

    let tasks = [
        ToDoList(title: "Estudar Swift", priority: 2),
        ToDoList(title: "Revisar SQL", priority: 1)
    ]

    storage.save(tasks)

    let loadedTasks = storage.load()

    #expect(loadedTasks.count == 2)
    #expect(loadedTasks[0].title == "Estudar Swift")
    #expect(loadedTasks[1].title == "Revisar SQL")
    #expect(loadedTasks[0].priority == 2)
}

// Carregar quando o arquivo ainda não existe
@Test
func testLoadWithoutExistingFile() {
    let directory = FileManager.default.temporaryDirectory
        .appendingPathComponent(UUID().uuidString)

    let fileURL = directory.appendingPathComponent("tasks.json")

    defer {
        try? FileManager.default.removeItem(at: directory)
    }

    let storage = TaskStorage(fileURL: fileURL)

    let loadedTasks = storage.load()

    #expect(loadedTasks.isEmpty)
}

// Rejeitar título contendo apenas espaços
@Test
func testAddTaskWithWhitespaceTitle() {
    let manager = TaskManager(storage: MockTaskStorage())

    let result = manager.addTask(
        title: "   ",
        priority: 2
    )

    #expect(result == .emptyTitle)
    #expect(manager.tasks.isEmpty)
}

// Rejeitar prioridade acima do limite
@Test
func testAddTaskWithPriorityAboveLimit() {
    let manager = TaskManager(storage: MockTaskStorage())

    let result = manager.addTask(
        title: "Estudar Swift",
        priority: 4
    )

    #expect(result == .invalidPriority)
    #expect(manager.tasks.isEmpty)
}