// 📦 endroit_utilisateurs.dart
import 'package:flutter_application_3/database/database.dart';
import 'package:flutter_application_3/modele/endroit.dart';
import 'package:flutter_riverpod/legacy.dart';

/// Provider for managing the list of saved places (Endroits)
final endroitsprovider = StateNotifierProvider<EndroitsNotifier, List<Endroit>>(
  (ref) {
    return EndroitsNotifier();
  },
);

/// Notifier that syncs Riverpod state with the local SQLite database
class EndroitsNotifier extends StateNotifier<List<Endroit>> {
  EndroitsNotifier() : super([]) {
    _loadEndroits(); // Load data from DB on app startup
  }

  /// Load all saved places from SQLite
  Future<void> _loadEndroits() async {
    try {
      final endroits = await EndroitsDatabase.instance.fetchAllEndroits();
      state = endroits;
    } catch (e) {
      print('❌ Error loading places: $e');
    }
  }

  /// Add a new place to DB and update state
  Future<void> addEndroit(Endroit endroit) async {
    try {
      await EndroitsDatabase.instance.insertEndroit(endroit);
      state = [...state, endroit];
    } catch (e) {
      print('❌ Error adding place: $e');
    }
  }

  /// Delete a place (by index or ID) from both DB and state
  Future<void> removeAt(int index) async {
    try {
      final endroitToDelete = state[index];
      await EndroitsDatabase.instance.deleteEndroit(endroitToDelete.id);
      state = [...state]..removeAt(index);
    } catch (e) {
      print('❌ Error deleting place: $e');
    }
  }

  /// Delete all saved places (optional utility)
  Future<void> clearAll() async {
    try {
      for (final endroit in state) {
        await EndroitsDatabase.instance.deleteEndroit(endroit.id);
      }
      state = [];
    } catch (e) {
      print('❌ Error clearing all places: $e');
    }
  }
}
