//
//  File.swift
//  
//
//  Created by mikaurakawa on 2023/04/06.
//

import Foundation
import JWT

struct AppStoreConnectPayload: JWTPayload {
    enum CodingKeys: String, CodingKey {
        case issuer = "iss"
        case issuedAtClaim = "ias"
        case expiration = "exp"
        case audience = "aud"
    }

    var issuer: IssuerClaim
    var issuedAtClaim: IssuedAtClaim
    var expiration: ExpirationClaim
    var audience: AudienceClaim

    // 追加の検証ロジックを実行する
    func verify(using signer: JWTSigner) throws {
        try expiration.verifyNotExpired()
    }
}
