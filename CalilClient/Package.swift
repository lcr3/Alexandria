// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CalilClient",
    platforms: [.iOS("15.0")],
    products: [
        .library(
            name: "CalilClient",
            targets: [
                "CalilClient",
            ]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/ishkawa/APIKit.git", from: "5.2.0"),
        .package(url: "https://github.com/AliSoftware/OHHTTPStubs.git", from: "9.1.0"),
    ],
    targets: [
        .target(
            name: "CalilClient",
            dependencies: [
                .product(name: "APIKit", package: "APIKit"),
            ]
        ),
        .testTarget(
            name: "CalilClientTests",
            dependencies: [
                "CalilClient",
                .product(name: "OHHTTPStubsSwift", package: "OHHTTPStubs"),
            ]
        ),
    ]
)
