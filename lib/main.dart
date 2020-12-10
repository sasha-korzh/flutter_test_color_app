import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_color_project/features/color_feature/presentation/pages/color_page.dart';
import 'features/color_feature/presentation/cubit/color_feature_cubit.dart';
import 'injection_container.dart' as di;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider<ColorFeatureCubit>(
        create: (_) => di.sl.get<ColorFeatureCubit>(),
        child: ColorPage()
      ),
    );
  }
}
