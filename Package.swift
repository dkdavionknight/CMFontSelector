// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "CMFontSelector",
    products: [
        .library(
            name: "CMFontSelector",
            targets: ["CMFontSelector"])
    ],
    targets: [
        .target(
            name: "CMFontSelector",
            dependencies: [],
            path: ".",
            sources: ["CMFontSelector"],
            publicHeadersPath: "include")
    ]
)
