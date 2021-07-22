import Fluent

struct MigrateUsers: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("users")
            .id()
            .field("name", .string, .required)
            .field("created_at", .datetime, .required)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("users").delete()
    }
}
