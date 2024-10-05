import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quivor/core/bloc/base_cubit.dart';
import 'package:quivor/core/bloc/base_state.dart';

Widget _builder<S extends BaseState>(BuildContext context, S state) {
  if (state.isLoading) {
    return Center(child: CircularProgressIndicator());
  }
  return _builder(context, state);
}

class CustomCubitBuilder<B extends StateStreamable<S>, S extends BaseState>
    extends BlocBuilder<B, S> {
  CustomCubitBuilder({required Widget Function(BuildContext, S) builder})
      : super(
          builder: (context, state) {
            if (state.isLoading) {
              return Center(child: CircularProgressIndicator());
            }
            return builder(context, state);
          },
        );

  // @override
  // Widget builder(BuildContext context, S state) {
  //   if (state.isLoading) {
  //     return Center(child: CircularProgressIndicator());
  //   }
  //   return builder(context, state);
  // }

  // @override
  // Widget buildx(BuildContext context, S data)  {
  //  if(data.isLoading){
  //   return Center(child: CircularProgressIndicator());
  //  }
  //  return builder(context, data);
  // }
  // @override
  // Widget builder(BuildContext context, S data) {
  //   if (data.isLoading) {
  //     return Center(child: CircularProgressIndicator());
  //   }
  //  // return builder(context, data);
  // }
}

// class X extends StatefulWidget {
//   const X({super.key});

//   @override
//   State<X> createState() => _XState();
// }

// class _XState extends State<X> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

// class Z {
//   int x() {
//     print('x');
//     return 0;
//   }
// }

// class Y extends Z {
//   @override
//   int? x() {
//     super.x();
//     print('y');
//   }
// }
