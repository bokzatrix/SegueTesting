//
//  SegueTestingTests.swift
//  SegueTestingTests
//
//  Created by matt johnston on 9/12/15.
//  Copyright © 2015 matt johnston. All rights reserved.
//

import XCTest
@testable import SegueTesting

class SegueTestingTests: XCTestCase {
    
    let sut = UIStoryboard.init(name: "Main", bundle: nil) //set up the storyboard
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testFirstToSecondSegue() {
        let fvc = sut.instantiateViewControllerWithIdentifier("firstVC")  // instantiate the first viewcontroller
        UIApplication.sharedApplication().keyWindow!.rootViewController = fvc
        XCTAssertNotNil(fvc) // first view controller created
        XCTAssertEqual(fvc.title, "First ViewController", "not the correct viewcontroller") //test VC title
        // create array of view items. in this case just one button
        let viewItemArrayFVC : [UIView] = fvc.view.subviews
        let arrayOfButtonsFVC : [UIView] = fvc.view.subviews.filter {$0 .isKindOfClass(UIButton)}
        let buttonFVC : UIButton = arrayOfButtonsFVC.first as! UIButton
        let buttonTargetsFVC = buttonFVC.allTargets() // the target for the buttons action.
        let buttonTargetFVC = buttonTargetsFVC.first // there is only one in here this time
        let buttonTargetStringFVC : String = "\(buttonTargetFVC?.description)"
        // check button label text
        XCTAssertEqual(buttonFVC.titleLabel?.text, "First", "button label not correct")
        //check button target is a kind of segue
        XCTAssertTrue(buttonTargetStringFVC.containsString("UIStoryboardShowSegue"), "it is not of the segue type")
        //now perform the segure
        fvc.performSegueWithIdentifier("FTS", sender: nil)
        XCTAssertEqual(fvc.presentedViewController!.title, "second viewController", "this is not the correct viewcontroller")

    }
    func testSecondToThirdSegue() {
        
        let svc = sut.instantiateViewControllerWithIdentifier("secondVC")  // instantiate the second viewcontroller
        UIApplication.sharedApplication().keyWindow!.rootViewController = svc
        XCTAssertNotNil(svc) // first view controller created
        XCTAssertEqual(svc.title, "second viewController", "not the correct viewcontroller") //test VC title
        // create array of view items. in this case just one button
        let viewItemArray : [UIView] = svc.view.subviews
        let arrayOfButtons : [UIView] = svc.view.subviews.filter {$0 .isKindOfClass(UIButton)}
        let button : UIButton = arrayOfButtons.first as! UIButton
        let buttonTargets = button.allTargets() // the target for the buttons action.
        let buttonTarget = buttonTargets.first // there is only one in here this time
        let buttonTargetString : String = "\(buttonTarget?.description)"
        // check button label text
        XCTAssertEqual(button.titleLabel?.text, "Second", "button label not correct")
        //check button target is a kind of segue
        XCTAssertTrue(buttonTargetString.containsString("UIStoryboardShowSegue"), "it is not of the segue type")
        //now perform the segue
        svc.performSegueWithIdentifier("STT", sender: nil)
        //check that the segue presents the correct viewcontroller
        XCTAssertEqual(svc.presentedViewController!.title, "third viewController", "this is not the correct viewcontroller")
        
    }
}
