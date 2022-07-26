//
//  ImagePopupViewController.swift
//  QuizApp
//
//  Created by Hải Vie 🇻🇳 on 25/07/2022.
//

import UIKit
import SDWebImage

class ImagePopupViewController: UIViewController {

    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var shadowView: ShadowView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        shadowView.setCorner(.allCorners)
        scrollView.maximumZoomScale = 4
        scrollView.maximumZoomScale = 1
        scrollView.delegate = self
    }
    
    func bindData(urlImage: String) {
        imageView.sd_setImage(with: URL(string: urlImage), placeholderImage: R.image.placeholder())
    }

    @IBAction func closeButtonAction(_ sender: Any) {
        dismiss(animated: true)
    }
}

extension ImagePopupViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        if scrollView.zoomScale > 1  {
            if let image = imageView.image {
                let ratioW = imageView.frame.width / image.size.width
                let ratioH = imageView.frame.height / image.size.height
                
                let ratio = ratioW < ratioH ? ratioW : ratioH
                let newWidth = image.size.width * ratio
                let newHeight = image.size.height * ratio
                
                let conditionLeft = newWidth * scrollView.zoomScale > imageView.frame.width
                
                let left = 0.5 * (conditionLeft ? newWidth - imageView.frame.width : (scrollView.frame.width - scrollView.contentSize.width))
                
                let conditionTop = newHeight * scrollView.zoomScale > imageView.frame.height
                
                let top = 0.5 * (conditionTop ? newHeight - imageView.frame.height : (scrollView.frame.height - scrollView.contentSize.height))
                
                scrollView.contentInset = UIEdgeInsets(top: top, left: left, bottom: top, right: left)
            }
        } else {
            scrollView.contentInset = .zero
        }
    }
}
