import Fluent
import Vapor

/// A single entry of a Todo list.
final class Todo: Model {
    static let schema = "todos"

    /// The unique identifier for this `Todo`.
    @ID(key: .id)
    var id: UUID?

    /// A title describing what this `Todo` entails.
    @Field(key: "title")
    var title: String

    init() { }

    /// Creates a new `Todo`.
    init(id: UUID? = nil, title: String) {
        self.id = id
        self.title = title
    }
}
