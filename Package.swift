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
        .package(url: "https://github.com/engingulek/ICTMDBModularProtocols", branch: "version/swiftui"),
        .package(url: "https://github.com/engingulek/ICTMDBNavigationManagerSwiftUI", branch: "master")
    ],
    targets: [
        .target(
            name: "ICTMDBHomeModule",
            dependencies: [
                .product(name: "ICTMDBNetworkManagerKit", package: "ICTMDBNetworkManagerKit"),
                .product(name: "ICTMDBViewKit", package: "ICTMDBViewKit"),
                .product(name: "ICTMDBModularProtocols", package: "ICTMDBModularProtocols"),
                .product(name: "ICTMDBNavigationManagerSwiftUI", package: "ICTMDBNavigationManagerSwiftUI")
                
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

