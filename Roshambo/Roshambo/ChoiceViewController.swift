import UIKit

class ChoiceViewController: UIViewController {

    
    // Rock - code
    @IBAction private func playRock(sender: UIButton) {
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("ResultsViewController") as! ResultsViewController
        vc.userChoice = getUserShape(sender)
        presentViewController(vc, animated: true, completion: nil)
    }
    
    
    // Paper - code with segue
    @IBAction private func playPaper(sender: UIButton) {
        performSegueWithIdentifier("play", sender: sender)
    }

    
    // Scissors - segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "play" {
            let vc = segue.destinationViewController as! ResultsViewController
            vc.userChoice = getUserShape(sender as! UIButton)
        }
    }


    // Shape = move
    private func getUserShape(sender: UIButton) -> Shape {
        let shape = sender.titleForState(.Normal)!
        return Shape(rawValue: shape)!
    }

}
