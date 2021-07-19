import Fluent
import Vapor

/// A single entry of a Tag list.
final class Tag: Model {
    static let schema = "tags"

    /// The unique identifier for this `Tag`.
    @ID(key: .id)
    var id: UUID?

    /// A title describing what this `Tag` entails.
    @Field(key: "title")
    var title: String
    
    // Example of a siblings relation.
    @Siblings(through: TodoTag.self, from: \.$tag, to: \.$todo)
    public var todos: [Todo]
    
    init() { }

    /// Creates a new `Todo`.
    init(id: UUID? = nil, title: String) {
        self.id = id
        self.title = title
    }
}

