import Vapor
import GraphQL

/// Creates an instance of `Application`. This is called from `main.swift` in the run target.
public func app(_ env: Environment) throws -> Application {
    var config = Config.default()
    var env = env
    var services = Services.default()
    try configure(&config, &env, &services)
    let app = try Application(config: config, environment: env, services: services)
    try boot(app)
    return app
}

let userType = try! GraphQLObjectType(name: "User", description: nil, fields: [
    "firstname": GraphQLField(type: GraphQLNonNull(GraphQLString)),
    "lastname": GraphQLField(type: GraphQLNonNull(GraphQLString))
])

struct User: Codable {
    var firstname: String
    var lastname: String

}

let schema = try! GraphQLSchema(
    query: GraphQLObjectType(
        name: "RootQueryType",
        fields: [
            "hello": GraphQLField(
                type: GraphQLString,
                resolve: { _, _, _, _ in
                    "world"
                }
            ),
            "myUser": GraphQLField(type: GraphQLString, resolve: {  _, _, _, _ in
                "User"
            }),
            "user": GraphQLField(type: userType, resolve: { (_, _, _, _) in
                User(firstname: "Alex", lastname: "Steiner")
            })
        ]
    ),
    mutation: GraphQLObjectType(name: "Mutations", fields: [
        "createUser": GraphQLField(type: userType, args: ["firstname": GraphQLArgument(type: GraphQLString), "lastname": GraphQLArgument(type: GraphQLString)], resolve: { _, arguments, _, _ in
            User(firstname: arguments["firstname"].string!, lastname: arguments["lastname"].string!)
        })
    ])
)
