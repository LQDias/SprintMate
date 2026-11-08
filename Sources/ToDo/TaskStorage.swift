
import Foundation

class TaskStorage {

    private let fileURL: URL

    init(fileURL: URL? = nil) {
        let resolvedURL: URL

        if let fileURL {
            resolvedURL = fileURL
        } else {
            let fileManager = FileManager.default

            guard let appSupportDirectory = fileManager.urls(
                for: .applicationSupportDirectory,
                in: .userDomainMask
            ).first else {
                fatalError("Não foi possível localizar a pasta de dados.")
            }

            let folderURL = appSupportDirectory
                .appendingPathComponent("SprintMate")

            resolvedURL = folderURL.appendingPathComponent("tasks.json")
        }

        do {
            try FileManager.default.createDirectory(
                at: resolvedURL.deletingLastPathComponent(),
                withIntermediateDirectories: true
            )
        } catch {
            fatalError("Não foi possível criar a pasta: \(error)")
        }

        self.fileURL = resolvedURL
    }

    func save(_ tasks: [ToDoList]) {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted

            let data = try encoder.encode(tasks)
            try data.write(to: fileURL, options: .atomic)

        } catch {
            print("Erro ao salvar tarefas: \(error)")
        }
    }

    func load() -> [ToDoList] {
        guard FileManager.default.fileExists(atPath: fileURL.path) else {
            return []
        }

        do {
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()

            return try decoder.decode([ToDoList].self, from: data)

        } catch {
            print("Erro ao carregar tarefas: \(error)")
            return []
        }
    }
}