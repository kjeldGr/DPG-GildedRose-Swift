import XCTest

@testable import GildedRose

final class GildedRoseTests: XCTestCase {
    
    // MARK: - General tests

    func testAppItems() {
        let item = UpdatableItem(name: "TestItem", sellIn: 1, quality: 5)
        let app = GildedRose(items: [item])
        
        app.updateQuality()
        XCTAssertEqual(app.items.count, 1)
        XCTAssertEqual(item.name, app.items[0].name)
    }
    
    // MARK: - Item
    
    func testSulfurasQualityAndSellInDoesNotChange() {
        let item = Item(name: "Sulfuras, Hand of Ragnaros", sellIn: 10, quality: 80)
        let app = GildedRose(items: [item])
        
        app.updateQuality()
        XCTAssertEqual(item.sellIn, 10)
        XCTAssertEqual(item.quality, 80)
    }
    
    // MARK: - UpdatableItem
    
    func testDefaultItemQualityDecreases() {
        let item = UpdatableItem(name: "TestItem", sellIn: 1, quality: 5)
        let app = GildedRose(items: [item])
        
        app.updateQuality()
        XCTAssertEqual(item.sellIn, 0)
        XCTAssertEqual(item.quality, 4)
    }
    
    func testDefaultItemQualityDecreasesTwiceAsFastAfterSellInDate() {
        let item = UpdatableItem(name: "TestItem", sellIn: 1, quality: 5)
        let app = GildedRose(items: [item])
        
        app.updateQuality()
        XCTAssertEqual(item.sellIn, 0)
        XCTAssertEqual(item.quality, 4)
        
        app.updateQuality()
        XCTAssertEqual(item.sellIn, -1)
        XCTAssertEqual(item.quality, 2)
    }
    
    // MARK: - QualityIncreasingItem
    
    func testAgedBrieQualityIncreases() {
        let item = QualityIncreasingItem(name: "Aged Brie", sellIn: 1, quality: 0)
        let app = GildedRose(items: [item])
        
        app.updateQuality()
        XCTAssertEqual(item.sellIn, 0)
        XCTAssertEqual(item.quality, 1)
    }
    
    func testAgedBrieQualityIncreasesTwiceAsFastAfterSellInDate() {
        let item = QualityIncreasingItem(name: "Aged Brie", sellIn: 1, quality: 0)
        let app = GildedRose(items: [item])
        
        app.updateQuality()
        XCTAssertEqual(item.sellIn, 0)
        XCTAssertEqual(item.quality, 1)
        
        app.updateQuality()
        XCTAssertEqual(item.sellIn, -1)
        XCTAssertEqual(item.quality, 3)
    }
    
    func testAgedBrieQualityDoesNotIncreaseAboveMaxValue() {
        let item = QualityIncreasingItem(name: "Aged Brie", sellIn: 0, quality: 49)
        let app = GildedRose(items: [item])
        
        app.updateQuality()
        XCTAssertEqual(item.sellIn, -1)
        XCTAssertEqual(item.quality, 50)
        
        app.updateQuality()
        XCTAssertEqual(item.sellIn, -2)
        XCTAssertEqual(item.quality, 50)
    }
    
    // MARK: - ExpiringItem
    
    func testBackstagePassesQualityIncreases() {
        let item = ExpiringItem(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 11, quality: 0)
        let app = GildedRose(items: [item])
        
        app.updateQuality()
        XCTAssertEqual(item.sellIn, 10)
        XCTAssertEqual(item.quality, 1)
    }
    
    func testBackstagePassesQualityIncreasesTwiceAsFastWithTenDaysLeft() {
        let item = ExpiringItem(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 10, quality: 0)
        let app = GildedRose(items: [item])
        
        app.updateQuality()
        XCTAssertEqual(item.sellIn, 9)
        XCTAssertEqual(item.quality, 2)
    }
    
    func testBackstagePassesQualityIncreasesThreeTimesAsFastWithFiveDaysLeft() {
        let item = ExpiringItem(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 6, quality: 0)
        let app = GildedRose(items: [item])
        
        app.updateQuality()
        XCTAssertEqual(item.sellIn, 5)
        XCTAssertEqual(item.quality, 2)
        
        app.updateQuality()
        XCTAssertEqual(item.sellIn, 4)
        XCTAssertEqual(item.quality, 5)
    }
    
    func testBackstagePassesQualityDropsToZeroAfterSellIn() {
        let item = ExpiringItem(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 2, quality: 0)
        let app = GildedRose(items: [item])
        
        app.updateQuality()
        XCTAssertEqual(item.sellIn, 1)
        XCTAssertEqual(item.quality, 3)
        
        app.updateQuality()
        XCTAssertEqual(item.sellIn, 0)
        XCTAssertEqual(item.quality, 6)
        
        app.updateQuality()
        XCTAssertEqual(item.sellIn, -1)
        XCTAssertEqual(item.quality, 0)
    }
    
    func testBackstagePassesQualityDoesNotIncreaseAboveMaxValue() {
        let item = ExpiringItem(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 6, quality: 49)
        let app = GildedRose(items: [item])
        
        app.updateQuality()
        XCTAssertEqual(item.sellIn, 5)
        XCTAssertEqual(item.quality, 50)
        
        app.updateQuality()
        XCTAssertEqual(item.sellIn, 4)
        XCTAssertEqual(item.quality, 50)
    }
    
    // MARK: - ConjuredItem
    
    func testConjuredItemQualityDecreases() {
        let item = ConjuredItem(name: "Conjured Mana Cake", sellIn: 1, quality: 5)
        let app = GildedRose(items: [item])
        
        app.updateQuality()
        XCTAssertEqual(item.sellIn, 0)
        XCTAssertEqual(item.quality, 3)
    }
    
    func testConjuredItemQualityDecreasesTwiceAsFastAfterSellInDate() {
        let item = ConjuredItem(name: "Conjured Mana Cake", sellIn: 1, quality: 6)
        let app = GildedRose(items: [item])
        
        app.updateQuality()
        XCTAssertEqual(item.sellIn, 0)
        XCTAssertEqual(item.quality, 4)
        
        app.updateQuality()
        XCTAssertEqual(item.sellIn, -1)
        XCTAssertEqual(item.quality, 0)
    }
    
    // MARK: - XCTestCase

    static var allTests = [
        ("testAppItems", testAppItems),
        ("testDefaultItemQualityDecreases", testDefaultItemQualityDecreases),
    ]
}
