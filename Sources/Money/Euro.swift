//
//  File.swift
//  
//
//  Created by Coen ten Thije Boonkkamp on 28/06/2020.
//

import Foundation

import Languages

public enum Euro: MoneyType, Hashable, ExpressibleByFloatLiteral, Comparable, Codable {

    public var money: Money { .euro(self) }

    public var locale: Locale {
        switch self.money {
        case .euro: return .init(identifier: "NL-nl")
        }
    }

    public static func < (lhs: Euro, rhs: Euro) -> Bool {
        lhs.value < rhs.value
    }

    public typealias FloatLiteralType = Float

    public init(floatLiteral value: Float) {
        self = .cash(Decimal(Double(value)))
    }

//    public typealias FloatLiteralType = Decimal

    case cash(Decimal)
    case chartered(notes: [Note], coins: [Coin])

    enum CodingKeys: CodingKey {
            case cash, chartered
        }

    public init(_ value: Decimal) {
        self = .cash(value)
    }

    public static var symbol: String { "EUR" }
    public static var name: String { "euro" }
    public static var abbreviation: String { "EUR" }

    public var value: Decimal {
        switch self {
        case let .cash(value): return value
        case .chartered(notes: let notes, coins: let coins): return notes.reduce(0.0 as Decimal) { $0 + $1.value } + coins.reduce(0.0 as Decimal) { $0 + $1.value }
        }
    }

    public enum Note: Double, Hashable, Comparable, Codable {
        public static func < (lhs: Self, rhs: Self) -> Bool { lhs.rawValue < rhs.rawValue }

        case ten = 10
        case twenty = 20
        case fifty = 50
        case hundred = 100
        case twohundred = 200
        case fivehundred = 500

        public var value: Decimal {
            switch self {
            case .ten: return 10
            case .twenty: return 20
            case .fifty: return 50
            case .hundred: return 100
            case .twohundred: return 200
            case .fivehundred: return 500
            }
        }

    }

    public enum Coin: Hashable, Comparable, Codable {
        public static func < (lhs: Self, rhs: Self) -> Bool {
            lhs.value < rhs.value
        }

        public var denomination: Self { self }

        case cent(Cent)
        case euro(Euro)

        public enum Cent: Double, Hashable, Comparable, Codable {
            public static func < (lhs: Self, rhs: Self) -> Bool { lhs.rawValue < rhs.rawValue }

            case one = 0.01
            case two = 0.02
            case five = 0.05
            case ten = 0.10
            case twenty = 0.20
            case fifty = 0.50
        }

        public enum Euro: Double, Hashable, Comparable, Codable {
            case one = 1
            case two = 2

            public static func < (lhs: Self, rhs: Self) -> Bool { lhs.rawValue < rhs.rawValue }
        }

        public var value: Decimal {
            switch self {
            case .cent(.one): return 0.01
            case .cent(.two): return 0.02
            case .cent(.five): return 0.05
            case .cent(.ten): return 0.10
            case .cent(.twenty): return 0.20
            case .cent(.fifty): return 0.50
            case .euro(.one): return 1
            case .euro(.two): return 2
            }
        }
    }

    private static func getal_in_schrijfletters(
        getal: Decimal,
        locale: Locale
    ) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        formatter.locale = locale
        return formatter.string(for: getal)!
    }

    public func description(
        formatter: NumberFormatter = .currency,
        include_words: Bool
    ) -> Translated<String> {
        .init { language in
            if !include_words {
                if let value = formatter.string(from: value as NSNumber) {
//                    return .init("&euro; \(value)")
                    return .init("€ \(value)")
                } else {
//                    return .init("&euro; \(value)")
                    return .init("€ \(value)")
                }
            } else {

                formatter.maximumFractionDigits = 10
                let eurosStr = value > 1 ? "euros" : "euro"

                if let value2 = formatter.string(from: value as NSNumber) {
                    return .init("\(Self.getal_in_schrijfletters(getal: value, locale: language.locale)) \(eurosStr) (&euro; \(value2))")
                } else {
                    return .init("\(Self.getal_in_schrijfletters(getal: value, locale: language.locale)) \(eurosStr) (&euro; \(value))")
                }
            }
        }
    }
}

public extension NumberFormatter {
    static let currency: NumberFormatter = {
        let formatter = NumberFormatter()
//        formatter.locale = self.locale

        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.usesGroupingSeparator = true
        return formatter
    }()

    static let currencyNoFractionDigits: NumberFormatter = {
        let formatter = NumberFormatter()
//        formatter.locale = self.locale

        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 0
        formatter.usesGroupingSeparator = true
        return formatter
    }()
}

extension Euro: CustomStringConvertible {
    public var description: String { self.description(include_words: false)(Locale.autoupdatingLanguage) }
}
