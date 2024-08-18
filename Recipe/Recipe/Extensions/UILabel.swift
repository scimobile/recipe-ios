//
//  UILabel.swift
//  Recipe
//
//  Created by Khine Khine Myat Noe on 14/08/2024.
//


import UIKit

extension UILabel {
    
    func setUnderlinedTextWithActions(fullText: String, underlinedWordsWithActions: [(word: String, action: () -> Void, font: UIFont?)]) {
        self.isUserInteractionEnabled = true
        let attributedString = NSMutableAttributedString(string: fullText)

        for item in underlinedWordsWithActions {
            let range = (fullText as NSString).range(of: item.word)

            // Apply the underline attribute
            attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range)
            
            // Apply the font if provided
            if let font = item.font {
                attributedString.addAttribute(.font, value: font, range: range)
            }
            
            // Add a custom attribute to store the action
            attributedString.addAttribute(NSAttributedString.Key(rawValue: "Action"), value: item.action, range: range)
        }

        self.attributedText = attributedString
        
        // Add a tap gesture recognizer to handle the tap
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOnLabel(_:)))
        self.addGestureRecognizer(tapGesture)
    }

    @objc private func handleTapOnLabel(_ gesture: UITapGestureRecognizer) {
        guard let label = gesture.view as? UILabel,
              let text = label.attributedText,
              let tapLocation = gesture.location(in: label) as CGPoint? else { return }
        
        let textStorage = NSTextStorage(attributedString: text)
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: label.bounds.size)
        
        textContainer.lineFragmentPadding = 0.0
        textContainer.maximumNumberOfLines = label.numberOfLines
        textContainer.lineBreakMode = label.lineBreakMode
        
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        // Calculate the tapped character index
        let characterIndex = layoutManager.characterIndex(for: tapLocation, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        
        // Check if the tapped character has an associated action
        if characterIndex < text.length {
            let attributes = text.attributes(at: characterIndex, effectiveRange: nil)
            if let action = attributes[NSAttributedString.Key(rawValue: "Action")] as? () -> Void {
                action() // Execute the action
            }
        }
    }
}
