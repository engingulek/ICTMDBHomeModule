//swift-tools-version:6.2
import PackageDescription

let package = Package(
    name: "ICTMDBHomeModule",
    defaultLocalization: "en",

    platforms: [
        .iOS(.v26)
    ],
    products: [
        .library(
            name: "ICTMDBHomeModule",
            targets: ["ICTMDBHomeModule"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/engingulek/ICTMDBNetworkManagerKit", branch: "feature/create-modular-network-layer"),
        .package(url: "https://github.com/engingulek/ICTMDBViewKit", branch: "version/swiftui"),
    ],
    targets: [
        .target(
            name: "ICTMDBHomeModule",
            dependencies: [
                .product(name: "ICTMDBNetworkManagerKit", package: "ICTMDBNetworkManagerKit"),
                .product(name: "ICTMDBViewKit", package: "ICTMDBViewKit"),
                
            ],
            path: "ICTMDBHomeModule"
        ),
        .testTarget(
            name: "ICTMDBHomeModuleTests",
            dependencies: [
                "ICTMDBHomeModule",
            ],
            path: "ICTMDBHomeModuleTests"
        )
    ]
)

