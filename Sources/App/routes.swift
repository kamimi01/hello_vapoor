import Vapor
import JWT

func routes(_ app: Application) throws {
    // Add HMAC with SHA-256 signer.
    app.jwt.signers.use(.hs256(key: "secret"))

    app.get("me") { req -> HTTPStatus in
        let payload = try req.jwt.verify(as: TestPayload.self)
        print(payload)
        return .ok
    }

    app.post("login") { req -> [String: String] in
        let payload = TestPayload(
            subject: "vapor",
            expiration: .init(value: .distantFuture),
            isAdmin: true
        )

        print(try! req.jwt.sign(payload))
        return try [
            "token": req.jwt.sign(payload)
        ]
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }
}
