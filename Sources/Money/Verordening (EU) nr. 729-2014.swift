//
//  File.swift
//  
//
//  Created by Coen ten Thije Boonkkamp on 28/06/2020.
//

import Foundation


public enum CirculationCoin {
    case gewoon
    case herdenking
}

public enum Coin {
    
    case euro(Euro)
    
    public enum Shape {
        case round
        case spanishFlower
    }
    
    public enum Color {
        case single(Color)
        case double(inner:Color, outer:Color)
        
        public enum Color {
            case yellow
            case white
            case red
        }
    }
}

//extension CoinType where Denomination == Euro.Coin {
//    
//    public var color: Coin.Color {
//        switch denomination {
//        case .cent(.one): return .single(.red)
//        case .cent(.two): return .single(.red)
//        case .cent(.five): return .single(.red)
//        case .cent(.ten): return .single(.yellow)
//        case .cent(.twenty): return .single(.yellow)
//        case .cent(.fifty): return .single(.yellow)
//        case .euro(.one): return .double(inner: .white, outer: .yellow)
//        case .euro(.two): return .double(inner: .yellow, outer: .white)
//        }
//    }
//    
//    public var thickness: Thickness {
//        switch denomination {
//        case .cent(.one): return .milli(1.67)
//        case .cent(.two): return .milli(1.67)
//        case .cent(.five): return .milli(1.67)
//        case .cent(.ten): return .milli(1.93)
//        case .cent(.twenty): return .milli(2.14)
//        case .cent(.fifty): return .milli(2.38)
//        case .euro(.one): return .milli(2.33)
//        case .euro(.two): return .milli(2.20)
//        }
//    }
//    
//    public var diameter:Diameter {
//        switch denomination {
//        case .cent(.one): return .milli(16.25)
//        case .cent(.two): return .milli(18.75)
//        case .cent(.five): return .milli(21.25)
//        case .cent(.ten): return .milli(19.75)
//        case .cent(.twenty): return .milli(22.25)
//        case .cent(.fifty): return .milli(24.25)
//        case .euro(.one): return .milli(23.25)
//        case .euro(.two): return .milli(25.75)
//        }
//    }
//    
//    public var weight:Weight  {
//        switch denomination {
//        case .cent(.one): return .unit(2.3)
//        case .cent(.two): return .unit(3)
//        case .cent(.five): return .unit(3.9)
//        case .cent(.ten): return .unit(4.1)
//        case .cent(.twenty): return .unit(5.7)
//        case .cent(.fifty): return .unit(7.8)
//        case .euro(.one): return .unit(7.5)
//        case .euro(.two): return .unit(8.5)
//        }
//    }
//    
//    public var shape:Coin.Shape  {
//        switch denomination {
//        case .cent(.one): return .round
//        case .cent(.two): return .round
//        case .cent(.five): return .round
//        case .cent(.ten): return .round
//        case .cent(.twenty): return .spanishFlower
//        case .cent(.fifty): return .round
//        case .euro(.one): return .round
//        case .euro(.two): return .round
//        }
//    }
//}
