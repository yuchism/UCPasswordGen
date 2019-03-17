//
//  UCpasswordGen.swift
//  UCPasswordGen
//
//  Created by yuch on 17/3/19.
//  Copyright © 2019 Yuch. All rights reserved.
//

import Foundation

enum PasswordChar {
    case numbers
    case specialchars
    case uppercase
    case lowercase
    
    static let allChars:Array<PasswordChar> = [.numbers,.specialchars,.uppercase,.lowercase]
}

extension PasswordChar {
    func charset() -> Array<Character> {
        var arr:Array<Character>
        switch self {
        case .numbers:
            arr = Array("0123456789")
        case .specialchars:
            arr = Array("^$*.[]{}()?-\"!@#%&/\\,><':;|_~`")
        case .uppercase:
            arr = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
        case .lowercase:
            arr = Array("abcdefghijklmnopqrstuvwxyz")
        }
        
        return arr
    }
    func randomChar() -> Character {
        let arr = self.charset()
        let rand = arc4random_uniform(UInt32(arr.count))
        return arr[Int(rand)]
    }
}

protocol UCPasswordPolicyProtocol {
    var minimumLength : Int { get set }
    var requireNumbers : Bool { get set }
    var requireSpecialChar : Bool { get set }
    var requireUppercase : Bool { get set }
    var requireLowercase : Bool { get set }
}

class UCPasswordGen:UCPasswordPolicyProtocol {
    var minimumLength: Int = 8
    var requireNumbers: Bool = true
    var requireLowercase: Bool = true
    var requireUppercase: Bool = true
    var requireSpecialChar: Bool = true
}

extension UCPasswordGen {
    
    func getPassword() -> String {
        let allPasswordChars:Array<PasswordChar> = PasswordChar.allChars
        let mandatoryPasswordChars = self.getMandatoryPasswordChars()
        var password:Array<Character> = []
        
        for idx in 0 ..< self.minimumLength {
            var char:Character!
            if idx < mandatoryPasswordChars.count {
                char = mandatoryPasswordChars[idx].randomChar()
            } else {
                let rand = Int(arc4random_uniform(UInt32(allPasswordChars.count)))
                char = allPasswordChars[rand].randomChar()
            }
            password.append(char)
        }
        
        for idx in 0 ..< password.count {
            let newIdx = Int(arc4random_uniform(UInt32(password.count)))
            password.insert(password.remove(at: newIdx), at: idx)
        }

        return String(password)
    }

    private func getMandatoryPasswordChars() -> Array<PasswordChar> {
        var mandatoryChars:Array<PasswordChar> = []
        if self.requireNumbers {
            mandatoryChars.append(.numbers)
        }
        if self.requireLowercase {
            mandatoryChars.append(.lowercase)
        }
        if self.requireUppercase {
            mandatoryChars.append(.uppercase)
        }
        if self.requireSpecialChar {
            mandatoryChars.append(.specialchars)
        }
        
        return mandatoryChars
    }
}
