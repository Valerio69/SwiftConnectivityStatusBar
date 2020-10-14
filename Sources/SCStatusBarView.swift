import Foundation
import UIKit
import PinLayout

public struct SCStatusBarStyle {
  let statusString: String
  let backgroundColor: UIColor
}

class SCStatusBarView: UIView {
  
  private var style: SCStatusBarStyle {
    didSet {
      contentView.backgroundColor = style.backgroundColor
      statusLabel.text = style.statusString
    }
  }

  private lazy var contentView: UIView = {
    let view = UIView()
    view.backgroundColor = style.backgroundColor
    return view
  }()
  
  private lazy var statusLabel: UILabel = {
    let label = UILabel()
    label.text = style.statusString
    label.textColor = .white
    label.font = UIFont.preferredFont(forTextStyle: .footnote)
    label.adjustsFontForContentSizeCategory = true
    return label
  }()
  
  init(style: SCStatusBarStyle) {
    self.style = style
    super.init(frame: .zero)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    statusLabel.sizeToFit()
    
    contentView.pin.all()
    statusLabel.pin.hCenter().bottom(6)
    
  }
  
  func setStatusLabelString(_ string: String) {
    statusLabel.text = string
  }
  
  func refreshStyle(style: SCStatusBarStyle) {
    self.style = style
  }
}
