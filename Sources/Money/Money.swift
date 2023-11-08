import Foundation

import Languages
import Percent

public protocol MoneyType {
    static var symbol:String { get }
    static var name:String { get }
    static var abbreviation:String { get }
    var value:Decimal { get }
    var money:Money { get }
}

public enum Money:Hashable, Comparable, Codable {
    
    case euro(Euro)
    
    
    
    public enum CodingKeys: String, CodingKey, Hashable, Equatable, CaseIterable, Codable {
        case euro
    }
}

extension Money:TranslatedCustomStringConvertable {
    public var translatedDescription: TranslatedString {
        switch self {
        case let .euro(euro): return euro.translatedDescription
        }
    }
}


extension Euro:TranslatedCustomStringConvertable {
    public var translatedDescription: TranslatedString {
        return .init(self.description)
    }
}
extension Money: SignedNumeric {
    
    public static func *(rhs:Int, lhs:Money)->Money {
        switch lhs {
        case .euro(let e): return .euro(Euro.init(e.value * Decimal(rhs)))
        }
    }
    
    public static func *(rhs:Money, lhs:Int)->Money {
        switch rhs {
        case .euro(let e): return .euro(Euro.init(e.value * Decimal(lhs)))
        }
    }
    
    public static func *(rhs:Percentage, lhs:Money)->Money {
        switch lhs {
        case .euro(let e): return .euro(Euro.init(e.value * Decimal(rhs.fraction)))
        }
    }
    
    public static func *(rhs:Money, lhs:Percentage)->Money {
        switch rhs {
        case .euro(let e): return .euro(Euro.init(e.value * Decimal(lhs.fraction)))
        }
    }
    
    public init?<T>(exactly source: T) where T : BinaryInteger {
        fatalError()
    }
    
    public var magnitude: Int {
        fatalError()
    }
    
    public static func * (lhs: Money, rhs: Money) -> Money {
        switch (lhs, rhs) {
        case let (.euro(a1), .euro(a2)): return .euro(Euro.init(a1.value * a2.value))
        }
    }
    
    public static func *= (lhs: inout Money, rhs: Money) {
        fatalError()
    }
    
    public static func - (lhs: Money, rhs: Money) -> Money {
        switch (lhs, rhs) {
        case let (.euro(a1), .euro(a2)): return .euro(Euro.init(a1.value - a2.value))
        }
    }
    
    public init(integerLiteral value: Int) {
        self = .euro(Euro.init(Decimal(value)))
    }
    
    public typealias Magnitude = Int
    
    public static func + (lhs: Money, rhs: Money) -> Money {
        switch (lhs, rhs) {
        case let (.euro(a1), .euro(a2)): return .euro(Euro.init(a1.value + a2.value))
        }
    }
    
    public typealias IntegerLiteralType = Int
    
    
}

//extension Money:BinaryInteger {
//    public typealias Words = <#type#>
//    
//    public static var isSigned: Bool {
//        <#code#>
//    }
//    
//    public init?<T>(exactly source: T) where T : BinaryFloatingPoint {
//        <#code#>
//    }
//    
//    public var bitWidth: Int {
//        <#code#>
//    }
//    
//    public var trailingZeroBitCount: Int {
//        <#code#>
//    }
//    
//    public static func / (lhs: Money, rhs: Money) -> Money {
//        <#code#>
//    }
//    
//    public static func % (lhs: Money, rhs: Money) -> Money {
//        <#code#>
//    }
//    
//    public static func %= (lhs: inout Money, rhs: Money) {
//        <#code#>
//    }
//    
//    public static func &= (lhs: inout Money, rhs: Money) {
//        <#code#>
//    }
//    
//    public static func |= (lhs: inout Money, rhs: Money) {
//        <#code#>
//    }
//    
//    public static func ^= (lhs: inout Money, rhs: Money) {
//        <#code#>
//    }
//}

extension Money:MoneyType {
    public static var symbol: String {
        ""
    }
    
    public static var name: String {
        ""
    }
    
    public static var abbreviation: String {
        ""
    }
    
    public var value: Decimal {
        switch self {
        case let .euro(euro): return euro.value
        }
    }
    
    public var money: Money {
        self
    }
    
    
}

public func +(_ t1:MoneyType, _ t2:MoneyType)->MoneyType {
    switch (t1.money, t2.money) {
    case let (.euro(x), .euro(y)): return Euro(x.value + y.value)
    }
}

public func >=(_ t1:MoneyType, _ t2:MoneyType)->Bool {
    switch (t1.money, t2.money) {
    case let (.euro(x), .euro(y)): return x.value >= y.value
    }
}

public extension Money {
    func description(include_words:Bool = false)->Translated<String> {
        switch self {
        case let .euro(euro): return euro.description(include_words: include_words)
        }
    }
    
    
    static func euro(_ value:Decimal) -> Money {
        return Money.euro(Euro(value))
    }
    
    static func euro(_ value:Double) -> Money {
        return Money.euro(Euro(Decimal(value)))
    }
    
    var amount: Decimal {
        switch self {
        case let .euro(euro): return euro.value
        }
    }
}

public func €(_ value:Decimal) -> Money {
    return Money.euro(Euro(value))
}



//extension Money:CustomStringConvertible {
//    public var description: String {
//        switch self {
//        case let .euro(euro): return euro.description()(.current)
//        }
//    }
//}

public extension Int {
    var euro:Money { .euro(Euro.cash(Decimal(self))) }
}


public extension Double {
    var euro:Money { .euro(Euro.cash(Decimal(self))) }
}

public func /(_ money:Money, _ decimal: Decimal)->Money {
    switch money {
    case .euro(let euro): return .euro(.cash(euro.value / decimal))
    }
}

public func /(_ money:Money, _ double: Double)->Money {
    switch money {
    case .euro(let euro): return .euro(.cash(euro.value / Decimal(double)))
    }
}
