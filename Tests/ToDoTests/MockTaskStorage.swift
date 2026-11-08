import Foundation
@testable import ToDo

final class MockTaskStorage: TaskStorage {

    private(set) var savedTasks: [ToDoList] = []

    override func save(_ tasks: [ToDoList]) {
        savedTasks = tasks
    }

    override func load() -> [ToDoList] {
        return savedTasks
    }
}