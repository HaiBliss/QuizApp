//
//  PopupImageViewController.swift
//  QuizApp
//
//  Created by Hải Vie 🇻🇳 on 29/07/2022.
//

import UIKit
import SDWebImage

class PopupImageViewController: UIViewController {
    @IBOutlet weak var shadowView: ShadowView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    var urlImage: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shadowView.setCorner(.allCorners)
        scrollView.setCorner(.allCorners)
        scrollView.maximumZoomScale = 4
        scrollView.minimumZoomScale = 1
        scrollView.delegate = self
        imageView.isUserInteractionEnabled = true
        bindData()
    }
    
    func bindData() {
        imageView.sd_setImage(with: URL(string: urlImage), placeholderImage: R.image.placeholder())
    }
    @IBAction func closeButtonAction(_ sender: Any) {
        dismiss(animated: false)
    }
}

extension PopupImageViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        if scrollView.zoomScale > 1 {
            if let image = imageView.image {
                let ratioW = imageView.frame.width / image.size.width
                let ratioH = imageView.frame.height / image.size.height
                
                let ratio = ratioW < ratioH ? ratioW : ratioH
                let newWidth = image.size.width * ratio
                let newHeight = image.size.height * ratio
                let conditionLeft = newWidth*scrollView.zoomScale > imageView.frame.width
                let left = 0.5 * (conditionLeft ? newWidth - imageView.frame.width : (scrollView.frame.width - scrollView.contentSize.width))
                let conditioTop = newHeight*scrollView.zoomScale > imageView.frame.height
                
                let top = 0.5 * (conditioTop ? newHeight - imageView.frame.height : (scrollView.frame.height - scrollView.contentSize.height))
                
                scrollView.contentInset = UIEdgeInsets(top: top, left: left, bottom: top, right: left)
                
            }
        } else {
            scrollView.contentInset = .zero
        }
    }
}
