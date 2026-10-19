// swift-tools-version: 6.0
import PackageDescription
let package = Package(
    name: "OrbitDockPublic",
    platforms: [.macOS(.v13)],
    products: [
        .library(name: "OrbitDockUtilities", targets: ["OrbitDockUtilities"]),
        .executable(name: "orbitdock-utilities-demo", targets: ["UtilitiesDemo"]),
        .executable(name: "orbitdock-utilities-checks", targets: ["UtilitiesChecks"])
    ],
    targets: [
        .target(name: "OrbitDockUtilities"),
        .executableTarget(name: "UtilitiesDemo", dependencies: ["OrbitDockUtilities"]),
        .executableTarget(name: "UtilitiesChecks", dependencies: ["OrbitDockUtilities"], path: "Tests/OrbitDockUtilitiesTests")
    ]
)
