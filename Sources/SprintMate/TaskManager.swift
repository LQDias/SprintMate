final class TaskManager {

    private(set) var tasks: [SprintTask] = []

    // adiciona tarefa
    @discardableResult
    func addTask(title: String, priority: Int) -> Bool {
        guard !title.isEmpty, priority > 0 else {
            return false
        }

        let task = SprintTask(
            title: title,
            priority: priority
        )

        tasks.append(task)
        return true
    }

    // procura um indice e marca concluida
    func completeTask(at index: Int) -> Bool {
        guard tasks.indices.contains(index) else {
            return false
        }

        tasks[index].isCompleted = true
        return true
    }

    // procura um indice e deleta a tarefa
    func deleteTask(at index: Int) -> Bool {
        guard tasks.indices.contains(index) else {
            return false
        }

        tasks.remove(at: index)
        return true
    }
}