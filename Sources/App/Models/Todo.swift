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

    /// A user that owns this `Todo` item.
    @Parent(key: "user_id")
    var user: User
    
    @Siblings(through: TodoTag.self, from: \.$todo, to: \.$tag)
    public var tags: [Tag]

    init() { }

    /// Creates a new `Todo`.
    init(id: UUID? = nil, title: String, userID: UUID) {
        self.id = id
        self.title = title
        self.$user.id = userID
    }
}
