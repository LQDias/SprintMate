import Foundation

enum AddTaskResult: Equatable {
    case success
    case emptyTitle
    case invalidPriority
}

class TaskManager {

    private(set) var tasks: [ToDoList] = []

    private let storage: TaskStorage

    init(storage: TaskStorage = TaskStorage()) {
        self.storage = storage
        self.tasks = storage.load()
    }

    // Adiciona tarefa
    @discardableResult
    func addTask(title: String, priority: Int) -> AddTaskResult {

        let cleanedTitle = title.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        guard !cleanedTitle.isEmpty else {
            return .emptyTitle
        }

        guard (1...3).contains(priority) else {
            return .invalidPriority
        }

        let task = ToDoList(
            title: cleanedTitle,
            priority: priority
        )

        tasks.append(task)
        storage.save(tasks)

        return .success
    }

    // Conclui tarefa
    func completeTask(at index: Int) -> Bool {
        guard tasks.indices.contains(index) else {
            return false
        }

        tasks[index].isCompleted = true
        storage.save(tasks)

        return true
    }

    // Exclui tarefa
    func deleteTask(at index: Int) -> Bool {
        guard tasks.indices.contains(index) else {
            return false
        }

        tasks.remove(at: index)
        storage.save(tasks)

        return true
    }
}