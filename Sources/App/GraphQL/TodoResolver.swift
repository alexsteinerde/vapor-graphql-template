import Graphiti
import Vapor

final class TodoResolver {
    func getAllTodos(request: Request, _: NoArguments) throws -> EventLoopFuture<[Todo]> {
        Todo.query(on: request.db).all()
    }

    struct CreateTodoArguments: Codable {
        let title: String
    }

    func createTodo(request: Request, arguments: CreateTodoArguments) throws -> EventLoopFuture<Todo> {
        let todo = Todo(title: arguments.title)
        return todo.create(on: request.db).map { todo }
    }

    struct DeleteTodoArguments: Codable {
        let id: UUID
    }

    func deleteTodo(request: Request, arguments: DeleteTodoArguments) throws -> EventLoopFuture<Bool> {
        Todo.find(arguments.id, on: request.db)
            .unwrap(or: Abort(.notFound))
            .flatMap({ $0.delete(on: request.db) })
            .transform(to: true)
    }
}
