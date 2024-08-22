

guard let info = Bundle.main.infoDictionary else { return }

// 버전 넘버
let version = info["CFBundleShortVersionString"] as? String
// 빌드 넘버
let projectVersion = info["CFBundleVersion"] as? String

print(version)
print(projectVersion)
