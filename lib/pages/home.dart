import 'package:bnd/main.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

int _handleContainerTap_parameter = 0;

class _HomePageState extends State<HomePage> {
  _handleContainerTap(parameter) {
    // Add your button press handling logic here
    // print('Container tapped!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Color.fromARGB(200, 200, 200, 200),
        ),
        title: Text('BnD'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => LoginPage()),
                (_) => false,
              );
            },
            color: Color.fromARGB(200, 200, 200, 200),
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: GridView(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 35.0, // Increased spacing
                crossAxisSpacing: 30.0, // Increased spacing
                childAspectRatio: 1.5, // Aspect ratio for each grid item
              ),
              children: [
                _buildContainer(
                  'https://upload.wikimedia.org/wikipedia/commons/8/89/Vishalakshi_Mantap_Night.jpg',
                  'Art Of Living Courses',
                ),
                _buildContainer(
                  'https://booksbybnd.com/wp-content/uploads/2022/06/CST-Blog-Post-Header-1080x675.jpg',
                  'Learn CST',
                ),
                _buildContainer(
                  'https://booksbybnd.com/wp-content/uploads/2022/07/Alternative-healing-Header-1080x675.jpg',
                  'Learn Bach Flower Remedies',
                ),
                _buildContainer(
                  'https://upload.wikimedia.org/wikipedia/commons/8/89/Vishalakshi_Mantap_Night.jpg',
                  'Books by BnD',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContainer(String imageUrl, String title) {
    switch (title) {
      case 'Art Of Living Courses':
        _handleContainerTap_parameter = 1;
      case 'Learn CST':
        _handleContainerTap_parameter = 2;
      case 'Learn Bach Flower Remedies':
        _handleContainerTap_parameter = 3;
      case 'Books by BnD':
        _handleContainerTap_parameter = 4;
    }
    return GestureDetector(
      onTap: _handleContainerTap(_handleContainerTap_parameter),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 120, // Fixed height for the image container
              width: double
                  .infinity, // Make the image container take up the full width
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  height: 120, // Set the height of the image
                  width: double
                      .infinity, // Set the width of the image to match the container width
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: TextStyle(
                  color: Color.fromARGB(255, 227, 144, 10),
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
