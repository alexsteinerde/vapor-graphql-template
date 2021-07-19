import Fluent
import Vapor

// Example of a pivot model.
final class TodoTag: Model {
    static let schema = "todo+tag"

    @ID(key: .id)
    var id: UUID?

    @Parent(key: "todo_id")
    var todo: Todo

    @Parent(key: "tag_id")
    var tag: Tag

    init() { }

    init(id: UUID? = nil, planet: Todo, tag: Tag) throws {
        self.id = id
        self.$todo.id = try todo.requireID()
        self.$tag.id = try tag.requireID()
    }
}
