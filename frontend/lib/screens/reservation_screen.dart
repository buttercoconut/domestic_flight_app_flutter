import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/reservation_provider.dart';

class ReservationScreen extends ConsumerWidget {
  const ReservationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reservations = ref.watch(reservationListProvider);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'My Reservations',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: reservations.isEmpty
                ? const Center(child: Text('No reservations yet'))
                : ListView.builder(
                    itemCount: reservations.length,
                    itemBuilder: (context, index) {
                      final res = reservations[index];
                      return ListTile(
                        title: Text(res.flightNumber),
                        subtitle: Text(
                            'From ${res.from} to ${res.to} on ${res.date}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            ref
                                .read(reservationListProvider.notifier)
                                .cancelReservation(res.id);
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
