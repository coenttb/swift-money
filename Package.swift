// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

extension String {
    static let money:Self = "Money"
    static let languages:Self = "Languages"
    static let percent:Self = "Percent"
}

extension Target.Dependency {
    static let languages:Self = .product(name: .languages, package: .languages)
    static let percent:Self = .product(name: .percent, package: .percent)
    static let money:Self = .target(name: .money)
}

let package = Package(
    name: .money,
    platforms: [.macOS(.v13), .iOS(.v13)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: .money,
            targets: [.money]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
//        .package(name: "Languages", url: "https://LegalKit@bitbucket.org/LegalKit/languages.git", from: "0.0.0"),
//        .package(name: "Unit", url: "https://LegalKit@bitbucket.org/LegalKit/unit.git", from: "0.0.0"),
        .package(name: .languages, path: "../languages"),
        .package(name: .percent, path: "../percent")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: .money,
            dependencies: [
                .percent,
                .languages
            ]
        )
    ]
)
