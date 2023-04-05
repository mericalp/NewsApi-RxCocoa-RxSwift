//
//  OnboardingViewController.swift
//  NewsApp
//
//  Created by Meric Alp on 5.04.2023.
//

import UIKit

class OnboardingViewController: UIViewController {

    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var nxtButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var slides: [OnboardingSlide] = []
    var currentPage = 0 {
        didSet{
            pageController.currentPage = currentPage
            if currentPage == slides.count - 1{
                nxtButton.setTitle("Get Started", for: .normal)
            }else{
                nxtButton.setTitle("Next", for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 19/255, green: 21/255, blue: 26/255, alpha: 255/255)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        if let image1 = UIImage(named: "onboarding1") {
            slides.append(OnboardingSlide(title: "Create personalized news feeds, follow hundreds of sources", image: image1))
        }
        if let image2 = UIImage(named: "onboarding2") {
            slides.append(OnboardingSlide(title: "Stay up to date with the latest news", image: image2))
        }
        pageController.numberOfPages = slides.count
    }

    @IBAction func nextButtonClicked(_ sender: Any) {
        if currentPage == slides.count - 1  {
            let controller = storyboard?.instantiateViewController(withIdentifier: "homeNC") as! UINavigationController
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .flipHorizontal
            present(controller,animated: true,completion: nil)
        }else{
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
}

extension OnboardingViewController: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as! OnboardingCollectionViewCell
        cell.setup(slides[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            let width = scrollView.frame.width
            currentPage = Int(scrollView.contentOffset.x / width)
        }
    
    
}
