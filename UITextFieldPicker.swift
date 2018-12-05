var AssociatedObjectHandle: UInt8 = 0

extension UITextField: UIPickerViewDataSource, UIPickerViewDelegate {
 
        public static var _pickerArray = [String: [String]]()
        public static var _pickerView = [String: UIPickerView]()
   

    var dropDownDelegate: DropDownDelegate? {
        get {
            return objc_getAssociatedObject(self, &AssociatedObjectHandle) as? DropDownDelegate
        }
        set {
            objc_setAssociatedObject(self, &AssociatedObjectHandle, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
        var pickerArray:[String] {
            get {
                let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
                return UITextField._pickerArray[tmpAddress] ?? []
    
            }
            set(newValue) {
    
                let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
                UITextField._pickerArray[tmpAddress] = newValue
            }
        }
    
    var pickerView: UIPickerView {
        get {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            return UITextField._pickerView[tmpAddress] ?? UIPickerView()
            
        }
        set(newValue) {
            
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            UITextField._pickerView[tmpAddress] = newValue
        }
    }
    
    
    func addDropDownasInput(withArray: [String]) {
        self.pickerArray = withArray
        self.pickerView =  UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        self.inputView = pickerView
        let toolBar = UIToolbar.init(frame: CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: UIScreen.main.bounds.size.width, height: 40)))
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(UITextField.donePressed))
            toolBar.setItems([doneButton], animated: true)
        toolBar.barStyle = UIBarStyle.blackTranslucent
        toolBar.tintColor = UIColor.white
        toolBar.backgroundColor = UIColor.black
        self.inputAccessoryView = toolBar
    }
    
    @objc func donePressed() {
        resignFirstResponder()
       let index = self.pickerView.selectedRow(inComponent: 0)
        self.text = pickerArray[index]
    }
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerArray.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerArray[row]
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.text = pickerArray[row]
        self.dropDownDelegate?.dropdownDidChangeValue(textfield: self, title: pickerArray[row], index: row)
    }
    
}
