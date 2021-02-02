import Foundation
import Graphiti
import Vapor

// Definition of our GraphQL schema.
let todoSchema = try! Schema<TodoResolver, Request> {
    Scalar(UUID.self)

    // Todo type with it's fields
    Type(Todo.self) {
        Field("title", at: \.title)
        Field("id", at: \.id)
    }

    // We only have one single query: Getting all existing todos
    Query {
        Field("todos", at: TodoResolver.getAllTodos)
    }

    // Both mutations accept arguments.
    // First we define the name from our FieldKey enum in the TodoAPI
    // and we pass the keypath to the field of the argument struct.
    Mutation {
        Field("createTodo", at: TodoResolver.createTodo) {
            Argument("title", at: \.title)
        }

        Field("deleteTodo", at: TodoResolver.deleteTodo) {
          Argument("id", at: \.id)
        }
    }
}
