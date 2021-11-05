public final class ExpiringItem: Item, Updatable {
    
    // MARK: - Updatable
    
    var qualityUpdateValue: Int {
        let maxQualityDiff = Self.maxQuality - quality
        switch sellIn {
        case ..<0:
            return -quality
        case 0..<5:
            return min(3, maxQualityDiff)
        case 5..<10:
            return min(2, maxQualityDiff)
        default:
            return min(1, maxQualityDiff)
        }
    }
    
}
