public final class LegendaryItem: Item, Updatable {
    
    // MARK: - Updatable
    
    var qualityUpdateValue: Int {
        0
    }
    
    var sellInUpdateValue: Int {
        0
    }
    
    static var maxQuality: Int {
        80
    }
    
    // MARK: - Initializers
    
    public init(name: String, sellIn: Int) {
        super.init(name: name, sellIn: sellIn, quality: Self.maxQuality)
    }
    
}
