//
//  Menu.swift
//  LittleLemonRestaurant
//
//  Created by tony on 5/5/2024.
//

import SwiftUI

struct Menu: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
//    var viewContext = PersistenceController.shared.container.viewContext
    
    @State var menuItems: [MenuItem] = []
    
    private var categories: [String] = ["Starters","Mains","Desserts","Drinks"]
    
    @State private var searchText: String = ""
    
    func getMenuData() {
        
        PersistenceController().clear()
        
        let urlString =  "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                
//                let string = String(data: data, encoding: .utf8)
//                print(string)
                   let decoder = JSONDecoder()
                    
                    do {
                       
                           // process data
                        let fullMenu = try decoder.decode(MenuList.self, from: data)
                        
                        menuItems = fullMenu.menu
                        
                        for menuItem in menuItems {
                            //                guard let _ = exists(name: menuItem.title, context) else {
                            //                    continue
                            //                }
                            let oneDish = Dish(context: viewContext)
                            oneDish.title = menuItem.title
                            oneDish.price = menuItem.price
                            oneDish.itemDescription = menuItem.description
                            oneDish.image = menuItem.image
                            oneDish.category = menuItem.category
                            
//                            print(oneDish)
                            print(oneDish.title ?? "")
                            print(oneDish.price ?? "")
                            print(oneDish.itemDescription ?? "")
                            print(oneDish.image ?? "")
                            print(oneDish.category ?? "")
                            
                        }
                        try? viewContext.save()
//                        print("presave")
//                        do {
//                            try viewContext.save()
//                                } catch {
//                                    let nsError = error as NSError
//                                    print("Unresolved error \(nsError), \(nsError.userInfo)")
//                                }
//                        print("postsave")
                        
                        } catch let DecodingError.dataCorrupted(context) {
                            print(context)
                        } catch let DecodingError.keyNotFound(key, context) {
                            print("Key '\(key)' not found:", context.debugDescription)
                            print("codingPath:", context.codingPath)
                        } catch let DecodingError.valueNotFound(value, context) {
                            print("Value '\(value)' not found:", context.debugDescription)
                            print("codingPath:", context.codingPath)
                        } catch let DecodingError.typeMismatch(type, context)  {
                            print("Type '\(type)' mismatch:", context.debugDescription)
                            print("codingPath:", context.codingPath)
                        } catch {
                            print("error: ", error)
                        }
            }
        }

        task.resume()
    }
    
    
    
    var body: some View {
             
        VStack{
            
            VStack(alignment: .leading) {
                Text("Little Lemon")
                HStack {
                    VStack(alignment: .leading) {
                        Text("Chicago")
                        Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                    }
                    Spacer()
                    Image(.hero)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .cornerRadius(10)
                        .padding()
                }
                
                TextField("Search menu", text: $searchText)
                
                
            }
            
            VStack {
                Text("Order for Delivery!".uppercased())
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(categories, id: \.self) {category in
                            Text(category)
                        }
                    }
                }
            }
            
            FetchedObjects(
                predicate:buildPredicate()
                ,  sortDescriptors: buildSortDescriptors()  )  {
            (dishes: [Dish]) in
                List {
                    
                    ForEach(dishes) { dish in
                        
                        NavigationLink(destination:
                                        DishDetails(dish: dish)
                                       
                        ) {
                            
                            
//                            Text(dish.title  ?? "Empty")
                            DisplayDish(dish: dish)
                        }
                    }
                }
//                .searchable(text: $searchText,
//                            prompt: "search...")
                .listStyle(PlainListStyle())
                
            }
        }
        .toolbar(content: {
            HStack {
                Spacer()
                Image(.littleLemonLogo)
                Image(.profileImagePlaceholder)
                    .resizable()
                    .frame(width: 60, height: 60)
                    .padding()
                
            }
        })
        .onAppear {
            getMenuData()
        }

    }
    
    
    
    func buildPredicate() -> NSPredicate {
//        if searchText.isEmpty {
//            return NSPredicate(format: "TRUEPREDICATE")
//        } else {
//            return  NSPredicate(format: "name CONTAINS[cd] %@", searchText)
//        }
        
//        print(searchText.isEmpty)
        
        return searchText.isEmpty ? NSPredicate(format: "TRUEPREDICATE") : NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        
        
       
        
//        return NSPredicate(format: "TRUEPREDICATE")
//        NSPredicate(value: true

        
        
//        NSPredicate(format: "name CONTAINS[cd] %@", "pie")

    }
    
    
    func buildSortDescriptors() -> [NSSortDescriptor] {
//        if sortByPrice {
//            return  [ NSSortDescriptor(key: "price", ascending: true) ]
//          } else {
//             return  [ NSSortDescriptor(key: "name", ascending: true) ]
//            }
        
//        return [NSSortDescriptor(key: sortBy.rawValue, ascending: true)]
        
        return [
                NSSortDescriptor(key: "title",
                                 ascending: true,
                                 selector:
                                    #selector(NSString .localizedStandardCompare)),
//                NSSortDescriptor(key: "size",
//                                 ascending: false,
//                                 selector:
//                                    #selector(NSString .localizedStandardCompare))
        ]
        
        
    }
    
    
    
    
private func DisplayDish(dish: Dish) -> some View {
    
    
    return HStack {
        VStack {
            Text(dish.title ?? "")
            Text(dish.itemDescription ?? "")
            Text(dish.price ?? "")
        }
        
        Spacer()
        
        Rectangle()
            .frame(width: 100, height: 100)
        //                        let url = URL(string: menuItem.image)!
        //                        AsyncImage(url: url) { image in
        //                            image.resizable()
        //                        } placeholder: {
        //                            ProgressView()
        //                        }
        //                        .frame(width: 100, height: 100)
    }
}
    
}

#Preview {
    NavigationStack {
        Menu()
           
    }
   
}



