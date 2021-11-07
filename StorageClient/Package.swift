// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "StorageClient",
    platforms: [.iOS("15.0")],
    products: [
        .library(
            name: "StorageClient",
            targets: ["StorageClient"]
        ),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "StorageClient",
            dependencies: []
        ),
        .testTarget(
            name: "StorageClientTests",
            dependencies: ["StorageClient"]
        ),
    ]
)
