import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/show_provider.dart';
import '../providers/theme_provider.dart';
import '../screens/detail_screen.dart';
import '../widgets/show_tile.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<ShowProvider>(context, listen: false);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 100 &&
          !provider.isLoading &&
          provider.hasMore) {
        provider.loadMore();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final showProvider = Provider.of<ShowProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Séries TV'),
        actions: [
          IconButton(
            icon: Icon(themeProvider.isDarkMode
                ? Icons.light_mode
                : Icons.dark_mode),
            onPressed: () {
              themeProvider.toggleTheme();
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              onChanged: showProvider.setSearchQuery,
              decoration: InputDecoration(
                hintText: 'Rechercher une série...',
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Theme.of(context).cardColor,
                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ),
      ),
      body: showProvider.isLoading && showProvider.shows.isEmpty
          ? Center(child: CircularProgressIndicator())
          : showProvider.shows.isEmpty
          ? Center(child: Text('Aucune série trouvée.'))
          : GridView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.all(12),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 2 / 3,
        ),
        itemCount:
        showProvider.shows.length + (showProvider.hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index < showProvider.shows.length) {
            final show = showProvider.shows[index];
            return ShowTile(
              show: show,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailScreen(showId: show.id),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
