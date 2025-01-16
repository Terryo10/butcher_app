import 'package:butcher_app/state/bloc/auth_bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/app_defaults.dart';
import '../../constants/app_icons.dart';
import '../../core/components/app_back_button.dart';
import '../../core/components/app_settings_tile.dart';

class SideBarPage extends StatelessWidget {
  const SideBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: const Text('Menu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppDefaults.padding),
        child: Column(
          children: [
            AppSettingsListTile(
              label: 'Invite Friend',
              trailing: SvgPicture.asset(AppIcons.right),
            ),
            AppSettingsListTile(
              label: 'About Us',
              trailing: SvgPicture.asset(AppIcons.right),
              onTap: () {},
            ),
            AppSettingsListTile(
              label: 'FAQs',
              trailing: SvgPicture.asset(AppIcons.right),
              onTap: () {},
            ),
            AppSettingsListTile(
              label: 'Terms & Conditions',
              trailing: SvgPicture.asset(AppIcons.right),
              onTap: () {},
            ),
            AppSettingsListTile(
              label: 'Help Center',
              trailing: SvgPicture.asset(AppIcons.right),
              onTap: () {},
            ),
            AppSettingsListTile(
              label: 'Rate This App',
              trailing: SvgPicture.asset(AppIcons.right),
              // onTap: () => Navigator.pushNamed(context, AppRoutes.help),
            ),
            AppSettingsListTile(
              label: 'Privacy Policy',
              trailing: SvgPicture.asset(AppIcons.right),
              // onTap: () => Navigator.pushNamed(context, AppRoutes.),
            ),
            AppSettingsListTile(
              label: 'Contact Us',
              trailing: SvgPicture.asset(AppIcons.right),
              onTap: () {},
            ),
            const SizedBox(height: AppDefaults.padding * 3),
            AppSettingsListTile(
              label: 'Logout',
              trailing: SvgPicture.asset(AppIcons.right),
              onTap: () => BlocProvider.of<AuthBloc>(context).add(LogOut()),
            ),
          ],
        ),
      ),
    );
  }
}
