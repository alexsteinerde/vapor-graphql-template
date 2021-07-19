import Graphiti
import Vapor

final class TodoResolver {
    func getAllUsers(request: Request, _: NoArguments) throws -> EventLoopFuture<[User]> {
        User.query(on: request.db).all()
    }

    struct CreateUserArguments: Codable {
        let name: String
    }

    func createUser(
        request: Request,
        arguments: CreateUserArguments
    ) throws -> EventLoopFuture<User> {
        let user = User(name: arguments.name)
        return user.create(on: request.db).map { user }
    }

    struct DeleteUserArguments: Codable {
        let id: UUID
    }

    func deleteUser(request: Request, arguments: DeleteUserArguments) throws -> EventLoopFuture<Bool> {
        User.find(arguments.id, on: request.db)
            .unwrap(or: Abort(.notFound))
            .flatMap({ $0.delete(on: request.db) })
            .transform(to: true)
    }

    func getAllTodos(request: Request, _: NoArguments) throws -> EventLoopFuture<[Todo]> {
        Todo.query(on: request.db).all()
    }

    struct CreateTodoArguments: Codable {
        let title: String
        let userID: UUID
    }

    func createTodo(request: Request, arguments: CreateTodoArguments) throws -> EventLoopFuture<Todo> {
        let todo = Todo(title: arguments.title, userID: arguments.userID)
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
    
    // Tag Resolver
    func getAllTags(request: Request, _: NoArguments) throws -> EventLoopFuture<[Tag]> {
        Tag.query(on: request.db).all()
    }
    
    struct CreateTagArguments: Codable {
        let title: String
    }

    func createTag(request: Request, arguments: CreateTagArguments) throws -> EventLoopFuture<Tag> {
        let tag = Tag(title: arguments.title)
        return tag.create(on: request.db).map({ tag })
    }
    
    struct AddTagToTodoArguments: Codable {
        let todoID: UUID
        let tagID: UUID
    }
    
    func addTagToTodo(request: Request, arguments: AddTagToTodoArguments) throws -> EventLoopFuture<Bool> {
        let tag = Tag.find(arguments.tagID, on: request.db)
            .unwrap(or: Abort(.notFound))
        let todo = Todo.find(arguments.todoID, on: request.db)
            .unwrap(or: Abort(.notFound))
        
        
        return tag.and(todo)
            .flatMap { (tag, todo) in
                todo.$tags.attach(tag, on: request.db)
            }
            .transform(to: true)
    }
}
