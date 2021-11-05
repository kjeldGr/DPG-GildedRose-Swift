import XCTest

@testable import GildedRose

final class GildedRoseTests: XCTestCase {
    
    // MARK: - General tests

    func testAppItems() {
        let item = Item(name: "TestItem", sellIn: 1, quality: 5)
        let app = GildedRose(items: [item])
        
        app.updateQuality()
        XCTAssertEqual(app.items.count, 1)
        XCTAssertEqual(item.name, app.items[0].name)
    }
    
    // MARK: - Default item
    
    func testDefaultItemQualityDecreases() {
        let item = Item(name: "TestItem", sellIn: 1, quality: 5)
        let app = GildedRose(items: [item])
        
        app.updateQuality()
        XCTAssertEqual(item.sellIn, 0)
        XCTAssertEqual(item.quality, 4)
    }
    
    func testDefaultItemQualityDecreasesTwiceAsFastAfterSellInDate() {
        let item = Item(name: "TestItem", sellIn: 1, quality: 5)
        let app = GildedRose(items: [item])
        
        app.updateQuality()
        XCTAssertEqual(item.sellIn, 0)
        XCTAssertEqual(item.quality, 4)
        
        app.updateQuality()
        XCTAssertEqual(item.sellIn, -1)
        XCTAssertEqual(item.quality, 2)
    }
    
    // MARK: - Aged brie
    
    func testAgedBrieQualityIncreases() {
        let item = Item(name: "Aged Brie", sellIn: 1, quality: 0)
        let app = GildedRose(items: [item])
        
        app.updateQuality()
        XCTAssertEqual(item.sellIn, 0)
        XCTAssertEqual(item.quality, 1)
    }
    
    func testAgedBrieQualityIncreasesTwiceAsFastAfterSellInDate() {
        let item = Item(name: "Aged Brie", sellIn: 1, quality: 0)
        let app = GildedRose(items: [item])
        
        app.updateQuality()
        XCTAssertEqual(item.sellIn, 0)
        XCTAssertEqual(item.quality, 1)
        
        app.updateQuality()
        XCTAssertEqual(item.sellIn, -1)
        XCTAssertEqual(item.quality, 3)
    }
    
    func testAgedBrieQualityDoesNotIncreaseAboveMaxValue() {
        let item = Item(name: "Aged Brie", sellIn: 1, quality: 49)
        let app = GildedRose(items: [item])
        
        app.updateQuality()
        XCTAssertEqual(item.sellIn, 0)
        XCTAssertEqual(item.quality, 50)
        
        app.updateQuality()
        XCTAssertEqual(item.sellIn, -1)
        XCTAssertEqual(item.quality, 50)
    }
    
    // MARK: - Backstage passes
    
    func testBackstagePassesQualityIncreases() {
        let item = Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 11, quality: 0)
        let app = GildedRose(items: [item])
        
        app.updateQuality()
        XCTAssertEqual(item.sellIn, 10)
        XCTAssertEqual(item.quality, 1)
    }
    
    func testBackstagePassesQualityIncreasesTwiceAsFastWithTenDaysLeft() {
        let item = Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 10, quality: 0)
        let app = GildedRose(items: [item])
        
        app.updateQuality()
        XCTAssertEqual(item.sellIn, 9)
        XCTAssertEqual(item.quality, 2)
    }
    
    func testBackstagePassesQualityIncreasesThreeTimesAsFastWithFiveDaysLeft() {
        let item = Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 5, quality: 0)
        let app = GildedRose(items: [item])
        
        app.updateQuality()
        XCTAssertEqual(item.sellIn, 4)
        XCTAssertEqual(item.quality, 3)
    }
    
    func testBackstagePassesQualityDropsToZeroAfterSellIn() {
        let item = Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 2, quality: 0)
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
        let item = Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 5, quality: 49)
        let app = GildedRose(items: [item])
        
        app.updateQuality()
        XCTAssertEqual(item.sellIn, 4)
        XCTAssertEqual(item.quality, 50)
        
        app.updateQuality()
        XCTAssertEqual(item.sellIn, 3)
        XCTAssertEqual(item.quality, 50)
    }
    
    // MARK: - Sulfuras
    
    func testSulfurasQualityAndSellInDoesNotChange() {
        let item = Item(name: "Sulfuras, Hand of Ragnaros", sellIn: 10, quality: 80)
        let app = GildedRose(items: [item])
        
        app.updateQuality()
        XCTAssertEqual(item.sellIn, 10)
        XCTAssertEqual(item.quality, 80)
    }
    
    // MARK: - XCTestCase

    static var allTests = [
        ("testAppItems", testAppItems),
        ("testDefaultItemQualityDecreases", testDefaultItemQualityDecreases),
    ]
}
