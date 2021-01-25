// swift-tools-version:4.2
import PackageDescription

let package = Package(
    name: "WeakableSelf",
    products: [
        .library(
            name: "WeakableSelf",
            targets: ["WeakableSelf"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "WeakableSelf",
            dependencies: [],
            path: "Sources"
        ),
        .testTarget(
            name: "WeakableSelfTests",
            dependencies: ["WeakableSelf"],
            path: "WeakableSelfTests"
        )
    ]
)
