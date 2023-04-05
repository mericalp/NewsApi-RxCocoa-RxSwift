//
//  NewsViewController.swift
//  NewsApp
//
//  Created by Meric Alp on 4.04.2023.
//

import UIKit
import RxSwift
import RxCocoa
import SDWebImage
import SafariServices

class NewsViewController: UIViewController,UICollectionViewDelegateFlowLayout {
    @IBOutlet var newsCollectionView: UICollectionView!
    
    let disposeBag = DisposeBag()
    private var articleListVM: ArticleListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 18/255, green: 22/255, blue: 26/255, alpha: 255/255)
        newsCollectionView.delegate = self
        newsCollectionView.dataSource = self
        populateNews()
        let nibCell = UINib(nibName: "NewsCollectionViewCell", bundle: nil)
        newsCollectionView.register(nibCell, forCellWithReuseIdentifier: "cell")
        
    }
    
    /// We create a resources to get the latest news from New Api. It will be a valuable "Articleresponse" object.
    /// It creates a resource using the Urlrequest object and uploads it. The process is performed using a subscribe function.
    /// Article Response The Article feature of this object is used as a source for the Article List Viewmodel class and the data is renewed for the display of CollectionView.
    private func populateNews() {
        let resource = Resource<ArticleResponse>(url: URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=0cf790498275413a9247f8b94b3843fd")!)
        
        URLRequest.load(resource: resource)
            .subscribe(onNext: { articleResponse in
                let articles = articleResponse.articles
                self.articleListVM = ArticleListViewModel(articles)
                
                DispatchQueue.main.async {
                    self.newsCollectionView.reloadData()
                }
            }).disposed(by: disposeBag)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 2 - 10
        return CGSize(width: width, height: 320)
    }
 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}

extension NewsViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.articleListVM == nil ? 0: self.articleListVM.articleVM.count
    }
    
    /// hücrenin resmi, articleVM.image ile bir Observable olarak bağlanır. asObservable() operatörü, BehaviorRelay sınıfından gelen veriyi bir Observablea dönüştürür. observeOn operatörü, aboneliğin ana iş parçacığına geçiş yapmasını sağlar ve subscribe(onNext:) metodu, veri değiştiğinde hücrenin resmini güncellemek için bir kapatıcı sağlar.
    /// The picture of the cell is connected as an observable with Articlevm.image. The Asobservable () operator converts data from the Behaviorrelay class with an observation. The Observeon operator allows the subscription to switch to the main thread, and the subscribe (onnext :) method provides a concealer to update the picture of the cell when the data changes.
    /// Articlelevm.title and Articlelevm.Description properties are also dried with title and description labels respectively, which means that they are connected with drivers. The Operator Operator provides a default value to return when an error occurs.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = newsCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! NewsCollectionCell
        let articleVM = self.articleListVM.articleAt(indexPath.row)
        
        articleVM.image
            .asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { url in
                guard let imageURL = URL(string: url) else { return }
                cell.imageNews?.sd_setImage(with: imageURL, completed: nil)
            })
            .disposed(by: disposeBag)
        
        articleVM.title.asDriver(onErrorJustReturn: "")
            .drive(cell.titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        articleVM.description.asDriver(onErrorJustReturn: "")
            .drive(cell.descriptionLabel.rx.text)
            .disposed(by: disposeBag)
        
//        articleVM.url.asDriver(onErrorJustReturn: "")
//            .drive(cell.url.rx.text)
//            .disposed(by: disposeBag)
     
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let urlObservable = articleListVM.articleAt(indexPath.row).url
        
        urlObservable.subscribe(onNext: { urlString in
            guard let url = URL(string: urlString) else {
                return
            }
            let safariVC = SFSafariViewController(url: url)
            self.present(safariVC, animated: true, completion: nil)
//          UIApplication.shared.open (url)
        }).disposed(by: disposeBag)
    }
    
    
}
