//
//  AAMaterialTextInput.swift
//  AAMaterialText
//
//  Created by Muhammad Ahsan Ali on 2020/05/31.
//

import UIKit


open class AAMaterialTextInput: UIControl {
    
    let borderView = BorderView()
    let placeholderLayer = VerticallyCenteredTextLayer()
    var isResigningResponder = false
    var isPlaceholderAsHint = false
    open var textInput: AAInputField!
    var placeholderErrorText: String?
    var borderTop: NSLayoutConstraint?
    
    open var tapAction: (() -> Void)?

    open var textDidChange: ((String) -> Void)?
    
    open var stateDidChange: ((Bool) -> Void)?

    open fileprivate(set) var isActive = false {
        didSet {
            stateDidChange?(isActive)
        }
    }
    
    open var autocorrection: UITextAutocorrectionType = .no {
        didSet {
            textInput.autocorrection = autocorrection
        }
    }
    
    @available(iOS 10.0, *)
    open var textContentType: UITextContentType {
        get { return textInput.currentTextContentType }
        set { textInput.currentTextContentType = newValue }
    }
    
    open var returnKeyType: UIReturnKeyType = .default {
        didSet {
            textInput.changeReturnKeyType(with: returnKeyType)
        }
    }
    
    open var keyboardAppearance: UIKeyboardAppearance {
        get { return textInput.currentKeyboardAppearance }
        set { textInput.currentKeyboardAppearance = newValue }
    }
    
    open var clearButtonMode: UITextField.ViewMode = .whileEditing {
        didSet {
            textInput.changeClearButtonMode(with: clearButtonMode)
        }
    }
    
    open var placeHolderText = "Placeholder" {
        didSet {
            placeholderLayer.string = placeHolderText
        }
    }
    
    open var placeholderAlignment: CATextLayerAlignmentMode = .natural {
        didSet {
            placeholderLayer.alignmentMode = placeholderAlignment
        }
    }
    
    open var style: AAMaterialStyle = AAMaterialDefaultStyle() {
        didSet {
            configureStyle()
        }
    }
    
    open var text: String? {
        get {
            return textInput.currentText
        }
        set {
            (newValue != nil && !newValue!.isEmpty) ? layerInactiveHint() : layerHintDefault()
            textInput.currentText = newValue
        }
    }
    
    open var selectedTextRange: UITextRange? {
        get { return textInput.currentSelectedTextRange }
        set { textInput.currentSelectedTextRange = newValue }
    }
    
    open var beginningOfDocument: UITextPosition? {
        get { return textInput.currentBeginningOfDocument }
    }
    
    open var font: UIFont? {
        get { return textInput.font }
        set { textAttributes = [NSAttributedString.Key.font: newValue as Any] }
    }
    
    open var textColor: UIColor? {
        get { return textInput.textColor }
        set { textAttributes = [NSAttributedString.Key.foregroundColor: newValue as Any] }
    }
    
    open var lineSpacing: CGFloat? {
        get {
            guard let paragraph = textAttributes?[NSAttributedString.Key.paragraphStyle] as? NSParagraphStyle else { return nil }
            return paragraph.lineSpacing
        }
        set {
            guard let spacing = newValue else { return }
            let paragraphStyle = textAttributes?[NSAttributedString.Key.paragraphStyle] as? NSMutableParagraphStyle ?? NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = spacing
            textAttributes = [NSAttributedString.Key.paragraphStyle: paragraphStyle]
        }
    }
    
    open var textAlignment: NSTextAlignment? {
        get {
            guard let paragraph = textInput.textAttributes?[NSAttributedString.Key.paragraphStyle] as? NSParagraphStyle else { return nil }
            return paragraph.alignment
        }
        set {
            guard let alignment = newValue else { return }
            let paragraphStyle = textAttributes?[NSAttributedString.Key.paragraphStyle] as? NSMutableParagraphStyle ?? NSMutableParagraphStyle()
            paragraphStyle.alignment = alignment
            textAttributes = [NSAttributedString.Key.paragraphStyle: paragraphStyle]
        }
    }
    
    open var tailIndent: CGFloat? {
        get {
            guard let paragraph = textAttributes?[NSAttributedString.Key.paragraphStyle] as? NSParagraphStyle else { return nil }
            return paragraph.tailIndent
        }
        set {
            guard let indent = newValue else { return }
            let paragraphStyle = textAttributes?[NSAttributedString.Key.paragraphStyle] as? NSMutableParagraphStyle ?? NSMutableParagraphStyle()
            paragraphStyle.tailIndent = indent
            textAttributes = [NSAttributedString.Key.paragraphStyle: paragraphStyle]
        }
    }
    
