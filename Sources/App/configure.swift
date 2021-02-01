import GraphQL
import FluentSQLiteDriver
import Vapor
import GraphQLKit
import GraphiQLVapor

// configures your application
public func configure(_ app: Application) throws {
    app.databases.use(.sqlite(.memory), as: .sqlite)
    app.migrations.add(CreateTodo())
    try app.autoMigrate().wait()

    // Register the schema and its resolver.
    app.register(graphQLSchema: todoSchema, withResolver: TodoResolver())

    // Enable GraphiQL web page to send queries to the GraphQL endpoint
    if !app.environment.isRelease {
        app.enableGraphiQL()
    }
}
