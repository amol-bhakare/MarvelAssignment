import ProjectDescription
   
let base: [String: SettingValue] = [
            "ENABLE_TESTING_SEARCH_PATHS": "YES",
]

let debug: [String: SettingValue] = [
            "ENABLE_TESTING_SEARCH_PATHS": "YES",
]

let release: [String: SettingValue] = [
            "ENABLE_TESTING_SEARCH_PATHS": "YES",
]

let project = Project(
  name: "MarvelAssignment",
  organizationName: "Globant India",
  packages: [
    Package.remote(
          url: "https://github.com/Alamofire/Alamofire",
          requirement: .upToNextMajor(
            from: Version(5, 0, 0)
          )
        ),
    Package.remote(
      url: "https://github.com/SDWebImage/SDWebImage.git",
      requirement: .upToNextMajor(
        from: Version(5, 1, 0)
      )
    ),
    Package.remote(
      url: "https://github.com/Moya/Moya.git",
      requirement: .upToNextMajor(
        from: Version(15, 0, 0)
      )
    ),
    Package.remote(
      url: "https://github.com/rjeprasad/RappleProgressHUD.git",
      requirement: .upToNextMajor(
        from: Version(4, 0, 0)
      )
    )
    
  ],
  settings: .settings(base: base, debug: debug, release: release, defaultSettings: DefaultSettings.recommended),
  targets: [
    Target(
      name: "MarvelAssignment",
      platform: .iOS,
      product: .app,
      bundleId: "com.globant.MarvelAssignment",
      infoPlist: "MarvelAssignment/Resources/MarvelAssignment.plist",
      sources: ["MarvelAssignment/Sources/**"],
      resources: ["MarvelAssignment/Resources/**"],
      dependencies: [
        .package(product: "Alamofire"),
        .package(product: "SDWebImage"),
        .package(product: "Moya"),
        .package(product: "RappleProgressHUD")
      ],
      settings: .settings(base: base, debug: debug, release: release, defaultSettings: DefaultSettings.recommended)
    ),
    Target(
      name: "MarvelAssignmentTests",
      platform: .iOS,
      product: .unitTests,
      bundleId: "com.globant.MarvelAssignmenttests",
      infoPlist: "MarvelAssignmentTests/Resources/MarvelAssignmentTests.plist",
      sources: ["MarvelAssignmentTests/Sources/**"],
      dependencies: [
        .target(name: "MarvelAssignment")
      ]
      
    )
  ]
)
