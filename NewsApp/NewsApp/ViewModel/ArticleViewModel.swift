//
//  ArticleViewModel.swift
//  NewsApp
//
//  Created by Meric Alp on 4.04.2023.
//

import Foundation
import RxSwift
import RxCocoa


/// Articlelistviewmodel is a structure that contains a number of articlesleviewmodel. This structure takes an article -type array and converts each article object to the relevant articleviewmodel object.
/// Articleleviewmodel contains an Article -type object and is a view model that provides access to the properties of this object. Title, description and image properties return to the observable, so that when there is any change, they inform the observers (obscond).
struct ArticleListViewModel{
    let articleVM: [ArticleViewModel]
}

/// The first Extension is a series of Articlewmodel structures by taking an Article series. CompactMAP function, if it processes each item in the Article series to create Articleleviewmodel structures, and if the Nile rotates, the resulting series does not have any articleleviewmodel item.
extension ArticleListViewModel{
    init(_ articles: [Article]) {
        self.articleVM = articles.compactMap(ArticleViewModel.init)
    }
}
/// The second extension brings the Articleleviewmodel structure in the ArticlelistViewModel according to the specified index.
extension ArticleListViewModel{
    func articleAt(_ index: Int) -> ArticleViewModel{
        return self.articleVM[index]
    }
}

struct ArticleViewModel {
    let article: Article
    
    init(article: Article) {
        self.article = article
    }
}

extension ArticleViewModel {
    var title:Observable<String>{
        return Observable<String>.just(article.title)
    }
    var description:Observable<String>{
        return Observable<String>.just(article.description ?? "")
    }
    var url:Observable<String>{
        return Observable<String>.just(article.url)
    }
    var image:Observable<String>{
        return Observable<String>.just(article.urlToImage  ?? "")
    }
}
