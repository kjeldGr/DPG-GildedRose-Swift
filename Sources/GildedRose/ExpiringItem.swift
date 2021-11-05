public final class ExpiringItem: Item, Updatable {
    
    var qualityUpdateValue: Int {
        let maxQualityDiff = maxQuality - quality
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
