import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/reservation.dart';

final reservationListProvider = StateNotifierProvider<ReservationListNotifier, List<Reservation>>((ref) {
  return ReservationListNotifier();
});

class ReservationListNotifier extends StateNotifier<List<Reservation>> {
  ReservationListNotifier() : super([]);

  void addReservation(Reservation res) {
    state = [...state, res];
  }

  void cancelReservation(String id) {
    state = state.where((r) => r.id != id).toList();
  }
}
