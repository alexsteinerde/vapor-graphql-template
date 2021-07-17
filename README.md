# GraphQL Vapor Template
[![Language](https://img.shields.io/badge/Swift-5.4-brightgreen.svg)](http://swift.org)
[![Vapor Version](https://img.shields.io/badge/Vapor-4-F6CBCA.svg)](http://vapor.codes)

This is a template that can be used to create Vapor applications that include GraphQL APIs. It's based on [GraphQL](https://github.com/GraphQLSwift/GraphQL), [Graphiti](https://github.com/GraphQLSwift/Graphiti) and helper functions from [GraphQLKit](https://github.com/alexsteinerde/graphql-kit).

## Example Queries:
```graphql
# Quering all todos with its ids and titles.
query GetAllTodos {
  todos {
    id
    title
  }
}

# But we can also just query ids and it will only send them without the title data.
query GetTodoIDs {
  todos {
    id
  }
}

# We can also query all users and their specific todos.
query GetAllUsersWithTodos {
  users {
    id
    todos {
      id
      title
    }
  }
}

# We can pass an argument directly to the query
mutation createUser {
  createUser(name: "Jess") {
    id
    name
  }
}

# We can pass multiple arguments directly to the query
mutation createTodo($userId: UUID!) {
  createTodo(title: "Use GraphQL", userID: $userId) {
    id
    title
  }
}

# Or we can also define parameters that are fetched from the JSON formatted parameters field below.
mutation deleteTodo($id: UUID!) {
  deleteTodo(id: $id)
}

// Parameters
{
  "id": "1b06a7bc-b542-41cf-8b2a-328943a5ce80",
  "userId": "AAFEEE1F-5185-4191-B6CC-46D4C7040565"
}
```
