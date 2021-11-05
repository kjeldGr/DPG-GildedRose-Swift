public class GildedRose {
    var items: [Item]
    
    public init(items: [Item]) {
        self.items = items
    }
    
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
