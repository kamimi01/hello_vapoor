//
//  File.swift
//  
//
//  Created by mikaurakawa on 2023/04/05.
//

import Foundation
import JWT

struct TestPayload: JWTPayload {
    enum CodingKeys: String, CodingKey {
        case subject = "sub"
        case expiration = "exp"
        case isAdmin = "admin"  // カスタムデータ
    }

    var subject: SubjectClaim
    var expiration: ExpirationClaim
    var isAdmin: Bool

    // 追加の検証ロジックを実行する
    func verify(using signer: JWTSigner) throws {
        try expiration.verifyNotExpired()
    }
}
