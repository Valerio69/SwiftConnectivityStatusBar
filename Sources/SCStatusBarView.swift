import Foundation
import UIKit
import PinLayout

class SCStatusBarView: UIView {
  
  private let statusString: String
  private lazy var contentView: UIView = {
    let view = UIView()
    view.backgroundColor = .red
    view.alpha = 0.5
    return view
  }()
  
  private lazy var statusLabel: UILabel = {
    let label = UILabel()
    label.text = statusString
    label.textColor = .white
    label.font = UIFont.preferredFont(forTextStyle: .footnote)
    label.adjustsFontForContentSizeCategory = true
    return label
  }()
  
  init(statusString: String) {
    self.statusString = statusString
    super.init(frame: .zero)
    
    self.backgroundColor = .white
    self.addSubview(contentView)
    self.addSubview(statusLabel)
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
}
