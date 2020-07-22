// MARK: Types

enum API {
    static var serverURL: String { return "https://i.api.kari.com" }
    private static var baseURL: String { return "\(serverURL)/mobile/v1" }
    private static var baseURL_v2: String { return "\(serverURL)/mobile/v2" }
    private static var baseLocationId: String { return "7400000100000" }
    static var client: String { return "app_mobile" }
}

// MARK: - Main

extension API {

    enum Main {
        static func mainScreenURL() -> String {
            return "\(baseURL_v2)/screen/main?locationId=\(baseLocationId)&client=\(client)"
        }

        static func goodsCardURL(vendorCode: String) -> String {
            return "\(baseURL)/goods/product/card?locationId=\(baseLocationId)&articuls=\(vendorCode)&withTableSize=true"
        }
        
        static func recommendedProducts() -> String {
            return "https://i.api.kari.com/mobile/v1/goods/recommends/alternative"
        }
        
        static func getBaseLocationId() -> String {
            return API.baseLocationId
        }
    }
    
}
