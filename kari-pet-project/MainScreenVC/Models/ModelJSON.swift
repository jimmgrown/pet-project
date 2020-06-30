import Foundation

struct Block: Decodable {
    let blockId: Int
    let blockType: String
    let name: String
    let priority: Int
    let background: Background?
    let fontColor: FontColor?
    let items: [Any]
    let additionalData: AdditionalData?
    
    enum CodingKeys: String, CodingKey {
        case blockId
        case blockType = "type"
        case name
        case priority
        case background
        case fontColor
        case items
        case additionalData
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        #warning("Во-первых, что за вложенность? else if - это один оператор, не надо пирамиду строить. + тут нужен вспомогательные enum который ты обработаешь через switch")
        
        if let items = try? container.decode([StockBannerModel].self, forKey: .items) {
            self.items = items
        } else
            if let items = try? container.decode([ProductsModel].self, forKey: .items) {
                self.items = items
            } else
                if let items = try? container.decode([BrandModel].self, forKey: .items) {
                    self.items = items
                } else {
                    items = []
        }
        
        #warning("Зачем для пропертей ниже стоит опциональный try?")
        if let blockId = try? container.decode(Int.self, forKey: .blockId) {
            self.blockId = blockId
        } else {
            self.blockId = 0
        }
        if let blockType = try? container.decode(String.self, forKey: .blockType) {
            self.blockType = blockType
        } else {
            self.blockType = ""
        }
        if let name = try? container.decode(String.self, forKey: .name) {
            self.name = name
        } else {
            self.name = ""
        }
        if let background = try? container.decode(Background.self, forKey: .background) {
            self.background = background
        } else {
            self.background = nil
        }
        if let priority = try? container.decode(Int.self, forKey: .priority) {
            self.priority=priority
        } else {
            self.priority = 0
        }
        if let fontColor = try? container.decode(FontColor.self, forKey: .fontColor) {
            self.fontColor = fontColor
        } else {
            fontColor = nil
        }
        if let additionalData = try? container.decode(AdditionalData.self, forKey: .additionalData) {
            self.additionalData = additionalData
        } else {
            self.additionalData = nil
        }
    }
}
