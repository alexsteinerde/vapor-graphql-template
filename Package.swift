// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "GraphQL-Todo",
    products: [
        .library(name: "GraphQL-Todo", targets: ["App"]),
    ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),

        // 🔵 Swift ORM (queries, models, relations, etc) built on SQLite 3.
        .package(url: "https://github.com/vapor/fluent-sqlite.git", from: "3.0.0"),

        // 🌐 GraphQL
        .package(url: "https://github.com/alexsteinerde/graphql-kit.git", from: "1.0.0-beta"), // Vapor Utilities
        .package(url: "https://github.com/alexsteinerde/graphiql-vapor.git", from: "1.0.0"), // Web Query Page
    ],
    targets: [
        .target(name: "App", dependencies: ["FluentSQLite", "Vapor", "GraphQLKit", "GraphiQLVapor"]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: ["App"])
    ]
)
