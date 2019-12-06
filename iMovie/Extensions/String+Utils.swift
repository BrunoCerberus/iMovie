//
//  String+Utils.swift
//  iMovie
//
//  Created by bruno on 04/12/19.
//  Copyright © 2019 bruno. All rights reserved.
//

import UIKit

extension String {
    
    static let whitespace = " "
    
    var firstUppercased: String {
        return prefix(1).uppercased() + dropFirst()
    }
    var firstCapitalized: String {
        return String(prefix(1)).capitalized + dropFirst()
    }
    
    var doubleValue: Double {
        let styler = NumberFormatter()
        styler.minimumFractionDigits = 2
        styler.maximumFractionDigits = 2
        styler.numberStyle = .decimal
        
        let converter = NumberFormatter()
        converter.decimalSeparator = ","
        
        if let result = converter.number(from: self) {
            return result.doubleValue
        } else {
            converter.decimalSeparator = "."
            if let result = converter.number(from: self) {
                return result.doubleValue
            }
        }
        
        return 0.0
    }
    
    var integerValue: Int {
        return Int(self) ?? 0
    }
    
    var isDecimalNumber: Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: self)
        let result = allowedCharacters.isSuperset(of: characterSet)
        return result
    }
    
    var decimalOnly: String {
        return self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
    }
    
    var formattedValue: Double {
        let stringValue = self.decimalOnly
        let resultValue = stringValue.doubleValue / 100
        return resultValue
    }
    
    func subString(from: String, to: String) -> String? {
        return (self.range(of: from)?.upperBound).flatMap { substringFrom in
            (self.range(of: to, range: substringFrom..<self.endIndex)?.lowerBound).map { substringTo in
                String(self[substringFrom..<substringTo])
            }
        }
    }
    
    /// Remove elements from string
    ///
    /// - Parameter values: Elements to remove.
    /// ```
    /// // Example
    /// let result = "5.888.444,55".remove([".", ","])
    /// ```
    /// - Returns: Result string
    func remove(_ values: [String]) -> String {
        var stringValue = self
        let toRemove = stringValue.filter { values.contains("\($0)") }
        
        for value in toRemove {
            if let range = stringValue.range(of: "\(value)") {
                stringValue.removeSubrange(range)
            }
        }
        
        return stringValue
    }
    
    func trim() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    // used to transform path provided to cdn format
    func cdnPath() -> String {
        let scale = Int(UIScreen.main.scale)
        let finalPath = self.replacingOccurrences(of: "/path/", with: "/ios/")
            .replacingOccurrences(of: "/resolution/", with: "/\(scale)x/")
        return finalPath
    }
    
    func toDateFormat(format: String, fromFormat: String) -> String {
        let df: DateFormatter = DateFormatter()
        df.locale = Locale(identifier: "pt_BR")
        df.dateFormat = fromFormat
        guard let date = df.date(from: self) else { return "" }
        df.dateFormat = format
        return df.string(from: date)
    }
    
    func toDate(format: Date.FormatStyle, locale: Locale? = nil) -> Date? {
        let formatter = DateFormatter()
        formatter.locale = locale ?? Locale.current
        formatter.dateFormat = format.rawValue
        return formatter.date(from: self)
    }
    
    func filterOnlyNumbers() -> String {
        return String(self.filter { "0123456789".contains($0) })
    }
    
    var removeCaracterSpecial: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    }
    
    func isValidEmail() -> Bool {
        let emailRegEx = """
[a-z0-9#%&^_`{}~-]+(?:\\.[a-z0-9#%&^_`{}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?
"""
        let email = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        let result =  email.evaluate(with: self)
        return result
    }
    
    func hasKeyboardSequenceChars() -> Bool {
        let keyboardSequences = ["1234567890", "qwertyuiop", "asdfghjkl", "zxcvbnm"]
        let numCharConstituteSeq = 3
        for sequence in keyboardSequences {
            let timesToCheck = sequence.count - numCharConstituteSeq + 1
            for seqCount in 0..<timesToCheck {
                let indexStart = sequence.index(sequence.startIndex, offsetBy: seqCount)
                let indexEnd = sequence.index(indexStart, offsetBy: numCharConstituteSeq)
                let range = indexStart..<indexEnd
                let subSequence = sequence[range]
                
                if self.lowercased().contains(subSequence) {
                    return true
                }
            }
        }
        return false

    }
    
    func isPasswordValid() -> Bool {
        if 8...16 ~= self.count {
            var satisfyingRules = 0
            
            let accentRegexString = ".*[àèìòùÀÈÌÒÙáéíóúýÁÉÍÓÚÝâêîôûÂÊÎÔÛãñõÃÑÕäëïöüÿÄËÏÖÜçÇ ].*"
            let accentRegex = NSPredicate(format: "SELF MATCHES %@", accentRegexString)
            if accentRegex.evaluate(with: self) {
                return false
            }
            
            if self.hasKeyboardSequenceChars() {
                return false
            }
            
            let digitRegexString = ".*\\d+.*"
            let digitRegex = NSPredicate(format: "SELF MATCHES %@", digitRegexString)
            satisfyingRules = digitRegex.evaluate(with: self) ? satisfyingRules + 1 : satisfyingRules
            
            let specialCharacterRegexString = ".*[!-/:-@\\[-`{-~].*"
            let specialCharacterRegex = NSPredicate(format: "SELF MATCHES %@", specialCharacterRegexString)
            satisfyingRules = specialCharacterRegex.evaluate(with: self) ? satisfyingRules + 1 : satisfyingRules
            
            let upperCaseRegexString = ".*[A-Z].*"
            let upperCaseRegex = NSPredicate(format: "SELF MATCHES %@", upperCaseRegexString)
            satisfyingRules = upperCaseRegex.evaluate(with: self) ? satisfyingRules + 1 : satisfyingRules
            
            let lowerCaseRegexString = ".*[a-z].*"
            let lowerCaseRegex = NSPredicate(format: "SELF MATCHES %@", lowerCaseRegexString)
            satisfyingRules = lowerCaseRegex.evaluate(with: self) ? satisfyingRules + 1 : satisfyingRules
            
            return satisfyingRules >= 2
        }
        return false
    }
    
    func isValidName() -> Bool {
        let emailRegEx = "[A-Z0-9a-zÀ-Ÿ]+( [A-Z0-9a-zÀ-Ÿ ]+)+$"
        let email = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        let result =  email.evaluate(with: self)
        return result
    }

    func isValidBirthday() -> Bool {
        guard let date = self.toDate(format: .shortDate) else {
            return false
        }
        
        let birthdayRegEx = "^([0-2][0-9]||3[0-1])/(0[0-9]||1[0-2])/([0-9][0-9])?[0-9][0-9]$"
        let birthday = NSPredicate(format: "SELF MATCHES %@", birthdayRegEx)
        let result =  birthday.evaluate(with: self)
        let now = Date()
        
        let isFutureDate = date > now

        let dateComponentsBirthday: DateComponents? = Calendar.current.dateComponents([.year], from: date)
        let dateComponentsNow: DateComponents? = Calendar.current.dateComponents([.year], from: now)
        var isUnderMaxAge = false
        if let yearOfBirth = dateComponentsNow?.year,
            let yearToday = dateComponentsBirthday?.year {
            isUnderMaxAge = (yearOfBirth - yearToday) < 120
        }

        return result && !isFutureDate && isUnderMaxAge
    }
}

// MARK: - StringMaskr helpers
public extension String {
    
    private  func hexStringFromData(input: NSData) -> String {
        var bytes = [UInt8](repeating: 0, count: input.length)
        input.getBytes(&bytes, length: input.length)
        var hexString = ""
        for byte in bytes {
            hexString += String(format: "%02x", UInt8(byte))
        }
        return hexString
    }
    
    func initials() -> String? {
        var initials: String?
        do {
            initials = try self.getInitials()
        } catch {
            initials = ""
        }
        return initials
    }
    
    private func getInitials() throws -> String {
        let initialName = self.condenseWhitespace()
        if initialName != "" {
            let initials = initialName.components(separatedBy: " ").reduce("") { ($0 == "" ? "" : "\($0.first!)") + "\($1.first!)" }
            if initials.count < 2 {
                return initialName.prefix(2).uppercased()
            }
            return initials
        } else {
            return ""
        }
    }
    
    private func condenseWhitespace() -> String {
        let components = self.components(separatedBy: NSCharacterSet.whitespacesAndNewlines)
        return components.filter { !$0.isEmpty }.joined(separator: " ")
    }
}
