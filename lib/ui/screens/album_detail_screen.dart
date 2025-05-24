import 'package:flutter/material.dart';

class AlbumDetailScreen extends StatelessWidget {
  final Map<String, dynamic> data;

  AlbumDetailScreen({required this.data});

  @override
  Widget build(BuildContext context) {
    final album = data['album'];
    final photos = data['photos'] as List;

    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Album #${album.id}'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Title: ${album.title}',
                style: theme.textTheme.titleLarge,
              ),
              const SizedBox(height: 4),
              Text(
                'User ID: ${album.id}',
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              Text(
                'Photos:',
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.4,
                ),
                itemCount: photos.length,
                itemBuilder: (context, index) {
                  final photo = photos[index];
                  final imageUrl = photo.thumbnailUrl != null && photo.thumbnailUrl.isNotEmpty
                      ? photo.thumbnailUrl
                      : 'https://via.placeholder.com/150';
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 90,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.red.shade200),
                        ),
                        child: Image.network(
                          imageUrl,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.broken_image),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        photo.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
