// swift-tools-version:5.10.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

extension String {
    static let money: Self = "Money"
}

extension Target.Dependency {
    static var money: Self { .target(name: .money) }
}

extension Target.Dependency {
    static var languages: Self { .product(name: "Languages", package: "swift-language") }
    static var percent: Self { .product(name: "Percent", package: "swift-percent") }
}

let package = Package(
    name: "swift-money",
    platforms: [
        .macOS(.v13),
        .iOS(.v16),
        .macCatalyst(.v16)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: .money,
            targets: [.money])
    ],
    dependencies: [
        .package(url: "https://github.com/coenttb/swift-language.git", branch: "main"),
        .package(url: "https://github.com/coenttb/swift-percent.git", branch: "main")

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
