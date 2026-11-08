import Foundation
@testable import ToDo

final class MockTaskStorage: TaskStorageProtocol {

    private(set) var savedTasks: [ToDoList] = []

    func save(_ tasks: [ToDoList]) {
        savedTasks = tasks
    }

    func load() -> [ToDoList] {
        return savedTasks
    }
}