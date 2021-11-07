// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "Tools",
    platforms: [.macOS(.v12)],
    dependencies: [
        .package(url: "https://github.com/mono0926/LicensePlist", from: "3.14.4"),
        .package(url: "https://github.com/realm/SwiftLint", from: "0.45.0"),
        .package(url: "https://github.com/nicklockwood/SwiftFormat", from: "0.48.18"),
    ],
    targets: [
    ]
)
