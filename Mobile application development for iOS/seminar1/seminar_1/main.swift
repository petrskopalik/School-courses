//
//  main.swift
//  seminar_1
//
//  Created by Petr Skopalík on 10.02.2026.
//

import Foundation

enum Genre{
    case action
    case drama
    case comedy
    case sciFi
    case horror
    case animated
    case adventure
}

struct Movie{
    var id: UUID
    var title: String
    var year: Int
    var rating: Double
    var genre: Genre
    
    mutating func setYear(year: Int){
        if year > 1950{
            self.year = year
        } else {
            print("Hodnota year musí být větší než 1950!")
        }
    }
    
    mutating func setRating(rate: Double){
        if rate >= 0.0 && rate <= 10.0{
            self.rating = rate
        } else {
            print("Hodnota rate musí být v intervalu 0-10!")
        }
    }
}

var listOfMovies : [Movie] = [
    Movie(id: UUID(), title: "Buchty a klobásy", year: 2016, rating: 9.1, genre: .animated),
    Movie(id: UUID(), title: "Matrix", year: 1999, rating: 9.8, genre: .action),
    Movie(id: UUID(), title: "Shrek", year: 2001, rating: 9.5, genre: .animated),
    Movie(id: UUID(), title: "Dune: Part Two", year: 2024, rating: 9.9, genre: .sciFi),
    Movie(id: UUID(), title: "Asterix a Obelix: Mise Kleopatra", year: 2002, rating: 10.0, genre: .comedy),
    Movie(id: UUID(), title: "Avengers", year: 2012, rating: 7.2, genre: .action),
    Movie(id: UUID(), title: "Království nebeské", year: 2005, rating: 9.9, genre: .adventure),
    Movie(id: UUID(), title: "Já, robot", year: 2004, rating: 9.3, genre: .sciFi),
    Movie(id: UUID(), title: "Já, padouch", year: 2010, rating: 9.0, genre: .animated)
]

func movies(in genre: Genre, from movies: [Movie]) -> [Movie]{
    var result: [Movie] = []
    
    for movie in movies{
        if movie.genre == genre {
            result.append(movie)
        }
    }
    
    return result
}

print(movies(in: Genre.animated, from: listOfMovies))

func topRatedMovie(from movies: [Movie]) -> Movie?{
    var bestRatedMovie: Movie? = nil
    var bestRating: Double = -1.0
    
    for movie in movies{
        if movie.rating > bestRating {
            bestRatedMovie = movie
            bestRating = movie.rating
        }
    }
    
    return bestRatedMovie
}

print(topRatedMovie(from: listOfMovies))

func averageRating(for genre: Genre, in movies: [Movie]) -> Double?{
    if movies.isEmpty {
        return nil
    }
    var count: Int = 0
    var avgRating: Double = 0
    for movie in movies{
        if movie.genre == genre{
            avgRating += movie.rating
            count += 1
        }
    }

    return avgRating / Double(count)
}

//print(averageRating(for: .animated, in: listOfMovies))

func moviesReleased(from yearStart: Int, to yearEnd: Int, in movies: [Movie]) -> [Movie]{
    var movieResult: [Movie] = []
    for movie in movies{
        if movie.year >= yearStart && movie.year <= yearEnd{
            movieResult.append(movie)
        }
    }
    return movieResult
}

//print(moviesReleased(from: 2000, to: 2002, in: listOfMovies))

////////////////////////////////////////////////////////////////////////////////////////////////////////

enum StockOperationType{
    case inbound
    case onbound
}

struct StockItem{
    var sku: String
    var name: String
    var quantity: Int
    
    mutating func setQuantity(amount: Int){
        self.quantity = amount
    }
}

struct StockOperation{
    var type: StockOperationType
    var sku: String
    var amount: Int
    var date: Date
}

class Warehouse{
    var items: [StockItem]
    var history: [StockOperation]
    
    init(){
        items = []
        history = []
    }
    
    func record(type: StockOperationType, sku: String, amount: Int, date: Date){
        history.append(StockOperation(type: type,
                                      sku: sku,
                                      amount: amount,
                                      date: date))
    }
    
    func addNewItem(_ item: StockItem){
        for it in items{
            if it.sku == item.sku{
                print("Nelze přidat")
                return
            }
        }
        items.append(item)
        record(type: StockOperationType.inbound,
               sku: item.sku,
               amount: item.quantity,
               date: Date())
    }
    
    func apply(_ operation: StockOperation) -> Bool{
        if operation.amount < 1{
            return false
        }
        if operation.type == StockOperationType.inbound{
            for i in 0..<items.count{
                if items[i].sku == operation.sku{
                    items[i].setQuantity(amount: operation.amount)
                    record(type: StockOperationType.inbound,
                           sku: items[i].sku,
                           amount: items[i].quantity,
                           date: Date())
                    return true
                }
            items.append(StockItem(sku: operation.sku,
                                   name: operation.sku,
                                   quantity: operation.amount))
            record(type: StockOperationType.inbound,
                   sku: items[i].sku,
                   amount: operation.amount,
                   date: operation.date)
            return true
            }
        } else {
            for i in 0..<items.count{
                if items[i].sku == operation.sku{
                    let change: Int = items[i].quantity - operation.amount
                    if change < 0{
                        return false
                    }
                    items[i].setQuantity(amount: change)
                    record(type: StockOperationType.onbound,
                           sku: items[i].sku,
                           amount: change,
                           date: operation.date)
                    return true
                }
            }
        }
        return false
    }
    
    func item(with sku: String) -> StockItem?{
        for item in items{
            if item.sku == sku{
                return item
            }
        }
        return nil
    }
    
    func totalQuantity() -> Int{
        var total: Int = 0
        for item in items{
            total += item.quantity
        }
        return total
    }
    
    func lowStockItems(threshold: Int) -> [StockItem]{
        var result: [StockItem] = []
        for item in items{
            if item.quantity <= threshold{
                result.append(item)
            }
        }
        return result
    }
}

//var WareHouse13: Warehouse = Warehouse()
//
//WareHouse13.addNewItem(StockItem(sku: "A123", name: "Kakao", quantity: 123))
//print(WareHouse13.items)
//print(WareHouse13.apply(StockOperation(type: .onbound, sku: "A123", amount: 120, date: Date())))
//print(WareHouse13.item(with: "A123"))
//WareHouse13.addNewItem(StockItem(sku: "B123", name: "Sušenky", quantity: 1))
//print(WareHouse13.totalQuantity())
//print(WareHouse13.lowStockItems(threshold: 2))
//print(WareHouse13.apply(StockOperation(type: .onbound, sku: "C123", amount: 120, date: Date())))
//print(WareHouse13.apply(StockOperation(type: .inbound, sku: "B123", amount: 2, date: Date())))
//print(WareHouse13.apply(StockOperation(type: .inbound, sku: "D123", amount: 4, date: Date())))
//print(WareHouse13.history)
