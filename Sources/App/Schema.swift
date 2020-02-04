import Graphiti
import Vapor

// Definition of our GraphQL schema.
let todoSchema = Schema<TodoAPI, Request>([
    // Todo type with it's fields
    Type(Todo.self, fields: [
        Field(.title, at: \.title),
        Field(.id, at: \.id),
    ]),

    // We only have one single query: Getting all existing todos
    Query([
        Field(.todos, with: TodoAPI.getAllTodos)
    ]),

    // Both mutations accept arguments.
    // First we define the name from our FieldKey enum in the TodoAPI
    // and we pass the keypath to the field of the argument struct.
    Mutation([
        Field(.createTodo, with: TodoAPI.createTodo)
            .argument(.title, at: \.title),

        Field(.deleteTodo, with: TodoAPI.deleteTodo)
            .argument(.id, at: \.id),
    ]),
])
