struct GoodsCard: Decodable {
    let vendorCode: String
    let title: String
    let price: Price
    //let media: Media?
    //let sku: [String:String]?
    let brand: Brand
    let colors: [Colors]
    let sizes: [Size]
    let uniqueSizesIDs: [String: Int]
    
    private enum CodingKeys: String, CodingKey {
        case vendorCode = "articul"
        case title
        case price
        case brand
        case colors
        case sizes
        case uniqueSizesIDs = "uniqueSizesIds"
    }
}