    open var headIndent: CGFloat? {
        get {
            guard let paragraph = textAttributes?[NSAttributedString.Key.paragraphStyle] as? NSParagraphStyle else { return nil }
            return paragraph.headIndent
        }
        set {
            guard let indent = newValue else { return }
            let paragraphStyle = textAttributes?[NSAttributedString.Key.paragraphStyle] as? NSMutableParagraphStyle ?? NSMutableParagraphStyle()
            paragraphStyle.headIndent = indent
            textAttributes = [NSAttributedString.Key.paragraphStyle: paragraphStyle]
        }
    }
    
    open var textAttributes: [NSAttributedString.Key: Any]? {
        didSet {
            guard var textInputAttributes = textInput.textAttributes else {
                textInput.textAttributes = textAttributes
                return
            }
            guard textAttributes != nil else {
                textInput.textAttributes = nil
                return
            }
            textInput.textAttributes = textInputAttributes.merge(dict: textAttributes!)
        }
    }
    
    open func configureInputView(_ view: UIView) {
        textInput.configureInputView(newInputView : view)
    }
    
    private var _inputAccessoryView: UIView?
    
    open override var inputAccessoryView: UIView? {
        set { _inputAccessoryView = newValue }
        get { _inputAccessoryView }
    }
    
    open var contentInset: UIEdgeInsets? {
        didSet {
            guard let insets = contentInset else { return }
            textInput.contentInset = insets
        }
    }
    
    
    public init(_ type: AAInputField) {
        super.init(frame: .zero)
        self.textInput = type
        textInput.view.removeFromSuperview()
        setup()
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open override func updateConstraints() {
        
        pinConstraint(borderView, type: .leading, constant: 0)
        pinConstraint(borderView, type: .trailing, constant: 0)
        pinConstraint(borderView, type: .bottom, constant: 0)
        textInput.view.pinConstraint(borderView, type: .bottom, constant: 0)
        
        borderView.pinConstraint(textInput.view, type: .leading, constant: style.margin.left)
        borderView.pinConstraint(textInput.view, type: .trailing, constant: -style.margin.right)
        textInput.view.pinConstraint(borderView, type: .top, constant: 0)
        
        updateBorderTop()
        super.updateConstraints()
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        layoutPlaceholderLayer()
    }
    
    override open var intrinsicContentSize: CGSize {
        var calculated = hintHeightCalculated
        if calculated > style.placeholderMinFont + style.margin.bottom {
            calculated -= (style.placeholderMinFont + style.placeholderMinFont)
        }
        let newHeight = style.margin.bottom + calculated
        return CGSize(width: UIView.noIntrinsicMetric, height: newHeight)
    }
    
    fileprivate func setup() {
        addLine()
        addPlaceHolder()
        addTapGestureRecognizer()
        addTextInput()
        configureStyle()
    }
    
    fileprivate func addLine() {
        borderView.defaultColor = style.borderColor.0
        borderView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(borderView)
        sendSubviewToBack(borderView)
        borderView.layer.borderWidth = 1
        borderView.layer.borderColor = style.borderColor.1.cgColor
    }
    
    fileprivate func addPlaceHolder() {
        placeholderLayer.masksToBounds = true
        placeholderLayer.string = placeHolderText
        placeholderLayer.foregroundColor = style.borderColor.1.cgColor
        placeholderLayer.fontSize = style.inputFont.pointSize
        placeholderLayer.font = style.inputFont
        placeholderLayer.alignmentMode = placeholderAlignment
        placeholderLayer.contentsScale = UIScreen.main.scale
        placeholderLayer.backgroundColor = UIColor.clear.cgColor
        placeholderLayer.isWrapped = true
        layer.addSublayer(placeholderLayer)
    }
    
    fileprivate func addTapGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewWasTapped))
        addGestureRecognizer(tap)
    }
    
    fileprivate func addTextInput() {
        textInput.textInputDelegate = self
        textInput.view.tintColor = style.borderColor.0
        textInput.textColor = style.inputColor
        textInput.font = style.inputFont
        textInput.autocorrection = autocorrection
        textInput.view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(textInput.view)
        invalidateIntrinsicContentSize()
    }
        
    fileprivate func layerActiveHint() {
        isPlaceholderAsHint = true
        configurePlaceholderWith(fontSize: style.placeholderMinFont,
                                 foregroundColor: style.borderColor.0.cgColor,
                                 text: placeHolderText)
        borderView.changeColor(with: style.borderColor.0)
        
        placeholderLayer.backgroundColor = backgroundColor?.cgColor ?? UIColor.white.cgColor
    }
    
    fileprivate func layerInactiveHint() {
        isPlaceholderAsHint = true
        configurePlaceholderWith(fontSize: style.placeholderMinFont,
                                 foregroundColor: style.borderColor.1.cgColor,
                                 text: placeHolderText)
        borderView.animateState()
        
    }
    
    fileprivate func layerHintDefault() {
        isPlaceholderAsHint = false
        configurePlaceholderWith(fontSize: style.inputFont.pointSize,
                                 foregroundColor: style.borderColor.1.cgColor,
                                 text: placeHolderText)
        borderView.animateState()
        placeholderLayer.backgroundColor = backgroundColor?.cgColor ?? UIColor.white.cgColor
        
        
    }
    
    fileprivate func configurePlaceholderAsErrorHint() {
        isPlaceholderAsHint = true
        configurePlaceholderWith(fontSize: style.placeholderMinFont,
                                 foregroundColor: style.borderColor.2.cgColor,
                                 text: placeholderErrorText)
        borderView.changeColor(with: style.borderColor.2)
        
    }
    
    fileprivate func configurePlaceholderWith(fontSize: CGFloat, foregroundColor: CGColor, text: String?) {
        placeholderLayer.fontSize = fontSize
        placeholderLayer.foregroundColor = foregroundColor
        placeholderLayer.string = text
        layoutPlaceholderLayer()
    }
    
    fileprivate func animateHintLayer(to applyConfiguration: () -> Void) {
        let duration = 0.2
        let function = CAMediaTimingFunction(controlPoints: 0.3, 0.0, 0.5, 0.95)
        transactionAnimation(with: duration, timingFuncion: function, animations: applyConfiguration)
        updateBorderTop()

    }
        
    @objc fileprivate func viewWasTapped(sender: UIGestureRecognizer) {
        tapAction?()
    }
    
    fileprivate func styleDidChange() {
        borderView.defaultColor = style.borderColor.1
        placeholderLayer.foregroundColor = style.borderColor.1.cgColor
        let fontSize = style.inputFont.pointSize
        placeholderLayer.fontSize = fontSize
        placeholderLayer.font = style.inputFont
        textInput.view.tintColor = style.borderColor.0
        textInput.textColor = style.inputColor
        textInput.font = style.inputFont
        borderView.layer.cornerRadius = style.cornerRadius
        invalidateIntrinsicContentSize()
        layoutIfNeeded()

    }
    
    @discardableResult
    override open func becomeFirstResponder() -> Bool {
        isActive = true
        let firstResponder = textInput.view.becomeFirstResponder()
        placeholderErrorText = nil
        animateHintLayer(to: layerActiveHint)
        return firstResponder
    }
    
    override open var isFirstResponder: Bool {
        return textInput.view.isFirstResponder
    }
    
    @discardableResult
    override open func resignFirstResponder() -> Bool {
        guard !isResigningResponder else { return true }
        isActive = false
        isResigningResponder = true
        let resignFirstResponder = textInput.view.resignFirstResponder()
        isResigningResponder = false
        
        if let textInputError = textInput as? TextInputError {
            textInputError.removeErrorHintMessage()
        }
        
        if placeholderErrorText == nil {
            animateToInactiveState()
        }
        return resignFirstResponder
    }
    
    fileprivate func animateToInactiveState() {
        guard let text = textInput.currentText, !text.isEmpty else {
            animateHintLayer(to: layerHintDefault)
            return
        }
        animateHintLayer(to: layerInactiveHint)
    }
    
    override open var canResignFirstResponder: Bool {
        return textInput.view.canResignFirstResponder
    }
    
    override open var canBecomeFirstResponder: Bool {
        guard !isResigningResponder else { return false }
        return textInput.view.canBecomeFirstResponder
    }
    
    open func changeBorder(_ isError: Bool) {
        if isError {
            show(error: placeHolderText, placeholderText: nil)
        }
        else {
            clearError()
        }

    }
    
    open func show(error errorMessage: String, placeholderText: String? = nil) {
        placeholderErrorText = errorMessage
        if let textInput = textInput as? TextInputError {
            textInput.configureErrorState(with: placeholderText)
        }
        animateHintLayer(to: configurePlaceholderAsErrorHint)
        
    }
    
    open func clearError() {
        placeholderErrorText = nil
        if let textInputError = textInput as? TextInputError {
            textInputError.removeErrorHintMessage()
        }
        if isActive {
            animateHintLayer(to: layerActiveHint)
        } else {
            animateToInactiveState()
        }
        
    }
    
    fileprivate func configureStyle() {
        styleDidChange()
        if isActive {
            layerActiveHint()
        } else {
            isPlaceholderAsHint ? layerInactiveHint() : layerHintDefault()
        }
    }
    
    open func setText(_ textString: String) {
        text = textString
        textDidChange?(textString)
    }
    
}



