// Level 7 - State Management: Bloc/Cubit (Counter)
// Cubit<int> menyimpan state; emit() mengubah state dan memicu rebuild.
// Pola terstruktur: state immutable, perubahan lewat method Cubit.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  void increment() => emit(state + 1);
  void reset() => emit(0);
}

class CounterBlocScreen extends StatelessWidget {
  const CounterBlocScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Counter - Bloc/Cubit'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Klik tombol untuk menambah:',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              BlocBuilder<CounterCubit, int>(
                builder: (context, count) {
                  return Text(
                    '$count',
                    style: Theme.of(context).textTheme.displayLarge,
                  );
                },
              ),
              const SizedBox(height: 24),
              BlocBuilder<CounterCubit, int>(
                builder: (context, count) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () => context.read<CounterCubit>().increment(),
                        child: const Text('+1'),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () => context.read<CounterCubit>().reset(),
                        child: const Text('Reset'),
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
