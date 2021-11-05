public final class QualityIncreasingItem: Item, Updatable {
    
    // MARK: - Updatable
    
    var qualityUpdateValue: Int {
        let maxQualityDiff = Self.maxQuality - quality
        return sellIn < 0 ? min(2, maxQualityDiff) : min(1, maxQualityDiff)
    }
    
}
