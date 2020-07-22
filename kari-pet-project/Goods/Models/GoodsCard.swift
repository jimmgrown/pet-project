struct GoodsCard: Decodable {
    let articul: String
    let title: String
    let price: Price
    //let media: Media?
    //let sku: [String:String]?
    let brand: Brand
    let colors: [Colors]
    let sizes: [Size]
    let uniqueSizesIds: [String: Int]
}
