import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recipe App',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: LoginScreen(), // Start at LoginScreen
    );
  }
}

// Login Screen
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _login() {
    if (usernameController.text == 'user' && passwordController.text == 'pass') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => RecipeListScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid credentials')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

// Recipe List Screen with Category Filter
class RecipeListScreen extends StatefulWidget {
  @override
  _RecipeListScreenState createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen> {
  final List<Map<String, String>> recipes = [
    // Sample recipe data (same as provided above)
    {
      'title': 'Butter Chicken',
      'imageUrl': 'https://www.licious.in/blog/wp-content/uploads/2020/10/butter-chicken--750x750.jpg',
      'description': 'A creamy and rich chicken curry made with butter, cream, and spices.',
      'details': 'Marinate chicken with yogurt and spices. Cook in a buttery tomato sauce...',
      'category' : 'Non-Vegetarian',
       'price' : '20.00',
    },
    {
      'title': 'Palak Paneer',
      'imageUrl': 'https://th.bing.com/th/id/OIP.9rOtp8nRjXEB6kmXaz2wSAAAAA?w=126&h=189&c=7&r=0&o=5&dpr=1.3&pid=1.7',
      'description': 'Cottage cheese cubes cooked in a smooth spinach gravy.',
      'details': 'Blanch the spinach and blend to a puree. Cook with spices, then add paneer...',
      'category' : 'Vegetarian',
      'price' : '20.00',
    },
    {
      'title': 'Biryani',
      'imageUrl': 'https://norecipes.com/wp-content/uploads/2017/05/chicken-biryani-11.jpg',
      'description': 'A fragrant rice dish made with spices, rice, and either chicken, lamb, or vegetables.',
      'details': 'Layer marinated chicken and rice with fried onions and saffron...',
      'category' : 'Non-Vegetarian',
      'price' : '20.00',
    },
    {
      'title': 'Masala Dosa',
      'imageUrl': 'https://apollosugar.com/wp-content/uploads/2018/12/Masala-Dosa.jpg',
      'description': 'A crispy fermented rice crepe filled with a spiced potato mixture.',
      'details': 'Prepare batter with rice and lentils. Make a potato filling with mustard seeds...',
      'category' : 'Vegetarian',
      'price' : '20.00',
    },
    {
      'title': 'Gulab Jamun',
      'imageUrl': 'https://www.funfoodfrolic.com/wp-content/uploads/2020/07/Gulab-Jamun-Thumbnail.jpg',
      'description': 'Soft and spongy milk-solid dumplings soaked in cardamom-infused sugar syrup.',
      'details': 'Make dough with khoya. Fry and soak in sugar syrup flavored with rose water...',
      'category' : 'Desserts',
      'price' : '20.00',
    },
    {
      'title': 'Rogan Josh',
      'imageUrl': 'https://th.bing.com/th/id/R.438adee7682e56785577603c6b9ed2e5?rik=4%2b8NQJCI%2fPymzQ&riu=http%3a%2f%2fcdn.shopify.com%2fs%2ffiles%2f1%2f2313%2f8987%2farticles%2fRogan_Josh_01_copy_1200x1200.jpg%3fv%3d1625548245&ehk=KohMza3cOs1j61hfZDU1htJZ9EIHS245HTE%2f5GUtQ2U%3d&risl=&pid=ImgRaw&r=0',
      'description': 'A flavorful lamb curry made with aromatic spices and yogurt.',
      'details': 'Cook lamb with onions, garlic, and whole spices. Add yogurt and simmer...',
      'category' : 'Non-Vegetarian',
      'price' : '20.00',
    },
    {
      'title': 'Chole Bhature',
      'imageUrl': 'https://th.bing.com/th/id/OIP.Y484f7AzHY0b45zV4uPMawHaEK?rs=1&pid=ImgDetMain',
      'description': 'Spiced chickpeas served with deep-fried bread (bhature).',
      'details': 'Cook chickpeas with onion, tomatoes, and spices. Serve with fried bread...',
      'category' : 'Vegetarian',
      'price' : '20.00',
    },
    {
      'title': 'Pani Puri',
      'imageUrl': 'data:image/jpeg',
      'description': 'Crispy puris filled with spicy water, tamarind chutney, and mashed potatoes.',
      'details': 'Prepare the spicy water, tamarind chutney, and boiled potato filling...',
      'category' : 'Vegetarian',
      'price' : '20.00',
    },
  ];
  List<Map<String, dynamic>> cart = [];
  void addToCart(Map<String, dynamic> recipe) {
    // Convert the price to double before adding to the cart
    final cartItem = {
      'title': recipe['title'],
      'imageUrl': recipe['imageUrl'],
      'price': double.parse(recipe['price'].toString()), // Convert price to double
    };

    setState(() {
      cart.add(cartItem);
    });
  }


  String searchQuery = '';
  String selectedCategory = 'All';

  final List<String> categories = ['All', 'Vegetarian', 'Non-Vegetarian', 'Desserts'];

  @override
  Widget build(BuildContext context) {
    final filteredRecipes = recipes.where((recipe) {
      bool matchesQuery = recipe['title']!.toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesCategory = selectedCategory == 'All' || recipe['category'] == selectedCategory;
      return matchesQuery && matchesCategory;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Indian Recipes'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartScreen(cart: cart),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search recipes...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          // Category Dropdown
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: selectedCategory,
              onChanged: (value) {
                setState(() {
                  selectedCategory = value!;
                });
              },
              items: categories.map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
            ),
          ),
          // Recipe List
          Expanded(
            child: ListView.builder(
              itemCount: filteredRecipes.length,
              itemBuilder: (context, index) {
                final recipe = filteredRecipes[index]; // Assign each recipe item to 'recipe'
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecipeDetailScreen(
                          recipe: recipe, // Pass the recipe to the detail screen
                        ),
                      ),
                    );
                  },
                  // RecipeCard widget in _RecipeListScreenState
                  child: RecipeCard(
                    title: filteredRecipes[index]['title']!,
                    imageUrl: filteredRecipes[index]['imageUrl']!,
                    description: filteredRecipes[index]['description']!,
                    price: double.parse(filteredRecipes[index]['price'].toString()), // Convert price to double
                    onAddToCart: () {
                      addToCart(filteredRecipes[index]);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddRecipeScreen(onAddRecipe: (newRecipe) {
                setState(() {
                  recipes.add(newRecipe);
                });
              }),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

// Remaining code for RecipeCard, RecipeDetailScreen, and AddRecipeScreen remains the same.

// Card widget to display each recipe
class RecipeCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String description;
  final double price;
  final VoidCallback onAddToCart;

  RecipeCard({
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.price,
    required this.onAddToCart,
  });

  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.network(imageUrl),
          ListTile(
            title: Text(title),
            subtitle: Text(description),
          ),
          Text('\$${price.toStringAsFixed(2)}'),
          ElevatedButton(
            onPressed: onAddToCart,
            child: Text('Add to Cart'),
          ),
        ],
      ),
    );
  }
}

// Recipe Detail Screen
class RecipeDetailScreen extends StatelessWidget {
  final Map<String, String> recipe;

  RecipeDetailScreen({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe['title']!),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Recipe Image
            Image.network(
              recipe['imageUrl']!,
              height: 250.0,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20.0),
            // Recipe Title
            Text(
              recipe['title']!,
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            // Recipe Description
            Text(
              recipe['description']!,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 20.0),
            // Recipe Details (Steps or Ingredients)
            Text(
              'Recipe Details:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              recipe['details']!,
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}

// Add Recipe Screen
class AddRecipeScreen extends StatefulWidget {
  final Function(Map<String, String>) onAddRecipe;

  AddRecipeScreen({required this.onAddRecipe});

  @override
  _AddRecipeScreenState createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _imageUrl = '';
  String _description = '';
  String _details = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add Recipe'),
        ),
        body: Padding(
        padding: const EdgeInsets.all(16.0),
    child: Form(
    key: _formKey,
    child: ListView(
    children: [
    // Title Field
    TextFormField(
    decoration: InputDecoration(labelText: 'Recipe Title'),
    onSaved: (value) {
    _title = value!;
    },
    validator: (value) {
    if (value == null || value.isEmpty) {
    return 'Please enter a title';
    }
    return null;
    },
    ),
    SizedBox(height: 10.0),
    // Image URL Field
    TextFormField(
    decoration: InputDecoration(labelText: 'Image URL'),
    onSaved: (value) {
    _imageUrl = value!;
    },
    validator: (value) {
    if (value == null || value.isEmpty) {
    return 'Please enter an image URL';
    }
    return null;
    },
    ),
    SizedBox(height: 10.0),
    // Description Field
    TextFormField(
    decoration: InputDecoration(labelText: 'Recipe Description'),
    onSaved: (value) {
    _description = value!;
    },
    validator: (value) {
    if (value == null || value.isEmpty) {
    return 'Please enter a description';
    }
    return null;
    },
    ),
    SizedBox(height: 10.0),
    // Details Field
    TextFormField(
    decoration: InputDecoration(labelText: 'Recipe Details'),
    onSaved: (value) {
    _details = value!;
    },
    validator: (value) {
    if (value == null || value.isEmpty) {
    return 'Please enter the recipe details';
    }
    return null;
    },
    ),
      SizedBox(height: 20.0),
      // Submit Button
      ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            final newRecipe = {
              'title': _title,
              'imageUrl': _imageUrl,
              'description': _description,
              'details': _details,
            };
            widget.onAddRecipe(newRecipe);
            Navigator.pop(context);
          }
        },
        child: Text('Add Recipe'),
      ),
    ],
    ),
    ),
        ),
    );
  }
}

class CartScreen extends StatelessWidget {
  final List<Map<String, dynamic>> cart;

  CartScreen({required this.cart});

  @override
  Widget build(BuildContext context) {
    double totalPrice = cart.fold(0, (sum, item) => sum + item['price']);

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                final item = cart[index];
                return ListTile(
                  leading: Image.network(item['imageUrl']),
                  title: Text(item['title']),
                  subtitle: Text('\$${item['price'].toStringAsFixed(2)}'),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Total: \$${totalPrice.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Handle checkout or payment processing
            },
            child: Text('Checkout'),
          ),
        ],
      ),
    );
  }
}
