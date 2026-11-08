struct ToDoList: Codable {
    let title: String
    let priority: Int
    var isCompleted: Bool = false
}