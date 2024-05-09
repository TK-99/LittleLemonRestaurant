//
//  Menu.swift
//  LittleLemonRestaurant
//
//  Created by tony on 5/5/2024.
//

import SwiftUI

struct Menu: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @Environment(\.presentationMode) var presentation
    
    @State var menuItems: [MenuItem] = []
    
    private var categories: [String] = ["Starters","Mains","Desserts","Drinks"]
    
    @State private var searchText: String = ""
    @State private var selectedCategory: String = ""
    
    @State private var isSelected: Bool = false
    
    @State private var dataHasLoaded: Bool = false
    
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
//                        print(oneDish.title ?? "")
//                        print(oneDish.price ?? "")
//                        print(oneDish.itemDescription ?? "")
//                        print(oneDish.image ?? "")
//                        print(oneDish.category ?? "")
                        
                    }
                    try? viewContext.save()
                    dataHasLoaded = true
                    
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
        
        ZStack {
            VStack(alignment: .center, spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Little Lemon")
                        .padding(.top, 10)
                        .padding([.top, .bottom], 0)
                        .padding(.horizontal, 8)
                        .frame(maxWidth: .infinity, alignment: .leading)
//                        .font(.largeTitle)
                        .font(Font.custom("MarkaziText-Medium", size: 64))
                        .foregroundStyle(Color.theme.yellow)
                    //                        .background(Color.green)
                    
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Chicago")
//                                .font(.title)
                                .font(Font.custom("MarkaziText-Medium", size: 50))
                                .foregroundStyle(Color.theme.silver)
                            
                            
                            Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist. ")
                                .foregroundStyle(Color.theme.silver)
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.leading)
                                .frame(maxWidth: .infinity)
                            //                                .lineLimit(5)
                                .padding(.top, 16)
                            
                            Spacer()
                        }
                        //                        .background(Color.green)
                        
                        .padding(.horizontal, 8)
                        
                        //                         Spacer()
                        Image(.hero)
                            .resizable()
                            .frame(width: 125, height: 140)
                            .cornerRadius(10)
                            .padding([.top, .bottom], 8)
                            .padding(.trailing, 8)
                        
                    }
                    //                    .background(Color.red)
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .font(.headline)
                            .foregroundColor(Color.theme.black
                                             
                                             //                                searchText.isEmpty ? Color.theme.secondaryText : Color.theme.accent
                            )
                        TextField("Search menu...", text: $searchText)
                            .foregroundColor(Color.theme.black)
                        
                        // need both next two lines to disable autocorrect
                            .autocorrectionDisabled(true)
                            .keyboardType(.alphabet)
                        
                            .overlay(Image(systemName: "xmark.circle.fill")
                                .padding()
                                .offset(x: 10)
                                .foregroundColor(Color.theme.black)
                                .opacity(searchText.isEmpty ? 0.0 : 1.0)
                                .onTapGesture {
                                    UIApplication.shared.endEditing()
                                    searchText = ""
                                }
                                     , alignment: .trailing
                                     
                            )
                        
                    }
                    .font(.headline)
                    .padding(8)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.theme.silver)
                    )
                    .padding()
                }
                .background(Color.theme.green.ignoresSafeArea())
                
                
                VStack(alignment: .center) {
                    HStack(alignment: .center) {
                        Text("Order for Delivery!".uppercased())
                            .font(.headline)
                            .fontWeight(.semibold)
                        //                        .padding(.top, 20)
                            .padding(.trailing, 20)
                        
                        Image(.deliveryVan)
                            .resizable()
                            .frame(width: 30, height: 20)
                            .padding(0)
                        Spacer()
                    }
                    .padding(.top, 15)
                    .padding(.leading, 10)
                    //                    ScrollView(.horizontal) {
                    HStack(alignment: .center, spacing: 20) {
                        ForEach(categories, id: \.self) {category in
                            Text(category)
                                .font(.callout)
                                .frame(minWidth: 35)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 10)
                                .themeColors(isSelected: category == selectedCategory)
                                .background(Color.theme.green)
                                .cornerRadius(20)
                            
                                .onTapGesture {
                                    
                                    if (category == selectedCategory ) {
                                        selectedCategory = ""
                                    } else {
                                        selectedCategory = category
                                    }
                                }
                        }
                    }
                    //                        .padding()
                    //                        .padding(.leading, 30)
                    //                    }
                }
                //                .background(Color.red)
                
                FetchedObjects(
                    predicate:buildPredicate(),
                    sortDescriptors: buildSortDescriptors()  )  {
                        (dishes: [Dish]) in
                        List {
                            ForEach(dishes) { dish in
                                NavigationLink(destination:
                                                DishDetails(dish: dish)
                                ) {
                                    DisplayDish(dish: dish)
                                }
                            }
                        }
                        .listStyle(PlainListStyle())
                    }
            }
            .onAppear { 
//                print("appear")
                
                if !dataHasLoaded {
                    getMenuData()
                }
            }
        }
        .padding(.vertical, 8)
        
        
    }
    
    func buildPredicate() -> NSPredicate {
        let predicate1 = (searchText.isEmpty ? NSPredicate(format: "TRUEPREDICATE") : NSPredicate(format: "title CONTAINS[cd] %@", searchText))
        let predicate2 = (selectedCategory.isEmpty ? NSPredicate(format: "TRUEPREDICATE") : NSPredicate(format: "category CONTAINS[cd] %@", selectedCategory))
        
        return NSCompoundPredicate(type: .and,
                                   subpredicates: [ predicate1, predicate2 ])
    }
    
    
    func buildSortDescriptors() -> [NSSortDescriptor] {
        return [ NSSortDescriptor(key: "title", ascending: true, selector:
                                    #selector(NSString .localizedStandardCompare))]
    }
    
    
    
    
    private func DisplayDish(dish: Dish) -> some View {
        return HStack {
            VStack(alignment: .leading) {
                Text(dish.title ?? "")
                    .font(.headline)
                    .fontWeight(.semibold)
                    
                Text(dish.itemDescription ?? "")
                    .font(.callout)
                    .padding(.vertical, 4)
                Text("$\(dish.price ?? "0.00")")
                    .font(.headline)
                
            }
                Spacer()
                
                //        Rectangle()
                //            .frame(width: 100, height: 100)
                let url = URL(string: dish.image ?? "")
                AsyncImage(url: url) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 100, height: 100)
            }
        }
        
    }
    
    extension View {
        func themeColors(isSelected: Bool) -> some View {
            return
                self
                .foregroundStyle(isSelected ? Color.theme.silver : Color.theme.black)
                .background(isSelected ? Color.theme.green : Color.theme.silver)
        }
    }
    
    #Preview {
        NavigationStack {
            Menu()
            
        }
        
    }
    
    
    
