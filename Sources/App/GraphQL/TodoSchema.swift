import Foundation
import Graphiti
import Vapor

// Definition of our GraphQL schema.
let todoSchema = try! Schema<TodoResolver, Request> {
    Scalar(UUID.self)
    DateScalar(formatter: ISO8601DateFormatter())

    // Todo type with it's fields
    Type(Todo.self) {
        Field("id", at: \.id)
        Field("title", at: \.title)
        Field("user", with: \.$user)
        Field("tags", with: \.$tags)
    }

    Type(User.self) {
        Field("id", at: \.id)
        Field("name", at: \.name)
        Field("todos", with: \.$todos)
        Field("createdAt", at: \.createdAt)
        Field("currentTodo", with: \.$currentTodo)
    }
    
    Type(Tag.self) {
        Field("id", at: \.id)
        Field("title", at: \.title)
        Field("todos", with: \.$todos)
    }

    // We only have one single query: Getting all existing todos
    Query {
        Field("users", at: TodoResolver.getAllUsers)
        Field("todos", at: TodoResolver.getAllTodos)
        Field("tags", at: TodoResolver.getAllTags)
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
        
        Field("createTag", at: TodoResolver.createTag) {
            Argument("title", at: \.title)
        }
        
        Field("addTagToTodo", at: TodoResolver.addTagToTodo) {
            Argument("tagID", at: \.tagID)
            Argument("todoID", at: \.todoID)
        }
    }
}
