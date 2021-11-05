public final class ConjuredItem: Item, Updatable {
    
    // MARK: - Updatable
    
    var qualityUpdateValue: Int {
        sellIn < 0 ? -4 : -2
    }
    
}
