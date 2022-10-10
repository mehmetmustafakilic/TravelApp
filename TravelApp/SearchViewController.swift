//
//  SearchViewController.swift
//  TravelApp
//
//  Created by Mehmet Mustafa Kılıç on 3.10.2022.
//


    import UIKit

    class SearchViewController: UIViewController, UITableViewDelegate, UISearchBarDelegate, UITableViewDataSource {

        @IBOutlet weak var searchBar: UISearchBar!
        @IBOutlet weak var searchTableVew: UITableView!

        
        var dataHotelList: [ResponseModel] = []
        var flightList: [ResponseModel] = []
        
        let hotelItem: [ResponseModel] = [
           
           .init(catagory: "Hotels", image: "hotels1", name: "Mahali Mzuri, Masai Mara, Kenya", commit: "Part of the Virgin Limited Edition collection, Sir Richard Branson's majestic safari camp in the Masai Mara is 'just perfect', according to one voter. The seemingly space-age tents somehow rise up out of the landscape and blend in with it simultaneously. Wildlife remains abundant in the surrounding bush — ideal for the twice-daily game drives — and the guides are extremely knowledgeable. One respondent raved about the 'excellent service', adding that 'the hospitality provided at Mahali Mzuri resembles the name', which means beautiful place in Swahili. Another reader says simply that it's 'the best luxurious camp to visit on the African continent."),
           .init(catagory: "Hotels", image: "hotels2", name: "Nayara Tented Camp, Arenal Volcano National Park, Costa Rica", commit: "The most recent entry to the Nayara brand has all the details covered. Cliff-top safari tents have spacious bathrooms with soaking tubs, private decks, and infinity plunge pools that overlook the lush Costa Rican rain forest and the imposing Arenal Volcano. Elsewhere on the property, guests can spot wildlife like sloths and toucans; take a dip in the dramatic, cantilevered, hot-spring-fed mineral pools; and indulge in the plush spa."),
           .init(catagory: "Hotels", image: "hotels3", name: "The Opposite House, Beijing", commit: "apanese architect Kengo Kuma designed this emerald glass building with subtle references to traditional Chinese architecture. Rooms are minimalist with luxurious touches like oak soaking tubs and plush beds, the staff is über-attentive, and the location is close to all the Beijing attractions."),
           .init(catagory: "Hotels", image: "hotels4", name: "Capella Bangkok", commit: "Situated on the east bank of the Chao Phraya River, this new urban retreat offers impressive views of the lively Thai capital. There are four dining venues, including one overseen by chef Mauro Colagreco of France's Michelin three-starred Mirazur, and a swank spa with treatments, therapies, and fitness classes."),
           .init(catagory: "Hotels", image: "hotels5", name: "Capella Ubud, Bali, Indonesia", commit: "Last year's Top 100 Hotels winner, this glamorous, Bill Bensley-designed resort features a dramatic suspension bridge leading to 22 tented hideaways surrounded by lush rain forest and the river Wos gurgling below. The on-site organic Keliki Garden supplies two restaurants and a bar, and the nightly campfire is the setting for storytelling, movies, and live music with s'mores and hot chocolate."),
           .init(catagory: "Hotels", image: "hotels6", name: "Grace Hotel, Auberge Resorts Collection, Santorini, Greece", commit: "This whitewashed resort, tucked away on the quieter side of Santorini, has unobstructed views of the sparkling Aegean, minus the crowds found elsewhere. Stay on property to enjoy yoga alfresco (the cliff-top setting is magical), or ask the staff to coordinate a scenic hike or cruise to see the island from a different vantage point."),
           .init(catagory: "Hotels", image: "hotels7", name: "Kamalame Cay, Andros Island, Bahamas", commit: "Although this serene Bahamian island resort is a bit hard to get to, it's worth the journey for guests who make it to its sparkling private shores. Guests can relax on the deck of their beachfront bungalows, have breakfast delivered daily in a wicker basket, and borrow golf carts and bikes to explore the 96-acre island."),
           .init(catagory: "Hotels", image: "hotels8", name: "The Oberoi Udaivilas, Udaipur, India", commit: "It's not hard to feel like royalty in this extravagant palace hotel, where Udaipur's glittering Lake Pichola is front and center. Posh rooms have semi-private pools that create a kind of moat around the hotel, and staff are trained to anticipate guests' every desire."),
           .init(catagory: "Hotels", image: "hotels9", name: "The Temple House, Chengdu, China", commit: "Two modernist, glass mid-rise towers emerge from a century-old building and tree-filled courtyard, creating a refuge within Sichuan's bustling capital. Rooms are modern and minimal, and there are four food and beverage outlets, a spa, an indoor pool, and a house car to enjoy."),
           .init(catagory: "Hotels", image: "hotels10", name: "The Oberoi, New Delhi", commit: "There are 220 well-appointed rooms in this luxury hotel situated near several Delhi attractions. Guests can unwind at either the indoor or outdoor swimming pool, then choose from seven restaurants and bars, including one by Alfred Prasad, formerly of the Michelin-starred Tamarind in London."),
           .init(catagory: "Flights", image: "flight1", name: "Pegasus", commit: "Sabiha Gokcen - Malataya. 10.00"),
           .init(catagory: "Flights", image: "flight2", name: "Türk Hava Yolları", commit: "İstanbul Havalimanı - KahramanMaraş. 10.15"),
           .init(catagory: "Flights", image: "flight3", name: "Anadolu Jet", commit: "Sabiha Gokcen - Konya. 10.30"),
           .init(catagory: "Flights", image: "flight4", name: "Bora Jet", commit: "Samsun - Malataya. 10.45"),
           .init(catagory: "Flights", image: "flight5", name: "SunExpress", commit: "İzmir - Malataya. 09.00"),
           .init(catagory: "Flights", image: "flight10", name: "Emir Air", commit: "Katar - Malataya. 10.00"),
           .init(catagory: "Flights", image: "flight7", name: "Mustafa Air", commit: "İstanbul Havalimanı - Elbistan. 15.00"),
           .init(catagory: "Flights", image: "flight8", name: "Kılıç Air", commit: "Sabiha Gokcen - Elbistan. 13.00"),
           .init(catagory: "Flights", image: "flight9", name: "Yumurta Air", commit: "Samsun Çarşamba - Perşembe. 22.00"),
           .init(catagory: "Flights", image: "flight10", name: "MSTF Air", commit: "Miami - Elbistan. 10.00")
       ]
        var filteredData: [String] = []
        
        override func viewDidLoad() {
            super.viewDidLoad()
            

            
            searchBar.delegate = self
            searchTableVew.delegate = self
            searchTableVew.dataSource = self
            registerCell()
      //
            let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
            view.addGestureRecognizer(gestureRecognizer)

            // Do any additional setup after loading the view.
        }
        
        func registerCell() {
            let nib = UINib(nibName: "DetailListTableViewCell", bundle: nil)
            searchTableVew.register(nib, forCellReuseIdentifier: "DetailListTableViewCell")
        }
        @objc func hideKeyboard(){
            view.endEditing(true)
            
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            
            
            
            for item in hotelItem {
                if (item.name ?? "").contains(searchText) {
                   // filteredData.append(contentsOf: item)
                }
            }
            searchTableVew.reloadData()
        }

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            1
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailListTableViewCell", for: indexPath) as! DetailListTableViewCell
            let bookmark = hotelItem[indexPath.row]
            cell.detailListCellName.text = bookmark.name
            cell.detailsListCellCommit.text = bookmark.commit
            cell.detailListCellimage.image = UIImage(named: bookmark.image)
            return cell
        }

}

