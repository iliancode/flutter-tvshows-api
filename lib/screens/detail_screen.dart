import 'package:flutter/material.dart';
import '../models/show.dart';
import '../services/api_service.dart';

class DetailScreen extends StatelessWidget {
  final int showId;

  const DetailScreen({required this.showId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Show>(
      future: ApiService.fetchShowDetails(showId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Scaffold(body: Center(child: CircularProgressIndicator()));

        if (!snapshot.hasData)
          return Scaffold(body: Center(child: Text('Erreur de chargement')));

        final show = snapshot.data!;
        return Scaffold(
          appBar: AppBar(title: Text(show.name)),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: 'show_${show.id}',
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      show.image,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  show.description,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
