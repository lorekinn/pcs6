import 'package:flutter/material.dart';
import '../models/note.dart';
import '../components/item_note.dart';
import '../pages/note_page.dart';

class HomePage extends StatefulWidget {
  final Set<Sweet> favoriteSweets;
  final Function(Sweet, bool) onFavoriteChanged;

  const HomePage({
    Key? key,
    required this.favoriteSweets,
    required this.onFavoriteChanged,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _priceController = TextEditingController();
  final _brandController = TextEditingController();
  final _flavorController = TextEditingController();
  final _ingredientsController = TextEditingController();

  void _toggleFavorite(Sweet sweet) {
    final isFavorite = widget.favoriteSweets.contains(sweet);
    widget.onFavoriteChanged(sweet, !isFavorite);
  }

  void _addNewSweet() {
    setState(() {
      sweets.add(
        Sweet(
          name: _nameController.text,
          description: _descriptionController.text,
          imageUrl: _imageUrlController.text,
          price: int.tryParse(_priceController.text) ?? 0,
          brand: _brandController.text,
          flavor: _flavorController.text,
          ingredients: _ingredientsController.text,
        ),
      );
    });

    _nameController.clear();
    _descriptionController.clear();
    _imageUrlController.clear();
    _priceController.clear();
    _brandController.clear();
    _flavorController.clear();
    _ingredientsController.clear();
  }

  void _showAddSweetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Добавить новый товар'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Название'),
                ),
                TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Описание'),
                ),
                TextField(
                  controller: _imageUrlController,
                  decoration: const InputDecoration(labelText: 'URL изображения'),
                ),
                TextField(
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Цена'),
                ),
                TextField(
                  controller: _brandController,
                  decoration: const InputDecoration(labelText: 'Бренд'),
                ),
                TextField(
                  controller: _flavorController,
                  decoration: const InputDecoration(labelText: 'Вкус'),
                ),
                TextField(
                  controller: _ingredientsController,
                  decoration: const InputDecoration(labelText: 'Ингредиенты'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Отмена'),
            ),
            ElevatedButton(
              onPressed: () {
                _addNewSweet();
                Navigator.of(context).pop();
              },
              child: const Text('Добавить'),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Вкусняшки'),
      ),
      body: GridView.builder(
        itemCount: sweets.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 2 / 3,
        ),
        itemBuilder: (context, index) {
          final sweet = sweets[index];
          final isFavorite = widget.favoriteSweets.contains(sweet);

          return Stack(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailPage(
                        sweet: sweet,
                        onDelete: () => setState(() {}),
                      ),
                    ),
                  );
                },
                child: Item(sweet: sweet),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.grey,
                  ),
                  onPressed: () {
                    _toggleFavorite(sweet);
                    setState(() {});
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
