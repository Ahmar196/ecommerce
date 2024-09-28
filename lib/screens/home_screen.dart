import 'package:ecommerce/screens/productscreen.dart';
import 'package:ecommerce/view_model/FavoritesVM.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> tabs = [
    "All",
    "Category",
    "TOP",
    "Recommended",
  ];

  List imagelist = [
    "assets/images/image1.jpg",
    "assets/images/image2.jpg",
    "assets/images/image3.jpg",
    "assets/images/image4.jpg",
  ];

  List productTitles = [
    "Warm Zipper",
    "Knitted Wool",
    "Zipper Win",
    "Child Win",
  ];

  List prices = [
    "\$100",
    "\$200",
    "\$300",
    "\$400",
  ];

  List reviews = [
    "30",
    "40",
    "50",
    "60",
  ];

  // Search-related fields
  TextEditingController _searchController = TextEditingController();
  List filteredProducts = [];

  // State variable to keep track of the selected tab
  int selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    // Initially show all products
    filteredProducts = List.from(productTitles);
  }

  // Method to filter products based on search input
  void _filterProducts(String query) {
    setState(() {
      filteredProducts = productTitles
          .where(
              (product) => product.toLowerCase().contains(query.toLowerCase()))
          .toList();

      // If no products match and selected tab index is 1 or 2, reset to show the default list
      if (filteredProducts.isEmpty &&
          (selectedTabIndex == 1 || selectedTabIndex == 2)) {
        filteredProducts = [];
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Search and Notification Row
                Row(
                  children: [
                    Flexible(
                      flex: 3,
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.black12.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextFormField(
                          controller: _searchController,
                          onChanged: (value) {
                            _filterProducts(value);
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.search,
                              color: Color(0xffdb3022),
                            ),
                            border: InputBorder.none,
                            labelText: "Find your product",
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Flexible(
                      flex: 1,
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.black12.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.notifications,
                            color: Color(0xffdb3022),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                // Banner Image
                Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Color(0xfffff0dd),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset('assets/images/freed.png',
                        fit: BoxFit.cover),
                  ),
                ),
                SizedBox(height: 20),

                // Category Tabs
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: tabs.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedTabIndex =
                              index; // Update the selected tab index
                          // Reset the filteredProducts when changing tabs
                          if (index == 0) {
                            filteredProducts = List.from(productTitles);
                          } else if (index == 1 || index == 2) {
                            filteredProducts = List.from(
                                productTitles); // Filter for specific tabs if needed
                          }
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.all(8),
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: Colors.black12.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            tabs[index],
                            style: TextStyle(
                              color: selectedTabIndex == index
                                  ? Color(0xffdb3022) // Highlight selected tab
                                  : Colors.black38,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                if (selectedTabIndex == 0)
                  // Horizontal Product List
                  SizedBox(
                    height: 180,
                    child: ListView.builder(
                      itemCount: imagelist.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                          width: MediaQuery.of(context).size.width * 0.85,
                          margin: EdgeInsets.only(right: 15),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Image and Favorite icon
                              Stack(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ProductScreen(
                                              imageIndex:
                                                  index), // Pass imageIndex here
                                        ),
                                      );
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.asset(
                                        imagelist[index],
                                        height: 200,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 8,
                                    top: 8,
                                    child: GestureDetector(
                                      onTap: () {
                                        context
                                            .read<FavoritesVM>()
                                            .toggleFavorite(index);
                                      },
                                      child: Container(
                                        height: 24,
                                        width: 24,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Center(
                                          child: Icon(
                                            Icons.favorite,
                                            color: context
                                                    .watch<FavoritesVM>()
                                                    .isFavorite(index)
                                                ? Color(0xFFDB3022)
                                                : Colors.grey,
                                            size: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 10),
                              // Product details: title, description, reviews, and price
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Product title
                                    Text(
                                      productTitles[index],
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 5),
                                    // Product description
                                    Text(
                                      'Lorem Ipsum is simply dummy text of the printing and typeselling industry.',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    // Reviews, Star, and Price
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                          size: 16,
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          '(${reviews[index]})',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          '${prices[index]}',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFFDB3022),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                SizedBox(height: 10),

                // Newest Products Section
                if (selectedTabIndex == 0)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Newest Products',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      // Check if filteredProducts is empty
                      if (filteredProducts.isEmpty)
                        Column(
                          children: [
                            Center(
                              child: Text(
                                'Product Not Found',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.search,
                              color: Colors.red,
                              size: 150,
                            ),
                          ],
                        )
                      else
                        // Grid View of Products
                        GridView.builder(
                          itemCount: filteredProducts.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.75,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                          itemBuilder: (context, index) {
                            // Use the index to display filtered products
                            final productIndex =
                                productTitles.indexOf(filteredProducts[index]);

                            return Container(
                              margin: EdgeInsets.only(right: 15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.width *
                                        0.4, // Flexible image size
                                    child: Stack(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ProductScreen(
                                                        imageIndex:
                                                            productIndex),
                                              ),
                                            );
                                          },
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.asset(
                                              imagelist[productIndex],
                                              height: 200,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.4,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          right: 8,
                                          top: 8,
                                          child: GestureDetector(
                                            onTap: () {
                                              context
                                                  .read<FavoritesVM>()
                                                  .toggleFavorite(productIndex);
                                            },
                                            child: Container(
                                              height: 24,
                                              width: 24,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: Center(
                                                child: Icon(
                                                  Icons.favorite,
                                                  color: context
                                                          .watch<FavoritesVM>()
                                                          .isFavorite(
                                                              productIndex)
                                                      ? Color(0xFFDB3022)
                                                      : Colors.grey,
                                                  size: 16,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    productTitles[productIndex],
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 16,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        '(${reviews[productIndex]})',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        '${prices[productIndex]}',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xffdb3022),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                    ],
                  ),

                if (selectedTabIndex == 3)
                  // Horizontal Product List
                  SizedBox(
                    height: 180,
                    child: ListView.builder(
                      itemCount: imagelist.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                          width: MediaQuery.of(context).size.width * 0.85,
                          margin: EdgeInsets.only(right: 15),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Image and Favorite icon
                              Stack(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ProductScreen(
                                              imageIndex:
                                                  index), // Pass imageIndex here
                                        ),
                                      );
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.asset(
                                        imagelist[index],
                                        height: 200,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 8,
                                    top: 8,
                                    child: GestureDetector(
                                      onTap: () {
                                        context
                                            .read<FavoritesVM>()
                                            .toggleFavorite(index);
                                      },
                                      child: Container(
                                        height: 24,
                                        width: 24,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Center(
                                          child: Icon(
                                            Icons.favorite,
                                            color: context
                                                    .watch<FavoritesVM>()
                                                    .isFavorite(index)
                                                ? Color(0xFFDB3022)
                                                : Colors.grey,
                                            size: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 10),
                              // Product details: title, description, reviews, and price
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Product title
                                    Text(
                                      productTitles[index],
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 5),
                                    // Product description
                                    Text(
                                      'Lorem Ipsum is simply dummy text of the printing and typeselling industry.',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    // Reviews, Star, and Price
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                          size: 16,
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          '(${reviews[index]})',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          '${prices[index]}',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFFDB3022),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                SizedBox(height: 10),
                // Newest Products Section
                if (selectedTabIndex == 1 ||
                    selectedTabIndex ==
                        2) // Show only if selected tab is "Category" or "TOP"
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Newest Products',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      // Check if filteredProducts is empty
                      if (filteredProducts.isEmpty)
                        Center(
                          child: Text(
                            'Product Not Found',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        )
                      else
                        // Grid View of Products
                        GridView.builder(
                          itemCount: filteredProducts.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.75,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                          itemBuilder: (context, index) {
                            // Use the index to display filtered products
                            final productIndex =
                                productTitles.indexOf(filteredProducts[index]);

                            return Container(
                              margin: EdgeInsets.only(right: 15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.width *
                                        0.4, // Flexible image size
                                    child: Stack(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ProductScreen(
                                                        imageIndex:
                                                            productIndex),
                                              ),
                                            );
                                          },
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.asset(
                                              imagelist[productIndex],
                                              height: 200,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.4,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          right: 8,
                                          top: 8,
                                          child: GestureDetector(
                                            onTap: () {
                                              context
                                                  .read<FavoritesVM>()
                                                  .toggleFavorite(productIndex);
                                            },
                                            child: Container(
                                              height: 24,
                                              width: 24,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: Center(
                                                child: Icon(
                                                  Icons.favorite,
                                                  color: context
                                                          .watch<FavoritesVM>()
                                                          .isFavorite(
                                                              productIndex)
                                                      ? Color(0xFFDB3022)
                                                      : Colors.grey,
                                                  size: 16,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    productTitles[productIndex],
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 16,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        '(${reviews[productIndex]})',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        '${prices[productIndex]}',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xffdb3022),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
