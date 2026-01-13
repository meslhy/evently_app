import 'package:evently_app1/ui/home/tabs/MapsTab/provider/maps_tab_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MapsTabScreen extends StatelessWidget {
  static const String routeName = "MapsTabScreen";
  const MapsTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MapsTabProvider provider = Provider.of<MapsTabProvider>(context);
    return Column(
      children: [
        Text(provider.locationMessage),
      ],
    );
  }
}
