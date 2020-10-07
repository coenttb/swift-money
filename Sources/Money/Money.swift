import Foundation
import Unit
import Languages

public protocol MoneyType {
    static var symbol:String { get }
    static var name:String { get }
    static var abbreviation:String { get }
    var value:Decimal { get }
    var money:Money { get }
}

public enum Money:Hashable, Comparable {
    case euro(Euro)
}

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
    func description<Environment:HasLanguage>(environment:Environment)->String {
        switch self {
        case let .euro(euro): return euro.description(environment: environment)
        }
    }
    
    
    
    static func euro(_ value:Decimal) -> Money {
        return Money.euro(Euro(value))
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



extension Money:CustomStringConvertible {
    
    
    
    public var description: String {
        return self.description(environment: Locale.autoupdatingLanguage)
    }
}

public extension Double {
    var euro:Money {
        .euro(Euro.cash(Decimal(self)))
    }
}
