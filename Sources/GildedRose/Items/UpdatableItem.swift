public final class UpdatableItem: Item, Updatable {
    
    // MARK: - Updatable
    
    var qualityUpdateValue: Int {
        sellIn < 0 ? -2 : -1
    }
    
}
