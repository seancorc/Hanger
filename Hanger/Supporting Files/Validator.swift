//
//  Validator.swift
//  Hanger
//
//  Created by Sean Corcoran on 7/10/19.
//  Copyright © 2019 SeanCorcoran. All rights reserved.
//

import Foundation


protocol Validator {
    func validate(_ value: String) throws -> String
}

enum ValidatorType {
    case email
    case password
    case username
}

enum AppValidator {
    static func validatorFor(type: ValidatorType) -> Validator {
        switch type {
        case .email: return EmailValidator()
        case .password: return PasswordValidator()
        case .username: return UserNameValidator()
        }
    }
}

fileprivate let firstpart = "[A-Z0-9a-z]([A-Z0-9a-z._%+-]{0,30}[A-Z0-9a-z])?"
fileprivate let serverpart = "([A-Z0-9a-z]([A-Z0-9a-z-]{0,30}[A-Z0-9a-z])?\\.){1,5}"
fileprivate let emailRegex = firstpart + "@" + serverpart + "[A-Za-z]{2,8}"
fileprivate let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
struct EmailValidator: Validator{
    func validate(_ value: String) throws -> String {
        if emailPredicate.evaluate(with: value) {return value }
        else {throw MessageError("Invalid Email")}
    }
}

struct PasswordValidator: Validator {
    func validate(_ value: String) throws -> String {
        guard value.count >= 6 else { throw MessageError("Password must have at least 6 characters") }
        
        return value
    }
}

struct UserNameValidator: Validator {
    func validate(_ value: String) throws -> String {
        guard value.count >= 3 else {
            throw MessageError("Username must contain more than three characters" )
        }
        guard value.count < 18 else {
            throw MessageError("Username shoudn't conain more than 18 characters" )
        }
        
        do {
            if try NSRegularExpression(pattern: "[A-Z0-9a-z]{1,18}$").firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw MessageError("Username should not contain whitespaces or special characters")
            }
        } catch {
            throw MessageError("Username should not contain whitespaces or special characters")
        }
        
        return value
    }
}
