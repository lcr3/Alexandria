// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LocationClient",
    platforms: [.iOS("15.0")],
    products: [
        .library(
            name: "LocationClient",
            targets: ["LocationClient"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "LocationClient",
            dependencies: []),
        .testTarget(
            name: "LocationClientTests",
            dependencies: ["LocationClient"]),
    ]
)
