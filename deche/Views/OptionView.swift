//
//  OptionView.swift
//  deche
//
//  Created by Doğukan Çatmakaş on 21.02.2024.
//

import SwiftUI

public struct OptionView: View {
    
    /// Enter the Options you want to offer here using an "Option" class.
    var options: [Option]
    
    /// Create a selectedOption value and assign it here. SelectedOption must be an "Option".
    @Binding var selectedOption: Option?
    
    // Other Parameters
    var defaultdOptionBackgroundColor: Color = .init(red: 0.080, green: 0.083, blue: 0.083)
    var selectedOptionBackgroundColor: Color = .init(red: 0.403, green: 0.404, blue: 0.463)
    var selectedOptionImage: Image = Image(systemName: "checkmark.circle.fill")
    var selectedOptionImageColor: Color = .white
    var optionCornerRadius: Double = 12
    var textColor: Color = .white
    
    public init(options: [Option], selectedOption: Binding<Option?>) {
        self.options = options
        self._selectedOption = selectedOption
    }
    
    public var body: some View {
        VStack {
            ForEach(options) { option in
                HStack {
                    // Option Text
                    Text(option.text)
                        .fontWeight(.medium)
                        .foregroundColor(textColor)
                    
                    Spacer()
                    
                    // Selected Icon
                    if option.id == selectedOption?.id {
                        selectedOptionImage
                            .foregroundColor(selectedOptionImageColor)
                    }
                }
                .padding()
                .background(option.id == selectedOption?.id ? selectedOptionBackgroundColor : defaultdOptionBackgroundColor)
                .cornerRadius(optionCornerRadius)
                .overlay(
                    RoundedRectangle(cornerRadius: optionCornerRadius)
                        .stroke(option.id == selectedOption?.id ? Color.white : Color.gray, lineWidth: 1)
                )
                .onTapGesture {
                    withAnimation(.spring) {
                        option.id == selectedOption?.id ? (selectedOption = nil) : (selectedOption = option)
                    }
                }
                
            }
            .padding(.top)
            
        }
        .padding(.horizontal)
    }
    
    /// Use to change the color of the unselected option background.
    public func defaultdOptionBackgroundColor(_ defaultColor: Color) -> OptionView {
        var option = self
        option.defaultdOptionBackgroundColor = defaultColor
        return option
    }
    
    /// Use to change the color of the selected option background.
    public func selectedOptionBackgroundColor(_ selectedColor: Color) -> OptionView {
        var selectedOption = self
        selectedOption.selectedOptionBackgroundColor = selectedColor
        return selectedOption
    }
    
    /// Use to change the icon of the selected option.
    public func selectedOptionImage(_ image: Image, imageColor: Color? = .white) -> OptionView {
        var selectedOption = self
        selectedOption.selectedOptionImage = image
        selectedOption.selectedOptionImageColor = imageColor ?? .white
        return selectedOption
    }
    
    /// Use to change the corner radius of the options.
    public func optionCornerRadius(_ radius: Double) -> OptionView {
        var option = self
        option.optionCornerRadius = radius
        return option
    }
    
    public func textColor(_ color: Color) -> OptionView {
        var option = self
        option.textColor = color
        return option
    }
    
}

public struct Option: Identifiable {
    
    public let id = UUID()
    public var text: String
}

#Preview {
    OptionView(options: [Option(text: "deneme1"), Option(text: "deneme2")], selectedOption: .constant(Option(text: "deneme1")))
}
