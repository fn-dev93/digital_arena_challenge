import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils/responsive.dart';
import '../../domain/entities/entities.dart';
import 'widgets.dart';

class PokemonCard extends StatelessWidget {
  final PokemonSummary pokemon;
  final VoidCallback onTap;

  const PokemonCard({
    super.key,
    required this.pokemon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final imageSize = context.responsive(
      mobile: 100.0,
      tablet: 120.0,
      desktop: 140.0,
    );
    final spacing = context.responsive(
      mobile: 8.0,
      tablet: 10.0,
      desktop: 12.0,
    );

    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'pokemon-${pokemon.id}',
              child: CachedNetworkImage(
                imageUrl: pokemon.imageUrl,
                height: imageSize,
                placeholder: (_, __) => const LoadingIndicator(),
                errorWidget: (context, url, error) => Icon(
                  Icons.catching_pokemon,
                  size: imageSize,
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(height: spacing),
            Text(
              pokemon.name.toUpperCase(),
              style: TextStyle(
                fontSize: ResponsiveFontSize.body(context),
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: spacing / 2),
            Text(
              '#${pokemon.id.toString().padLeft(3, '0')}',
              style: TextStyle(
                fontSize: ResponsiveFontSize.caption(context),
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
