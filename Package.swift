// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RMSwiftUI",
    platforms: [
        .iOS(.v14), .watchOS(.v7), .macOS(.v11)
    ],
    products: [
        .library(name: "RMSwiftUICore", targets: ["RMSwiftUICore"]),
        .library(name: "RMActivityViewController", targets: ["RMActivityViewController"]),
        .library(name: "RMBarButton", targets: ["RMBarButton"]),
        .library(name: "RMCardView", targets: ["RMCardView"]),
        .library(name: "RMCategories", targets: ["RMCategories"]),
        .library(name: "RMChangeIconGrid", targets: ["RMChangeIconGrid"]),
        .library(name: "RMEmptyMessage", targets: ["RMEmptyMessage"]),
        .library(name: "RMFormField", targets: ["RMFormField"]),
        .library(name: "RMImagePicker", targets: ["RMImagePicker"]),
        .library(name: "RMOnboarding", targets: ["RMOnboarding"]),
        .library(name: "RMProfile", targets: ["RMProfile"]),
        .library(name: "RMScrollingHStackModifier", targets: ["RMScrollingHStackModifier"]),
        .library(name: "RMSearchBar", targets: ["RMSearchBar"]),
        .library(name: "RMSettingsRow", targets: ["RMSettingsRow"]),
        .library(name: "RMSocialButton", targets: ["RMSocialButton"]),
        .library(name: "RMStyledLabel", targets: ["RMStyledLabel"]),
        .library(name: "RMSubscribeOption", targets: ["RMSubscribeOption"]),
        .library(name: "RMTagList", targets: ["RMTagList"])
    ],
    dependencies: [],
    targets: [
        .target(name: "RMSwiftUICore", dependencies: [], path: "Sources/Core"),
        .target(name: "RMActivityViewController", dependencies: [.target(name: "RMSwiftUICore")], path: "Sources/Packages/ActivityViewController"),
        .target(name: "RMBarButton", dependencies: [.target(name: "RMSwiftUICore")], path: "Sources/Packages/BarButton"),
        .target(name: "RMCardView", dependencies: [.target(name: "RMSwiftUICore")], path: "Sources/Packages/CardView"),
        .target(name: "RMCategories", dependencies: [.target(name: "RMSwiftUICore")], path: "Sources/Packages/Categories"),
        .target(name: "RMChangeIconGrid", dependencies: [.target(name: "RMSwiftUICore")], path: "Sources/Packages/ChangeIconGrid"),
        .target(name: "RMEmptyMessage", dependencies: [.target(name: "RMSwiftUICore")], path: "Sources/Packages/EmptyMessage"),
        .target(name: "RMFormField", dependencies: [.target(name: "RMSwiftUICore")], path: "Sources/Packages/FormField"),
        .target(name: "RMImagePicker", dependencies: [.target(name: "RMSwiftUICore")], path: "Sources/Packages/ImagePicker"),
        .target(name: "RMOnboarding", dependencies: [.target(name: "RMSwiftUICore")], path: "Sources/Packages/Onboarding"),
        .target(name: "RMProfile", dependencies: [.target(name: "RMSwiftUICore")], path: "Sources/Packages/Profile"),
        .target(name: "RMScrollingHStackModifier", dependencies: [.target(name: "RMSwiftUICore")], path: "Sources/Packages/ScrollingHStackModifier"),
        .target(name: "RMSearchBar", dependencies: [.target(name: "RMSwiftUICore")], path: "Sources/Packages/SearchBar"),
        .target(name: "RMSettingsRow", dependencies: [.target(name: "RMSwiftUICore"), .target(name: "RMStyledLabel")], path: "Sources/Packages/SettingsRow"),
        .target(name: "RMSocialButton", dependencies: [.target(name: "RMSwiftUICore")], path: "Sources/Packages/SocialButton"),
        .target(name: "RMStyledLabel", dependencies: [.target(name: "RMSwiftUICore")], path: "Sources/Packages/StyledLabel"),
        .target(name: "RMSubscribeOption", dependencies: [.target(name: "RMSwiftUICore")], path: "Sources/Packages/SubscribeOption"),
        .target(name: "RMTagList", dependencies: [.target(name: "RMSwiftUICore")], path: "Sources/Packages/TagList")
    ]
)
