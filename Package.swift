// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "StocksAPI",
    platforms: [
        .iOS(.v13), .macCatalyst(.v13), .macOS(.v12), .tvOS(.v13), .watchOS(.v8)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "StocksAPI",
            targets: ["StocksAPI"]),
        .executable(name: "StocksAPIExec",
                    targets: ["StocksAPIExec"])
    ],
    targets: [
        .target(
            name: "StocksAPI",
            dependencies: []),
        .executableTarget(name: "StocksAPIExec",
                          dependencies: ["StocksAPI"]),
        .testTarget(
            name: "StocksAPITests",
            dependencies: ["StocksAPI"]),
    ]
)
