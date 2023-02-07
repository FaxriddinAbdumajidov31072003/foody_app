import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_app/view/components/cached_network_image.dart';
import 'package:foody_app/view/style/style.dart';
import 'package:provider/provider.dart';

import '../../../controller/home_controller.dart';
import '../../components/custom_textform.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final TextEditingController search = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeController>().getCategory(isLimit: false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("fdghjkl;");
    final state = context.watch<HomeController>();
    final event = context.read<HomeController>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Category"),
      ),
      body: Column(
        children: [
          CustomTextFrom(
            controller: search,
            label: "Search",
            onChange: (s) {
              print(s);
              event.searchCategory(s);
            },
            hintext: '',
          ),
          Expanded(
            child: GridView.builder(
                shrinkWrap: true,
                itemCount: state.listOfCategory.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: 200,
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(8),
                    width: 178.w,
                    height: 184,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(24)),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 50,
                            offset: Offset(0, 6),
                            color: Color(0xff5A6CEA).withOpacity(0.08))
                      ],
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        state.listOfCategory[index].image == null
                            ? const SizedBox.shrink()
                            : CustomImageNetwork(
                                image: state.listOfCategory[index].image ?? "",
                                height: 150,
                                width: 150,
                              ),
                        8.verticalSpace,
                        Text(state.listOfCategory[index].name ?? "",
                            style: Style.textStyleRegular2(
                                size: 14, textColor: const Color(0xff6D7580))),
                      ],
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
