
import PackageDescription

let package = Package(
    name: "Logical",
    dependencies: [
        .Package(url: "https://github.com/JadenGeller/GraphView.git", majorVersion: 1)
    ]
)
