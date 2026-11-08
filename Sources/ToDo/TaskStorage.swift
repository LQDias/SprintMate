import Foundation

class TaskStorage {

    private let fileURL: URL

    init() {
        let fileManager = FileManager.default

        guard let appSupportDirectory = fileManager.urls(
            for: .applicationSupportDirectory,
            in: .userDomainMask
        ).first else {
            fatalError("Não foi possível localizar a pasta de dados.")
        }

        let folderURL = appSupportDirectory
            .appendingPathComponent("SprintMate")

        do {
            try fileManager.createDirectory(
                at: folderURL,
                withIntermediateDirectories: true
            )
        } catch {
            fatalError("Não foi possível criar a pasta: \(error)")
        }

        fileURL = folderURL.appendingPathComponent("tasks.json")
    }

    func save(_ tasks: [ToDoList]) {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted

            let data = try encoder.encode(tasks)
            try data.write(to: fileURL, options: .atomic)

            print("Tarefas salvas com sucesso!")
            print("Arquivo: \(fileURL.path)")
        } catch {
            print("Erro ao salvar tarefas: \(error)")
        }
    }

    func load() -> [ToDoList] {
        guard FileManager.default.fileExists(atPath: fileURL.path) else {
            return []
        }

        print("Carregando arquivo: \(fileURL.path)")
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