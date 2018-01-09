//
//  EngineeringForTestabilitySampleUITests.swift
//  EngineeringForTestabilitySampleUITests
//
//  Created by Koichi Sato on 2018/01/05.
//  Copyright © 2018 justin999. All rights reserved.
//

import XCTest

class GameApp: XCUIApplication {
    let app = XCUIApplication()
    
    enum Difficulty: String {
        case beginner
        case intermediate
        case veteran
    }
    enum Sound: String {
        case on
        case off
    }
    
    func setDifficulty(_ difficulty: Difficulty) {
        app.buttons["Difficulty"].tap()
        app.buttons[difficulty.rawValue].tap()
        app.navigationBars.buttons["Back"].tap()
    }
    
    func setSound(_ sound: Sound) {
        app.buttons["Sound"].tap()
        app.buttons[sound.rawValue].tap()
        app.navigationBars.buttons["Back"].tap()
    }
    
    func configureSettings(difficulty: Difficulty, sound: Sound) {
        XCTContext.runActivity(named: "Configure Settings: \(difficulty), \(sound)") { _ in
            app.navigationBars["Game.GameView"].buttons["Settings"].tap()
            setDifficulty(difficulty)
            setSound(sound)
            app.navigationBars.buttons["Back"].tap()
        }
    }
    
}

class EngineeringForTestabilitySampleUITests: XCTestCase {
    let app = GameApp()
    func testGameWithDifficultyBeginnerAndSoundOff() {
        app.configureSettings(difficulty: .beginner, sound: .off)
        
        // test code
        
    }
    
    // 2. better than 1.version
    // Still, it could be abstracted.
    func testGameWithDifficultyBeginnerAndSoundOff_Unscalable2() {
        app.navigationBars["Game.GameView"].buttons["Settings"].tap()
        app.setDifficulty(.beginner)
        app.setSound(.off)
        app.navigationBars.buttons["Back"].tap()
        // test code
        
    }
    
    // 1. can't understand what is done here afterwards.
    // need to be abstract the behavior
    func testGameWithDifficultyBeginnerAndSoundOff_Unscalable1() {
        app.navigationBars["Game.GameView"].buttons["Settings"].tap()
        app.buttons["Difficulty"].tap()
        app.buttons["beginner"].tap()
        app.navigationBars.buttons["Back"].tap()
        app.buttons["Sound"].tap()
        app.buttons["off"].tap()
        app.navigationBars.buttons["Back"].tap()
        app.navigationBars.buttons["Back"].tap()
    }
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    
}
