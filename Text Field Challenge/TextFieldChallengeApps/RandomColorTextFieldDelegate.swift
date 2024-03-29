//  Created by Marcus Hernandez on 7/1/2016
import Foundation
import UIKit
class RandomColorTextFieldDelegate: NSObject, UITextFieldDelegate {
    let colors = [UIColor.redColor(),
        UIColor.orangeColor(), UIColor.yellowColor(),
        UIColor.greenColor(), UIColor.blueColor(),
        UIColor.purpleColor(), UIColor.brownColor()];
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        textField.textColor = self.randomColor()
        return true
    }
    func randomColor() -> UIColor {
        let randomIndex = Int(arc4random() % UInt32(colors.count))
        return colors[randomIndex]
    }
}