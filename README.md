# GraphQL Vapor Template
[![Language](https://img.shields.io/badge/Swift-5.1-brightgreen.svg)](http://swift.org)
[![Vapor Version](https://img.shields.io/badge/Vapor-3-F6CBCA.svg)](http://vapor.codes)

This is a template that can be used to create Vapor applications that include GraphQL APIs. It's based on [GraphQL](https://github.com/alexsteinerde/GraphQL), [Graphiti](https://github.com/alexsteinerde/Graphiti) and helper functions from [GraphQLKit](https://github.com/alexsteinerde/graphql-kit).

## Example Queries:
```graphql
// Query
// Quering all todos with it's ids and titles.
query GetAllTodos {
  todos {
    id
    title
  }
}

// But we can also just query ids and it will only send them wihtout the title data.
query GetTodoIDs {
  todos {
    id
  }
}

// We can include arguments directly into the query
mutation createTodo {
  createTodo(title: "Cleanup the house") {
    id
    title
  }
}

// Or we can also define parameters that are fetched from the JSON formatted parameters field below.
mutation deleteTodo($id: Int!) {
  deleteTodo(id: $id)
}

// Parameters
{
  "id": 1
}
```
