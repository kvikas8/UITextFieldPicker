# UITextFieldPicker
An easy to use extension of UITextField to add dropdown using UIPickerView

## Usage
Just need to assign array of strings to textfield as shown below, rest all will be handled by Extension
```
@IBOutlet var yourTextField: UITextField! // TextfieldOutlet

let dropDownArray = ["Apple", "Mango", "Pine Apple", "StrawBerry"]
yourTextField.addDropDownAsInput(withArray: dropDownArray ?? [])
```
## DropDownDelegate
Assign delegate to your controller 
```
yourTextField.dropDownDelegate = self
```
And listen to Changes
```
extension YourController: DropDownDelegate {
    func dropdownDidChangeValue(textfield: UITextField, title: String, index: Int) {
        print("value did changed")
    }
}

```
