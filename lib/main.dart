import 'package:flutter/material.dart';

void main() {
  runApp(const ShoppingApp());
}

class ShoppingApp extends StatelessWidget {
  const ShoppingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Las Valeburguer ', // Updated title as requested
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0; // Controls the selected tab

  // List of widgets for each tab
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    ShoppingListScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // The syntax error line 'の部分;' has been removed.
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi App de Compras'),
        elevation: 0, // Removes AppBar shadow for a cleaner design
      ),
      body: Center(
        child: _widgetOptions.elementAt(
            _selectedIndex), // Displays the widget of the selected tab
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Comprar',
          ),
        ],
        currentIndex: _selectedIndex, // Marks the current tab
        selectedItemColor: Colors.blueAccent, // Color of the selected tab
        onTap: _onItemTapped, // Function to change tabs
      ),
    );
  }
}

// ---
// ## Home Screen
// ---
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // List of image URLs for the offer products
  final List<String> offerImageUrls = const [
    'https://raw.githubusercontent.com/ValentinLoya/imagenes/refs/heads/main/hamburguesa%20especial.webp',
    'https://raw.githubusercontent.com/ValentinLoya/imagenes/refs/heads/main/hamburguesa%20doble.avif',
    'https://raw.githubusercontent.com/ValentinLoya/imagenes/refs/heads/main/hamburguesa%20sencilla.webp',
    'https://raw.githubusercontent.com/ValentinLoya/imagenes/refs/heads/main/papas.jpg',
    'https://raw.githubusercontent.com/ValentinLoya/imagenes/refs/heads/main/refresco.jpg',
  ];

  // List of names corresponding to the offer products
  final List<String> offerProductNames = const [
    'Hamburguesa Especial',
    'Hamburguesa Doble',
    'Hamburguesa Sencilla',
    'Papas Fritas',
    'Refresco Grande',
  ];

  // List of descriptions corresponding to the offer products
  final List<String> offerProductDescriptions = const [
    'Deliciosa hamburguesa con ingredientes premium y salsa secreta.',
    'Doble carne y doble queso para los más hambrientos.',
    'La clásica que nunca falla, con lechuga fresca y tomate.',
    'Crujientes papas fritas, perfectas para acompañar tu hamburguesa.',
    'Refresco frío para refrescarte, disponible en varios sabores.',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Sliding images section (PageView)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              height: 200, // PageView height
              child: PageView(
                children: <Widget>[
                  // URLs of your GitHub images for the PageView
                  _buildImageCard('https://raw.githubusercontent.com/ValentinLoya/imagenes/refs/heads/main/logo.jpg', 'Oferta de Verano'),
                  _buildImageCard('https://raw.githubusercontent.com/ValentinLoya/imagenes/refs/heads/main/hawa.jpg', 'Nuevos Productos'),
                  _buildImageCard('https://raw.githubusercontent.com/ValentinLoya/imagenes/refs/heads/main/hamburguesa%20hawaiana.jpg', 'Descuentos Exclusivos'),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              'Artículos en Oferta Top',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // List of offer items (ListView.builder)
          ListView.builder(
            shrinkWrap:
                true, // Important for ListView.builder to work inside SingleChildScrollView
            physics:
                const NeverScrollableScrollPhysics(), // Disables ListView's own scrolling
            itemCount: offerImageUrls
                .length, // Number of example items based on image list length
            itemBuilder: (context, index) {
              final int actualIndex = index % offerImageUrls.length;
              return Card(
                margin:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: <Widget>[
                      // Use Image.network for the product image in the list
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          offerImageUrls[
                              actualIndex], // Use different image for each item
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                          // Shows a loading indicator or an error icon
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              width: 80,
                              height: 80,
                              color: Colors.grey[300],
                              child: Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 80,
                              height: 80,
                              color: Colors.grey[300],
                              child: Icon(Icons.broken_image,
                                  size: 50, color: Colors.grey[600]),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              offerProductNames[
                                  actualIndex], // Use the name from the list
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '¡Gran descuento! Solo \$${(20.0 - index * 2).toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.green,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              offerProductDescriptions[actualIndex], // Use the description from the list
                              style: TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add_shopping_cart,
                            color: Colors.blue),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                                    'Añadido ${offerProductNames[actualIndex]} al carrito')),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 16), // Space at the end
        ],
      ),
    );
  }

  // Helper widget for sliding image cards (PageView)
  Widget _buildImageCard(String imageUrl, String title) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        // Use ClipRRect to round image corners
        borderRadius: BorderRadius.circular(8.0),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              imageUrl,
              fit: BoxFit.cover,
              // A loading indicator while the image is downloading
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
              // An error widget if the image fails to load
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.blueGrey[100],
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error, size: 50, color: Colors.red),
                        SizedBox(height: 8),
                        Text('Error al cargar imagen',
                            textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                );
              },
            ),
            // A gradient and text to overlay on the image
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                ),
              ),
            ),
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---
// ## Shopping List Screen
// ---
class ShoppingListScreen extends StatelessWidget {
  const ShoppingListScreen({super.key});

