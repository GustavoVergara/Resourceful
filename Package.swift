// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Resourceful",
    defaultLocalization: "en",
    platforms: [.macOS(.v10_11)],
    products: [
        .library(
            name: "Resourceful",
            targets: ["Resourceful"]),
        .executable(name: "resourceful-generator",
                    targets: ["resourceful-generator"])
    ],
    dependencies: [
        .package(name: "swift-argument-parser", url: "https://github.com/apple/swift-argument-parser.git", .upToNextMinor(from: "0.3.2")),
        .package(name: "XcodeEdit", url: "https://github.com/tomlokhorst/XcodeEdit.git", .upToNextMajor(from: "2.7.7")),
    ],
    targets: [
        .target(
            name: "Resourceful",
            dependencies: []),
        .testTarget(
            name: "ResourcefulTests",
            dependencies: ["Resourceful"],
            resources: [Resource.process("Resources")]),
        // Generator
        .target(name: "ResourcefulGenerator",
                dependencies: [
                    .product(name: "ArgumentParser", package: "swift-argument-parser"),
                    "XcodeEdit",
                ]),
        .target(name: "resourceful-generator",
                dependencies: ["ResourcefulGenerator"]),
        .testTarget(name: "ResourcefulGeneratorTests",
                    dependencies: ["ResourcefulGenerator"],
                    resources: [Resource.process("Resources")])

    ]
)
