//
//  URLRequest.swift
//  NewsApp
//
//  Created by Meric Alp on 4.04.2023.
//

import Foundation
import RxSwift
import RxCocoa




/// Bir Resource nesnesi ve bu nesneyi temsil eden bir URL'yi içeren bir Observable oluşturur ve ardından bu URL'den veri indirmek için bir HTTP isteği yapar. İndirilen veri daha sonra bir JSONDecoder kullanılarak ayrıştırılır ve nesne olarak geri döndürülür.
/// flatMap fonksiyonu, URLSession.shared.rx.data(request:) fonksiyonundan döndürülen Observable<Data>'yı alır ve verileri ayrıştırmak için bir sonraki map operatörüne iletilir. Bu map operatörü, Data nesnesini ayrıştırmak için JSONDecoder kullanır ve sonuç olarak T türündeki nesne oluşturur.
struct Resource<T: Decodable> {
    let url: URL
}

extension URLRequest {
    
    static func load<T>(resource: Resource<T>) -> Observable<T> {
        return Observable.just(resource.url)
            .flatMap { url -> Observable<Data> in
                let request = URLRequest(url: url)
                return URLSession.shared.rx.data(request: request)
            }.map { data -> T in
                return try JSONDecoder().decode(T.self, from: data)
        }
    }
}


