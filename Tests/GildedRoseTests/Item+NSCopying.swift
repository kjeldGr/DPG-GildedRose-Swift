import Foundation

@testable import GildedRose

extension Item: NSCopying {
    public func copy(with zone: NSZone? = nil) -> Any {
        Item(name: name, sellIn: sellIn, quality: quality)
    }
}

extension ConjuredItem {
    public override func copy(with zone: NSZone? = nil) -> Any {
        ConjuredItem(name: name, sellIn: sellIn, quality: quality)
    }
}

extension ExpiringItem {
    public override func copy(with zone: NSZone? = nil) -> Any {
        ExpiringItem(name: name, sellIn: sellIn, quality: quality)
    }
}

extension QualityIncreasingItem {
    public override func copy(with zone: NSZone? = nil) -> Any {
        QualityIncreasingItem(name: name, sellIn: sellIn, quality: quality)
    }
}

extension UpdatableItem {
    public override func copy(with zone: NSZone? = nil) -> Any {
        UpdatableItem(name: name, sellIn: sellIn, quality: quality)
    }
}
