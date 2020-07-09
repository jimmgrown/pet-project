enum API {
    static var serverURL: String { return "https://i.api.kari.com" }
    private static var baseURL: String { return "\(serverURL)/mobile/v1" }
    private static var baseURL_v2: String { return "\(serverURL)/mobile/v2" }
    //case main = "https://i.api.kari.com/mobile/v2/screen/main?locationId=7400000100000&client=app_mobile"
}

// MARK: - Main

extension API {
    
    enum Main {
        static func mainScreenURL(client: String) -> String { return
            "\(baseURL_v2)/screen/main?locationId=7400000100000&client=\(client)"
        }
    }
    
}
