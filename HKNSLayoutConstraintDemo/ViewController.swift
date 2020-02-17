//
//  ViewController.swift
//  HKNSLayoutConstraintDemo
//

///  MIT License
///
///  Copyright (c) 2020 Harrison Kong
///
///  Permission is hereby granted, free of charge, to any person obtaining a copy
///  of this software and associated documentation files (the "Software"), to deal
///  in the Software without restriction, including without limitation the rights
///  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell/
///  copies of the Software, and to permit persons to whom the Software is
///  furnished to do so, subject to the following conditions:
///
///  The above copyright notice and this permission notice shall be included in all
///  copies or substantial portions of the Software.
///
///  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
///  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
///  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
///  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
///  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
///  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
///  SOFTWARE.

import UIKit
import HKNSLayoutConstraint

class ViewController: UIViewController {

    // MARK: - IB Outlets
    // MARK: -
    
    @IBOutlet weak var orangeViewWidthConstraint   : HKNSLayoutConstraint!
    @IBOutlet weak var pinkViewLeadingConstraint   : HKNSLayoutConstraint!
    @IBOutlet weak var pinkViewTrailingConstraint  : HKNSLayoutConstraint!
    @IBOutlet weak var pinkView      : UIView!
    @IBOutlet weak var orangeView    : UIView!
    @IBOutlet weak var infoButton    : UIButton!
    @IBOutlet weak var popupTextView : UITextView!

    // MARK: - IB Actions
    // MARK: -
    
    // these are just to get the button and popupNote to work:

    @IBAction func buttonTapped(_ sender: UIButton) {
        popupTextView.isHidden = !popupTextView.isHidden
    }
    
    @IBAction func fullScreenButtonTapped(_ sender: UIButton) {
        popupTextView.isHidden = true
    }
    
    // MARK: - Properties
    // MARK: -
    
    var infoButtonWidthConstraint    : HKNSLayoutConstraint?
    var infoButtonHeightConstraint   : HKNSLayoutConstraint?

    // MARK: - Lifecycle
    // MARK: -
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        // must call the viewWillLayoutSubviews() method if the application
        // support device rotation
        
        orangeViewWidthConstraint.viewWillLayoutSubviews()
        pinkViewLeadingConstraint.viewWillLayoutSubviews()
        pinkViewTrailingConstraint.viewWillLayoutSubviews()
        infoButtonWidthConstraint?.viewWillLayoutSubviews()
        infoButtonHeightConstraint?.viewWillLayoutSubviews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // The first example is mostly done in storyboard. We want the width
        // of the orange view to be 0.9 x the shorter edge of the pink view
        //
        // What were set in the storyboard:
        //
        // Alt Multiplier  = 0.9
        // Alt 2nd Item    = 2 (UI Item, set in the 1 line of code below)
        // Alt Calc Basis  = 3 (shorter edge)
        // First Item        Orange View.Width
        // Relation          Equal
        // Second Item       Pink View.Width (unimportant due to x 0.001)
        // Constant          250 (unimportant, will be calculated at run time)
        // Priority          1000 (set as needed)
        // Multiplier        0.001 (we want this calculation be the only result)
        //
        // Note that for the Alt 2nd item and Alt Calc Basis we have to use Int
        // because interface builder only recognizes certain types of
        // variables
        
        // Here we tell the width constraint to calculate based on the pink
        // view because it is not possible to set this in the storyboard:
        
        orangeViewWidthConstraint.altSecondItem = .uiItem(pinkView)        
        
        // The second example is done in storyboard. The leading
        // and trailing anchor of the orange view are set to 0.1 of the screen
        // width. In the storyboard:
        //
        // Alt Multiplier  = 0.1 and -0.1
        // Alt 2nd Item    = 1 (device screen)
        // Alt Calc Basis  = 1 (width)
        // First Item        Orange View.Leading and Orange View.Trailing
        // Relation          Equal
        // Second Item       Safe Area.Leading and Trailing
        // Constant          20 and -20 (unimportant, calculated at run time)
        // Priority          1000 (set as needed)
        // Multiplier        1 (must be set to one for X and Y axis anchors)
        //
        // Note that for the Alt 2nd item and Alt Calc Basis we have to use Int
        // because interface builder only recognizes certain types of
        // variables
        
        // >>> See storyboard for orangeView's leading & trailing constraints
        
        
        // The next example we construct 2 HKUILayoutConstraint
        // programmatically using convenience initializers:
        //
        // Note that HKUILayoutConstraint cannot be constructed using
        // the constraints() method of NSLayoutAnchors and NSLayoutDimension.
        //
        // Note that relatedBy, toItem, (2nd) attribute, multipler and constant
        // are optional but if you include them, the multipler will be used
        // in the original equation with the constant will be replaced with our
        // calculation, example:
        
        /*
         
        let someConstraint = HKNSLayoutConstraint(item: A as Any, attribute: .leading, relatedBy: .lessThanOrEqual, toItem: B as Any, attribute: .trailing, multiplier: 1.0, constant: 0, altSecondItem: .uiItem(C), altCalculationBasis: .width, altMultiplier: 0.5)
         
        */
        
        // In the above example:
        // leading anchor of A <= trailing anchor of B + 1/2 width of C
        
        // set the info button's width to 0.5 of the pinkView:
        
        infoButtonWidthConstraint = HKNSLayoutConstraint(item: infoButton as Any, attribute: .width, altSecondItem: .uiItem(pinkView), altCalculationBasis: .width, altMultiplier: 0.5)
        
        // set the height of the info button to a constant of 40:
        
        infoButtonHeightConstraint = HKNSLayoutConstraint(item: infoButton as Any, attribute: .height, altSecondItem: .notAnItem, altCalculationBasis: .constant, constant: 40.0)
        
        infoButtonWidthConstraint?.isActive = true
        infoButtonHeightConstraint?.isActive = true
        
    }

}

