import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template counter_cubit}
/// A [Cubit] which manages an integer as its state.
/// {@endtemplate}
class CounterCubit extends Cubit<int> {
  /// {@macro counter_cubit}
  CounterCubit() : super(0);

  /// Increments the current state by 1.
  void increment() => emit(state + 1);

  /// Decrements the current state by 1.
  void decrement() => emit(state - 1);

  /// Resets the state to its initial value.
  void reset() => emit(0); // Explicitly emit 0 for clarity
}
