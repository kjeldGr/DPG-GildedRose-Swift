public final class GildedRose {
    
    // MARK: - Internal properties
    
    let items: [Item]
    
    // MARK: - Initializers
    
    public init(items: [Item]) {
        self.items = items
    }
    
    // MARK: - Public methods
    
    public func updateQuality() {
        for item in items {
            guard let updatable = item as? Updatable else {
                continue
            }
            item.sellIn += updatable.sellInUpdateValue
            item.quality += updatable.qualityUpdateValue
        }
    }
    
}
