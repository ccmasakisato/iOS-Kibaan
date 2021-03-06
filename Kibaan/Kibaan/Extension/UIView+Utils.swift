import UIKit

public extension UIView {
    
    // MARK: - Computed Property

    /// SafeAreaの余白サイズ
    /// iOS11未満はサイズゼロの余白を返却する
    var safeAreaInsetsOrZero: UIEdgeInsets {
        if #available(iOS 11.0, *) {
            return safeAreaInsets
        }
        return UIEdgeInsets.zero
    }
    
    // MARK: - Function
    
    /// 角丸を設定する
    func setCornerRadius(corners: UIRectCorner, radius: CGFloat = 4) {
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set(value) {
            layer.cornerRadius = value
            clipsToBounds = 0 < value
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            if let cgColor = layer.borderColor {
                return UIColor(cgColor: cgColor)
            }
            return nil
        }
        set(value) {
            layer.borderColor = value?.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set(value) {
            layer.borderWidth = value
        }
    }
    
    // MARK: - Function
    
    /// グラデーションを設定する
    func setGradient(_ colors: [UIColor], startPoint: CGPoint, endPoint: CGPoint) {
        let cgColors = colors.map { $0.cgColor }
        
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = cgColors
        gradientLayer.frame = bounds
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        
        removeGradient()
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    /// グラデーションを削除する
    func removeGradient() {
        layer.sublayers?.filter { $0 as? CAGradientLayer != nil }.forEach {
            $0.removeFromSuperlayer()
        }
    }
}
