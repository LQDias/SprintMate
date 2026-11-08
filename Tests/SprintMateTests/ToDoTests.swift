import Testing
@testable import SprintMate

// Rejeitar tarefa com título vazio
@Test
func testAddTaskWithEmptyTitle() {
    let manager = TaskManager(storage: MockTaskStorage())

    let result = manager.addTask(
        title: "",
        priority: 2
    )

    #expect(result == false)
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

    #expect(result == true)
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

    #expect(result == false)
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