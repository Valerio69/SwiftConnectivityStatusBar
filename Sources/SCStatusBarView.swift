import Foundation
import UIKit
import PinLayout

public struct SCStatusBarStyle {
  let statusString: String
  let backgroundColor: UIColor
  public init(statusString: String, backgroundColor: UIColor) {
    self.statusString = statusString
    self.backgroundColor = backgroundColor
  }
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
    backgroundColor = .white
    
    addSubview(contentView)
    contentView.addSubview(statusLabel)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    pin.width(100%)
    contentView.pin.all()
    statusLabel.sizeToFit()
    statusLabel.pin.bottom(6).horizontally(6)
  }
  
  func refreshStyle(style: SCStatusBarStyle) {
    self.style = style
  }
  
}
