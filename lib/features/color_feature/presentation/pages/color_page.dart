import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_color_project/features/color_feature/presentation/cubit/color_feature_cubit.dart';

class ColorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: getBody(context));
  }

  Widget getBody(BuildContext context) {
    var parentWidth = MediaQuery.of(context).size.width;
    var parentHeight = MediaQuery.of(context).size.height;
    var cubit = BlocProvider.of<ColorFeatureCubit>(context);

    return Container(
      width: parentWidth,
      height: parentHeight,
      child: BlocConsumer<ColorFeatureCubit, ColorFeatureState>(
        listener: (context, state) {
          if (state is ColorFeatureError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is ColorFeatureInitial) {
            return getBodyWidget(cubit);
          } else if (state is ColorFeatureLoading) {
            return getLoader();
          } else if (state is ColorFeatureLoaded) {
            var color = state.colorEntity.color;

            return getBodyWidget(cubit, color: color, text: color.toString());
          } else {
            return getBodyWidget(cubit);
          }
        },
      ),
    );
  }

  Widget getLoader() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget getBodyWidget(
    ColorFeatureCubit cubit, {
    color = Colors.white,
    text = 'Hey there',
  }) {
    return GestureDetector(
      onTap: () {
        cubit.getRandomColor();
      },
      child: Container(
        color: color,
        child: Center(
          child: Text(text),
        ),
      ),
    );
  }
}
