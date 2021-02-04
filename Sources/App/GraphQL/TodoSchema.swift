import Foundation
import Graphiti
import Vapor

// Definition of our GraphQL schema.
let todoSchema = try! Schema<TodoResolver, Request> {
    Scalar(UUID.self)

    // Todo type with it's fields
    Type(Todo.self) {
        Field("id", at: \.id)
        Field("title", at: \.title)
    }

    Type(User.self) {
        Field("id", at: \.id)
        Field("name", at: \.name)
        Field("todos", with: \.$todos)
    }

    // We only have one single query: Getting all existing todos
    Query {
        Field("users", at: TodoResolver.getAllUsers)
        Field("todos", at: TodoResolver.getAllTodos)
    }

    // Both mutations accept arguments.
    // First we define the name from our FieldKey enum in the TodoAPI
    // and we pass the keypath to the field of the argument struct.
    Mutation {
        Field("createUser", at: TodoResolver.createUser) {
            Argument("name", at: \.name)
        }

        Field("deleteTodo", at: TodoResolver.deleteUser) {
          Argument("id", at: \.id)
        }

        Field("createTodo", at: TodoResolver.createTodo) {
            Argument("title", at: \.title)
            Argument("userID", at: \.userID)
        }

        Field("deleteTodo", at: TodoResolver.deleteTodo) {
          Argument("id", at: \.id)
        }
    }
}