extension AAMaterialTextInput: AAMaterialDelegate {
    
    open func textInputDidBeginEditing(textInput: AAInputField) {
        becomeFirstResponder()
    }
    
    open func textInputDidEndEditing(textInput: AAInputField) {
        resignFirstResponder()
    }
    
    open func textInputDidChange(textInput: AAInputField) {
        sendActions(for: .editingChanged)
        textDidChange?(textInput.currentText!)
    }
    
    open func textInput(textInput: AAInputField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    open func textInputShouldBeginEditing(textInput: AAInputField) -> Bool {
        return true
    }
    
    open func textInputShouldEndEditing(textInput: AAInputField) -> Bool {
        return true
    }
    
    open func textInputShouldReturn(textInput: AAInputField) -> Bool {
        return true
    }
}


// MARK:- Hint calculations
fileprivate extension AAMaterialTextInput {

    var hintHeightCalculated: CGFloat {
        if let maxWidth = superview?.bounds.size.width {
            let placeholderWidth = maxWidth - (style.margin.left + style.margin.bottom + style.margin.right + style.margin.top)
            return style.inputFont.calculateHeight(text: placeHolderText, width: placeholderWidth)
        }
        return .zero
    }
    
    var hintSize: CGSize {
        var width = placeHolderText.widthOfString(usingFont: style.inputFont) + 20
        let maxWidth = textInput.view.bounds.size.width
        let placeholderWidth = maxWidth - style.margin.right
        if width > placeholderWidth {
            width = placeholderWidth
        }
        let height = placeHolderText.height(withConstrainedWidth: width, font: style.inputFont)
        return CGSize(width: width, height: height)
    }
    
    
    func updateBorderTop() {
        
        if borderTop == nil {
            borderTop = pinConstraint(borderView, type: .top, constant: style.margin.top)
        }
        let borderTop = self.borderTop!
        
        let calculatedHeight = hintSize.height
        
        if calculatedHeight > style.placeholderMinFont {
            if let text = text, text.isEmpty, !isActive {
                borderTop.constant = style.margin.top
            }
            else if calculatedHeight > style.margin.top + borderTop.constant {
                borderTop.constant = calculatedHeight - style.margin.top
            }
        }
    
    }
    
    func layoutPlaceholderLayer() {
        var hintHeight: CGFloat = 0
        let hintSize = self.hintSize
        let calculated = hintSize.height
        if calculated > style.placeholderMinFont + style.margin.bottom {
            hintHeight += style.margin.top
        }
        var placeholderPosition: CGPoint {
            let hintPosition = CGPoint(
                x: placeholderAlignment != .natural ? 0 : style.margin.left,
                y: hintHeight
            )
            
            let defaultPosition = CGPoint(
                x: placeholderAlignment != .natural ? 0 : style.margin.left,
                y: (style.margin.bottom + style.margin.top)/2
            )
            return isPlaceholderAsHint ? hintPosition : defaultPosition
        }
        placeholderLayer.frame = CGRect(origin: placeholderPosition, size: hintSize)
    }
    
    var intrinsicContentHeight: CGFloat {
        textInput.view.intrinsicContentSize.height
    }
    
    
}


internal class VerticallyCenteredTextLayer: CATextLayer {
    
    override func draw(in ctx: CGContext) {
        ctx.saveGState()
        ctx.translateBy(x: 10, y: 0)
        super.draw(in: ctx)
        ctx.restoreGState()
    }
}
