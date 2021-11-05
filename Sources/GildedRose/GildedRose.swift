public final class GildedRose {
    
    // MARK: - Internal properties
    
    let items: [Item]
    let sellInUpdateValue: Int = -1
    
    // MARK: - Initializers
    
    public init(items: [Item]) {
        self.items = items
    }
    
    // MARK: - Public methods
    
    public func updateQuality() {
        for item in items {
            guard let updatable = item as? Updatable else {
                // Item is not updatable
                continue
            }
            item.sellIn += sellInUpdateValue
            item.quality += updatable.qualityUpdateValue
        }
    }
    
}
