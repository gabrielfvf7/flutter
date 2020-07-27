import 'package:flutter/material.dart';
import 'package:greatPlaces/providers/great_places.dart';
import 'package:greatPlaces/screens/add_place_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () =>
                Navigator.of(context).pushNamed(AddPlaceScreen.routeName),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false).fetchAndSet(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(child: CircularProgressIndicator())
            : Consumer<GreatPlaces>(
                child: Center(
                  child: Text(
                    'Got no places yet, add some!',
                  ),
                ),
                builder: (ctx, greatPlacesData, child) =>
                    greatPlacesData.items.length <= 0
                        ? child
                        : ListView.builder(
                            itemCount: greatPlacesData.items.length,
                            itemBuilder: (context, index) => ListTile(
                              leading: CircleAvatar(
                                backgroundImage: FileImage(
                                    greatPlacesData.items[index].image),
                              ),
                              title: Text(greatPlacesData.items[index].title),
                              onTap: () => null,
                            ),
                          ),
              ),
      ),
    );
  }
}
