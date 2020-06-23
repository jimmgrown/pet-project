import Foundation

#warning("Каждая модель должна быть в отдельном файле (пока что это так, потом я расскажу про другой способ организации)")
#warning("Вертикальные отступы")

struct Response: Decodable {
    let blocks: [Block]
    enum CodingKeys: String, CodingKey {
        case blocks = "data"
    }
}

struct Background: Decodable {
    let type: String?
    let value: String?
}

struct FontColor: Decodable {
    let type: String
    let value: String
}

struct Filters: Decodable {
    let sort: String?
    let guids: [String]?
    let tags: [String]?
    let isPopular: Bool?
    //let season:String?
}

struct Params: Decodable {
    let locationId: String?
    let filters: Filters
    let size: Int
    let page: Int
}

struct Action: Decodable {
    let url: String
    let params: Params?
    let priority: Int?
    let animationDuration: Int?
    let displayDuration: Int?
    let name: String?
}

struct BreadCrumbs: Decodable {
    let name: String
    let id: String
    let machineName: String
}

struct CollectionField: Decodable {
    let name: String
    let textColor: String
    let backgroundColor:String
}

struct Price: Decodable {
    let current: Int
    let first: Int?
    let discount: Int?
}

struct Brand: Decodable {
    let image: String
    let name: String
}

struct Colors: Decodable {
    let hex: String
    let colorId: String
    let articul: String
    let title: String
    let preview: String
    let colorName: String
}

struct Rate: Decodable {
    let numberOfVotes: Int
    let votes: Int
}

struct ModelBlockIdTwo: Decodable {
    let bannerId: String
    let name: String
    let priority: Int
    let image: String
    let action: Action
}

struct ModelBlockIdOne: Decodable {
    let bannerId: String
    let image: String
    let action: Action
    let name: String
    let priority: Int
}

struct ModelBlockIdFour: Decodable {
    //let breadCrumbs: [BreadCrumbs]
    //let tags: [String]
    //let articul: String
    let preview: String
    let title: String
    let withVideo: Bool
    //let collection: CollectionField
    let price: Price
    let saleCount: Int
    let brand: Brand
    //let colors: Colors?
    //let isNew: Bool
    //let rate: Rate?
    //let withDiscount: Bool  
}

#warning("На нейминге я сейчас не буду останавливаться, но подобные названия абсолютно недопустимы")
struct ModelBlockIdFive: Decodable {
    let id: String
    let importName: String
    let updated: String
    let image: String
    let name: String
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case importName
        case updated
        case image
        case name
    }
}

struct ModelBlockIdNine: Decodable {
    let bannerId: String
    let image: String
    let action: Action
    let priority: Int
    let animationDuration: Int?
    let displayDuration: Int?
    let name: String
}

struct CategoriesTree: Decodable {
    let uniqueId: Int
    let name: String
    let machineName: String
    let retailGroup: [String]
    let importId: String
    let image: String?
    let mainCategory: Bool?
    let level: Int
    let saleFlag: Bool
    let newFlag: Bool
    let priority: Int
    let parent: String?
    let hex: String?
    let mobileImage: String?
    let allowForMobile: Bool?
}

struct AdditionalData: Decodable {
    let categoriesTree: [CategoriesTree]
}

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
        if let items = try? container.decode([ModelBlockIdTwo].self, forKey: .items) {
            self.items = items
        } else
            if let items = try? container.decode([ModelBlockIdFour].self, forKey: .items) {
                self.items = items
            } else
                if let items = try? container.decode([ModelBlockIdFive].self, forKey: .items) {
                    self.items = items
                } else
                    if let items = try? container.decode([ModelBlockIdNine].self, forKey: .items) {
                        self.items = items
                    } else {
                        items = ["1","2","kapec"]
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
