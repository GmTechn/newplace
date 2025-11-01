import 'package:flutter_application_3/database.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../modele/endroit.dart';

class EndroitsNotifier extends StateNotifier<List<Endroit>> {
  EndroitsNotifier() : super([]) {
    _loadEndroits();
  }

  Future<void> _loadEndroits() async {
    final data = await EndroitsDatabase.instance.fetchAllEndroits();
    state = data;
  }

  Future<void> addEndroit(Endroit endroit) async {
    await EndroitsDatabase.instance.insertEndroit(endroit);
    state = [...state, endroit];
  }

  Future<void> removeAt(int index) async {
    final id = state[index].id;
    await EndroitsDatabase.instance.deleteEndroit(id);
    state = [
      for (int i = 0; i < state.length; i++)
        if (i != index) state[i],
    ];
  }
}

// ✅ Single consistent provider
final endroitsprovider = StateNotifierProvider<EndroitsNotifier, List<Endroit>>(
  (ref) {
    return EndroitsNotifier();
  },
);
