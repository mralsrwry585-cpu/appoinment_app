import 'package:flutter/material.dart';
import 'package:flutter_application_4/models/property.dart';

class FeaturedPropertyCard extends StatelessWidget {
  final Property property;
  final VoidCallback? onTap;

  const FeaturedPropertyCard({super.key, required this.property, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          boxShadow: const [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 18,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(28),
              ),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  AspectRatio(
                    aspectRatio: 3 / 2,
                    child: property.imageAsset.startsWith('http')
                        ? Image.network(
                            property.imageAsset,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            errorBuilder: (_, __, ___) => Image.asset(
                              'images/fila.jpg',
                              fit: BoxFit.cover,
                            ),
                          )
                        : Image.asset(
                            property.imageAsset,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(width: 1),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.95),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Text(
                            property.statusLabel,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFFB76A40),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          property.titleAr,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF2F2A28),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF7EEE6),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Icon(
                          property.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: property.isFavorite
                              ? const Color(0xFFB76A40)
                              : const Color(0xFFB76A40),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    property.priceLabel,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFFB76A40),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    property.locationAr,
                    style: const TextStyle(
                      color: Color(0xFF7D7671),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _PropertyAttribute(label: '${property.bedrooms} غرف'),
                      _PropertyAttribute(label: '${property.bathrooms} حمامات'),
                      _PropertyAttribute(label: '${property.area} م²'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PropertyAttribute extends StatelessWidget {
  final String label;

  const _PropertyAttribute({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F1EB),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Color(0xFF726A67),
        ),
      ),
    );
  }
}
