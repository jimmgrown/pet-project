enum API {
    static var serverURL: String { return "https://i.api.kari.com" }
    private static var baseURL: String { return "\(serverURL)/mobile/v1" }
    private static var baseURL_v2: String { return "\(serverURL)/mobile/v2" }
}

// MARK: - Main

extension API {
    
    enum Main {
        #warning("Этот локейшн айди ты будешь использовать везде, его стоит в константу вынести")
        static func mainScreenURL(client: String) -> String {
            return "\(baseURL_v2)/screen/main?locationId=7400000100000&client=\(client)"
        }
    }
    
}
