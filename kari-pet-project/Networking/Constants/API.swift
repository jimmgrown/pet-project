enum API {
    private static var baseURL: String { return "\(serverURL)/mobile/v1" }
    private static var baseURL_v2: String { return "\(serverURL)/mobile/v2" }
    static var serverURL: String { return "https://i.api.kari.com" }
    static var baseLocationId: String { return "7400000100000" }
    static var client: String { return "app_mobile" }
    static var alternative: String { return "alternative" }
    static var related: String { return "related" }
}

// MARK: - Main

extension API {

    enum Main {
        static func mainScreenURL() -> String {
            return "\(baseURL_v2)/screen/main?locationId=\(baseLocationId)&client=\(client)"
        }
        static func goodsCardURL(for vendorCode: String) -> String {
            return """
            \(baseURL)/goods/product/card?locationId=\(baseLocationId)&articuls=\(vendorCode)&withTableSize=true
            """
        }
        static func recommendedProducts(for type: String) -> String {
            return "\(baseURL)/goods/recommends/\(type)"
        }
    }
    
}
