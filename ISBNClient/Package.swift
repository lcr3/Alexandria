// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ISBNClient",
    platforms: [.iOS("15.0")],
    products: [
        .library(
            name: "ISBNClient",
            targets: ["ISBNClient"]),
    ],
    dependencies: [
        .package(url: "https://github.com/ishkawa/APIKit.git", from: "5.2.0"),
    ],
    targets: [
        .target(
            name: "ISBNClient",
            dependencies: [
                .product(name: "APIKit", package: "APIKit")
            ]
        ),
        .testTarget(
            name: "ISBNClientTests",
            dependencies: ["ISBNClient"]),
    ]
)
