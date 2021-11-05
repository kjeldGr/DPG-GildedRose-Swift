public final class UpdatableItem: Item, Updatable {
    
    var qualityUpdateValue: Int {
        sellIn < 0 ? -2 : -1
    }
    
}
