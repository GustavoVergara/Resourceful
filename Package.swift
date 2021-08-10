// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Resourceful",
    defaultLocalization: "en",
    products: [
        .library(
            name: "Resourceful",
            targets: ["Resourceful"]),
    ],
    targets: [
        .target(
            name: "Resourceful",
            dependencies: []),
        .testTarget(
            name: "ResourcefulTests",
            dependencies: ["Resourceful"],
            resources: [Resource.process("Resources")])
    ]
)
