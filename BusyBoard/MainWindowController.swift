import Cocoa

class MainWindowController: NSWindowController {
    
    //MARK - Outlets
    
    @IBOutlet weak var sliderDirectionLabel: NSTextField!
    @IBOutlet weak var verticalSlider: NSSlider!
    @IBOutlet weak var showTickMarksButton: NSButton!
    @IBOutlet weak var hideTickMarksButton: NSButton!
    @IBOutlet weak var checkmarkButton: NSButton!
    @IBOutlet weak var secureTextField: NSSecureTextField!
    @IBOutlet weak var normalTextField: NSTextField!
    
    //MARK: - Properties
    
    var lastKnownSliderValue: Double = 0.0
    var showTickMarks: Bool = false
    var checkmarkIsChecked: Bool = true
    
    override var windowNibName: String? {
        return "MainWindowController"
    }
    
    //MARK: - NSWindowController
    
    override func windowDidLoad() {
        super.windowDidLoad()
        updateUI()
    }
    
    //MARK - Actions
    
    @IBAction func sliderAction(sender: NSSlider) {
        if verticalSlider.doubleValue > lastKnownSliderValue {
            sliderDirectionLabel.stringValue = "Slider is going up"
        } else {
            sliderDirectionLabel.stringValue = "Slider is going down"
        }
        lastKnownSliderValue = verticalSlider.doubleValue
    }
    
    @IBAction func toggleShowTickMarks(sender: NSButton) {
        if sender.tag == 1 {
            showTickMarks = true
        } else {
            showTickMarks = false
        }
        updateUI()
    }
    
    @IBAction func checkmarkButtonAction(sender: NSButton) {
        if sender.state == NSOnState {
            checkmarkIsChecked = true
        } else {
            checkmarkIsChecked = false
        }
        updateUI()
    }
    
    @IBAction func revealSecretMessage(sender: NSButton) {
        updateUI()
    }
    
    @IBAction func resetWindow(sender: NSButton) {
        lastKnownSliderValue = 0.0
        showTickMarks = false
        checkmarkIsChecked = true
        secureTextField.stringValue = ""
        updateUI()
    }
    
    //MARK: - Private
    
    func updateUI() {
        verticalSlider.doubleValue = lastKnownSliderValue
        sliderDirectionLabel.stringValue = ""
        updateCheckmark()
        updateSecureTextFieldToMatchNormalTextField()
        updateSliderPreferenceRadioButtons()
    }
    
    func updateCheckmark() {
        if checkmarkIsChecked {
            checkmarkButton.state = NSOnState
            checkmarkButton.title = "Uncheck me"
        } else {
            checkmarkButton.state = NSOffState
            checkmarkButton.title = "Check me"
        }
    }
    
    func updateSecureTextFieldToMatchNormalTextField() {
        normalTextField.stringValue = secureTextField.stringValue
    }
    
    func updateSliderPreferenceRadioButtons() {
        if showTickMarks {
            verticalSlider.numberOfTickMarks = 15
            showTickMarksButton.state = NSOnState
            hideTickMarksButton.state = NSOffState
        } else {
            verticalSlider.numberOfTickMarks = 0
            showTickMarksButton.state = NSOffState
            hideTickMarksButton.state = NSOnState
        }
    }
}
