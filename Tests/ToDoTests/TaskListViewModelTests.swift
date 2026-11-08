
import Testing
@testable import ToDo

// Verifica se o ViewModel disponibiliza as tarefas do TaskManager
@Test
func testTasksReflectTaskManager() {
    let mock = MockTaskStorage()
    let manager = TaskManager(storage: mock)
    let viewModel = TaskListViewModel(taskManager: manager)

    manager.addTask(title: "Estudar SwiftUI", priority: 2)

    #expect(viewModel.tasks.count == 1)
    #expect(viewModel.tasks[0].title == "Estudar SwiftUI")
}

// Verifica se o ViewModel utiliza o TaskManager recebido
@Test
func testViewModelUsesInjectedTaskManager() {
    let mock = MockTaskStorage()
    let manager = TaskManager(storage: mock)
    let viewModel = TaskListViewModel(taskManager: manager)

    let result = viewModel.addTask(
        title: "Testar ViewModel",
        priority: 1
    )

    #expect(result == .success)

    #expect(manager.tasks.count == 1)
    #expect(mock.savedTasks.count == 1)
}