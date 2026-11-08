import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

enum APIError: Error {
    case invalidURL
    case invalidResponse
    case httpError(Int)
}

final class TaskAPIService {

    func fetchTask() async throws -> RemoteTask {

        guard let url = URL(
            string: "https://jsonplaceholder.typicode.com/todos/1"
        ) else {
            throw APIError.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(
            from: url
        )

        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            throw APIError.httpError(httpResponse.statusCode)
        }

        let task = try JSONDecoder().decode(
            RemoteTask.self,
            from: data
        )

        return task
    }
}