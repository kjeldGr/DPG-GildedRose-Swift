public final class QualityIncreasingItem: Item, Updatable {
    
    var qualityUpdateValue: Int {
        let maxQualityDiff = maxQuality - quality
        return sellIn < 0 ? min(2, maxQualityDiff) : min(1, maxQualityDiff)
    }
    
}
