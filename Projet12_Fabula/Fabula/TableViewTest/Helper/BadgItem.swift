

import UIKit

public enum BadgePosition {
    case left
    case right
}

public enum BadgeSize {
    case extraSmall
    case small
    case medium
    case large
}

/// button to display favorite count under the favorite button in anecdoteViewController
public class BadgedButtonItem: UIBarButtonItem {
    
    static var shared: BadgedButtonItem = {
        let badgeButton = BadgedButtonItem(with: UIImage(systemName: "heart")?.withTintColor(UIColor.white))
        badgeButton.badgeTintColor = .white
        badgeButton.badgeTextColor = .black
        badgeButton.position = .right
        badgeButton.badgeSize = .small
        badgeButton.hasBorder = true
        badgeButton.borderColor = .black
        badgeButton.badgeSize = .medium
        badgeButton.badgeAnimation = true
        return badgeButton
    }()
    
    func setBadge(with value: Int?) {
        self.badgeValue = value
    }
    
    var badgeTintColor: UIColor? {
        didSet {
            lblBadge.backgroundColor = badgeTintColor
        }
    }
    
    var badgeTextColor: UIColor? {
        didSet {
            lblBadge.textColor = badgeTextColor
        }
    }
    
    var position: BadgePosition? = .right {
        didSet {
            if position == .left {
                self.lblBadge.frame = CGRect(x: 0,
                                             y: 0,
                                             width: badgeRadius * 2,
                                             height: badgeRadius * 2)
            } else {
                self.lblBadge.frame = CGRect(x: filterBtn.frame.maxX - badgeRadius * 1.4,
                                             y: 0,
                                             width: badgeRadius * 2,
                                             height: badgeRadius * 2)
            }
        }
    }
    
    var hasBorder: Bool? {
        didSet {
            if hasBorder == true {
                lblBadge.layer.borderWidth = 1.0
            }
        }
    }
    
    var borderColor: UIColor? = .black {
        didSet {
            lblBadge.layer.borderColor = borderColor?.cgColor
        }
    }
    
    var badgeSize: BadgeSize = .medium {
        didSet {
            switch badgeSize {
            case .extraSmall:
                self.badgeRadius = 6.0
            case .small:
                self.badgeRadius = 7.0
            case .medium:
                self.badgeRadius = 8.0
            case .large:
                self.badgeRadius = 9.0
            }
        }
    }
    
    var badgeAnimation: Bool? = false {
        didSet {
            self.isAnimated = badgeAnimation
        }
    }
    
    var tapAction: (() -> Void)?
    
    var badgeValue: Int? {
        didSet {
            if let value = badgeValue,
               value > 0 {
                
                // reducing font size if the value has two digits
                if "\(value)".count > 1 {
                    lblBadge.font = UIFont.systemFont(ofSize: twoDigitsFontSize)
                } else {
                    lblBadge.font = UIFont.systemFont(ofSize: oneDigitFontSize)
                }
                
                lblBadge.isHidden = false
                lblBadge.text = "\(value)"
                animateBadge(isAnimated)
            } else {
                lblBadge.isHidden = true
            }
        }
    }
    
    
    private let filterBtn = UIButton()
    private let lblBadge = UILabel()
    private var isAnimated: Bool? = false
    private var badgeRadius: CGFloat = 8.0 {
        didSet {
            self.lblBadge.layer.cornerRadius = badgeRadius
        }
    }
    
    private var oneDigitFontSize: CGFloat {
        return badgeRadius + 1
    }
    private var twoDigitsFontSize: CGFloat {
        return badgeRadius
    }
    
    override init() {
        super.init()
        setup()
    }
    
    init(with image: UIImage?) {
        super.init()
        setup(image: image)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup(image: UIImage? = nil) {
        
        self.filterBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        //        self.filterBtn.adjustsImageWhenHighlighted = false
        self.filterBtn.tintColor = .white
        self.filterBtn.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        self.filterBtn.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        self.lblBadge.frame = CGRect(x: filterBtn.frame.maxX - badgeRadius * 2,
                                     y: 0,
                                     width: badgeRadius * 2,
                                     height: badgeRadius * 2)
        self.lblBadge.backgroundColor = .white
        self.lblBadge.clipsToBounds = true
        self.lblBadge.layer.cornerRadius = badgeRadius
        self.lblBadge.textColor = .white
        self.lblBadge.font = UIFont.systemFont(ofSize: 10)
        self.lblBadge.textAlignment = .center
        self.lblBadge.isHidden = true
        self.lblBadge.minimumScaleFactor = 0.5
        self.lblBadge.adjustsFontSizeToFitWidth = true
        self.filterBtn.addSubview(lblBadge)
        self.customView = filterBtn
    }
    
    @objc private func buttonPressed() {
        if let action = tapAction {
            action()
        }
    }
    
    private func animateBadge(_ animate: Bool?) {
        guard animate == true else { return }
        lblBadge.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        UIView.animate(withDuration: 0.4,
                       delay: 0,
                       usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 3,
                       options: [.curveLinear],
                       animations: { [weak self] in
            
            guard let strongSelf = self else { return }
            strongSelf.lblBadge.transform = .identity
            
        }) { [weak self] (finished) in
            
            guard let strongSelf = self else { return }
            if !finished {
                strongSelf.lblBadge.transform = .identity
            }
        }
    }
    
}
