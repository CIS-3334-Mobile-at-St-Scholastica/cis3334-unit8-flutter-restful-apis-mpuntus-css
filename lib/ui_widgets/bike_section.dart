// ui_widgets/bike_section.dart
import 'package:flutter/material.dart';
import '../data_models/bikes_model.dart';
import '../services/bike_service.dart' as bike_svc;

class BikeSection extends StatelessWidget {
  const BikeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Network>>(
      future: bike_svc.fetchBikes(),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting ||
            snap.connectionState == ConnectionState.active) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snap.hasError) {
          return Center(child: Text('Error: ${snap.error}'));
        }

        final networks = snap.data ?? [];
        if (networks.isEmpty) {
          return const Center(child: Text('No networks found.'));
        }

        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: networks.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (context, i) {
            final net = networks[i];
            return ListTile(
              leading: const Icon(Icons.pedal_bike),
              title: Text(net.name),
              subtitle: Text(
                '${net.location.city}, ${net.location.country}',
              ),
              trailing: Text(net.id),
            );
          },
        );
      },
    );
  }
}