  // List of image URLs for the shopping list items
  final List<String> shoppingListImageUrls = const [
    'https://raw.githubusercontent.com/ValentinLoya/imagenes/refs/heads/main/burguers.jpg',
    'https://raw.githubusercontent.com/ValentinLoya/imagenes/refs/heads/main/burguer1.jpg',
    'https://raw.githubusercontent.com/ValentinLoya/imagenes/refs/heads/main/hamburguesa%20especial.webp',
    'https://raw.githubusercontent.com/ValentinLoya/imagenes/refs/heads/main/hamburguesa%20doble.avif',
    'https://raw.githubusercontent.com/ValentinLoya/imagenes/refs/heads/main/hamburguesa%20sencilla.webp',
    'https://raw.githubusercontent.com/ValentinLoya/imagenes/refs/heads/main/hawa.jpg',
    'https://raw.githubusercontent.com/ValentinLoya/imagenes/refs/heads/main/logo.jpg',
    // You can add more URLs here to have more unique images
  ];

  // List of names corresponding to the shopping list items
  final List<String> shoppingListNames = const [
    'Combo de Hamburguesas',
    'Hamburguesa Clásica',
    'Hamburguesa Especial',
    'Hamburguesa Doble',
    'Hamburguesa Sencilla',
    'Hamburguesa Hawaiana',
    'Kit de Bienvenida',
  ];

  // List of descriptions corresponding to the shopping list items
  final List<String> shoppingListDescriptions = const [
    'Un festín de hamburguesas para compartir con amigos o familia.',
    'La hamburguesa tradicional con el sabor inconfundible de siempre.',
    'Nuestra especialidad, con ingredientes seleccionados y un toque único.',
    'El doble de sabor y satisfacción en cada bocado.',
    'Perfecta para un antojo rápido y delicioso.',
    'Una explosión de sabor tropical con piña y jamón.',
    'Todo lo que necesitas para empezar tu experiencia Valeburguer.',
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10, // Number of example items
      itemBuilder: (context, index) {
        final int actualIndex = index % shoppingListImageUrls.length;
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: <Widget>[
                // Use Image.network for the item image in the shopping list
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    shoppingListImageUrls[
                        actualIndex], // Use different image for each item
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    // Shows a loading indicator or an error icon
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        width: 80,
                        height: 80,
                        color: Colors.grey[200],
                        child: Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 80,
                        height: 80,
                        color: Colors.grey[200],
                        child: Icon(Icons.shopping_bag_outlined,
                            size: 50, color: Colors.grey[500]),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        shoppingListNames[
                            actualIndex], // Use the name from the list
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Categoría: Comida - Precio: \$${(35.0 + index * 5).toStringAsFixed(2)}', // Adjusted category
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.deepPurple,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        shoppingListDescriptions[actualIndex], // Use the description from the list
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.favorite_border,
                      color: Colors.redAccent),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(
                              'Añadido ${shoppingListNames[actualIndex]} a favoritos')),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
