import Graphiti
import Vapor

final class TodoAPI {
    func getAllTodos(request: Request, _: NoArguments) throws -> EventLoopFuture<[Todo]> {
        Todo.query(on: request).all()
    }

    struct CreateTodoArguments: Codable {
        let title: String
    }

    func createTodo(request: Request, arguments: CreateTodoArguments) throws -> EventLoopFuture<Todo> {
        Todo(title: arguments.title).save(on: request)
    }

    struct DeleteTodoArguments: Codable {
        let id: Int
    }

    func deleteTodo(request: Request, arguments: DeleteTodoArguments) throws -> EventLoopFuture<Bool> {
        Todo.find(arguments.id, on: request)
            .unwrap(or: Abort(.notFound))
            .flatMap({ $0.delete(on: request) })
            .transform(to: true)
    }
}

extension TodoAPI: FieldKeyProvider {
    typealias FieldKey = FieldKeys

    enum FieldKeys: String {
    // Field names for the arguments
        case title // Argument to create a new todo
        case id // Argument to delete a todo

    // Names for the GraphQL schema endpoints
        case todos // Get all todos
        case createTodo // Create a new todo
        case deleteTodo // Delete a todo
    }
}
