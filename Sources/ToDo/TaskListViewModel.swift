
import Foundation

final class TaskListViewModel {

    private let taskManager: TaskManager

    init(taskManager: TaskManager = TaskManager()) {
        self.taskManager = taskManager
    }

    // Lista as tarefas
    var tasks: [ToDoList] {
        return taskManager.tasks
    }

    // Adiciona uma tarefa
    func addTask(title: String, priority: Int) -> AddTaskResult {
        return taskManager.addTask(
            title: title,
            priority: priority
        )
    }

    // Conclui uma tarefa
    func completeTask(at index: Int) -> Bool {
        return taskManager.completeTask(at: index)
    }

    // Exclui uma tarefa
    func deleteTask(at index: Int) -> Bool {
        return taskManager.deleteTask(at: index)
    }
}