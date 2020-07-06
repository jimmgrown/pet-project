struct Block: Decodable {
    let blockId: Int
    let type: BlockType?
    let name: String
    let priority: Int
    let background: Background?
    let fontColor: FontColor?
    let items: [Any]
    let additionalData: AdditionalData?
    
    private enum CodingKeys: String, CodingKey {
        case blockId
        case type
        case name
        case priority
        case background
        case fontColor
        case items
        case additionalData
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        blockId = try container.decode(Int.self, forKey: .blockId)
        name = try container.decode(String.self, forKey: .name)
        priority = try container.decode(Int.self, forKey: .priority)
        type = BlockType(rawValue: try container.decode(String.self, forKey: .type))
        
        background = try container.decodeIfPresent(Background.self, forKey: .background)
        fontColor = try container.decodeIfPresent(FontColor.self, forKey: .fontColor)
        additionalData = try container.decodeIfPresent(AdditionalData.self, forKey: .additionalData)
        
        switch type {
        case .some(.slider), .some(.additionalInfos), .some(.categories), .some(.finds):
            items = try container.decode([StockBannerModel].self, forKey: .items)
        case .some(.products), .some(.productsHot):
            items = try container.decode([ProductsModel].self, forKey: .items)
        case .some(.brands):
            items = try container.decode([BrandModel].self, forKey: .items)
        case .none:
            items = []
        }
//        switch type {
//        case "slider", "additional_infos", "categories", "finds":
//            items = try container.decode([StockBannerModel].self, forKey: .items)
//        case "products", "products_hot":
//            items = try container.decode([ProductsModel].self, forKey: .items)
//        case "brands":
//            items = try container.decode([BrandModel].self, forKey: .items)
//        default:
//            items = []
//        }
    }
}
