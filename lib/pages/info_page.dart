import 'package:flutter/widgets.dart';
import 'package:flutter_focus_fun_tv_demo/data/info_section_data.dart';
import 'package:flutter_focus_fun_tv_demo/model/page_ui_model.dart';
import 'package:flutter_focus_fun_tv_demo/pages/any_page.dart';
import 'package:provider/provider.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PageUiModel(infoSectionRails),
      child: AnyPage(key: const Key('InfoPage')),
    );
  }
}
