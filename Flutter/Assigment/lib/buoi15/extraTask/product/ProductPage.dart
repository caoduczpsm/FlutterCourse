import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ProductCubit.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => ProductCubit(),
        child: _ProductPage(),
      ),
    );
  }

}

class _ProductPage extends StatelessWidget {

  static const titleStyle = TextStyle(fontSize: 18);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter App using Cubit'),
      ),
      body: BlocBuilder<ProductCubit, int>(
        builder: (context, state) => Center(
          child: ListView.builder(
            itemCount: state,
            itemBuilder: (context, index) => Card(
              child: (ListTile(
                leading: Text(
                  "Product ${index + 1}",
                  style: titleStyle,
                ),
              )),
            ),
          )
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () => context.read<ProductCubit>().increase()
          ),
          const SizedBox(width: 10,),
          FloatingActionButton(
              child: const Icon(Icons.remove),
              onPressed: () => context.read<ProductCubit>().decrease()
          ),
        ],
      ),
    );
  }


}