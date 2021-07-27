# GraphQL Vapor Template
[![Language](https://img.shields.io/badge/Swift-5.4-brightgreen.svg)](http://swift.org)
[![Vapor Version](https://img.shields.io/badge/Vapor-4-F6CBCA.svg)](http://vapor.codes)

This is a template that can be used to create Vapor applications that include GraphQL APIs. It's based on [GraphQL](https://github.com/GraphQLSwift/GraphQL), [Graphiti](https://github.com/GraphQLSwift/Graphiti) and helper functions from [GraphQLKit](https://github.com/alexsteinerde/graphql-kit).

## Example Queries:
### Query
```graphql
# Quering all todos with its ids and titles.
query GetAllTodos {
  todos {
    id
    title
    tags {
      title
    }
    user {
      name
    }
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

# Quering all tags with its ids and titles.
query GetAllTags {
  tags {
    id
    title
    todos {
      title
    }
  }
}

# We can pass an argument directly to the query
mutation createUser {
  createUser(name: "Jess") {
    id
    name
    createdAt
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
mutation deleteTodo($todoId: UUID!) {
  deleteTodo(id: $todoId)
}

# Create a new tag
mutation createTag {
  createTag(title: "Important") {
    id
  }
}

# Assign a tag to a todo item
mutation addTag2Todo($todoId: UUID!, $tagId: UUID!) {
  addTagToTodo(tagID: $tagId, todoID: $todoId)
}
```

### Parameters
```json
{
  "userId": "<Generated User Id>",
  "todoId": "<Generated Todo Id>",
  "tagId": "<Generated Tag Id>"
}
```
