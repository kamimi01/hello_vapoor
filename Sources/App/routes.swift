import Vapor
import JWT

func routes(_ app: Application) throws {
    // Add HMAC with SHA-256 signer.
//    app.jwt.signers.use(.hs256(key: "secret"))  // これがあるとJWTがHS256アルゴリズムになるので、一旦コメントアウト
//
//    app.get("me") { req -> HTTPStatus in
//        let payload = try req.jwt.verify(as: TestPayload.self)
//        print(payload)
//        return .ok
//    }
//
//    app.post("login") { req -> [String: String] in
//        let payload = TestPayload(
//            subject: "vapor",
//            expiration: .init(value: .distantFuture),
//            isAdmin: true
//        )
//
//        print(try! req.jwt.sign(payload))
//        return try [
//            "token": req.jwt.sign(payload)
//        ]
//    }
//
//    app.get("hello") { req async -> String in
//        "Hello, world!"
//    }

    app.get("appstoreconnect") { req -> [String: String] in
        let privateKey = privateKey

        let payload = AppStoreConnectPayload(
            issuer: .init(value: issuerID),
            issuedAtClaim: .init(value: Date()),
            expiration: .init(value: Calendar.current.date(byAdding: .minute, value: 20, to: Date()) ?? Date()),
            audience: .init(value: ["appstoreconnect-v1"])
        )

        let key = try ECDSAKey.private(pem: privateKey)
        try app.jwt.signers.use(.es256(key: key))

        return try [
            "token": req.jwt.sign(payload, kid: keyID)
        ]
    }
}
