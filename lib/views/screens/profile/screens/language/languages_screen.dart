import 'package:dhenu_dharma/utils/providers/language_provider.dart';
import 'package:dhenu_dharma/views/widgets/custom_bottom_navigation_bar.dart';
import 'package:dhenu_dharma/views/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/constants/app_assets.dart';
import '../../../../../utils/constants/app_colors.dart';
import '../../components/profile_background_component.dart';
import '../../components/screen_label_component.dart';


class LanguagesScreen extends StatefulWidget {
  const LanguagesScreen({super.key});

  @override
  State<LanguagesScreen> createState() => _LanguagesScreen();
}


class _LanguagesScreen extends State<LanguagesScreen> {


@override
  void initState() {
    super.initState();
    // Fetch initial cow shed data immediately without async gap
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final languageProvider =
          Provider.of<LanguageProvider>(context, listen: false);
      languageProvider
          .fetchLanguages(
    
      )
          .then((_) {
        if (mounted) {
          print('Fetched Cow Sheds: ${languageProvider.languages}');
        }
      }).catchError((error) {
        if (mounted) {
          print('Error fetching Cow Sheds: $error');
        }
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ProfileBackgroundComponent(bgImg: AssetsConstants.userProfileBgImg1),
          buildLanguagesContent(context),
          ScreenLabelComponent(
            // Removed const
            label: "Languages",
            icon: Icons.language,
          ),
        ],
      ),
      bottomNavigationBar:
          CustomBottomNavigationBar(pageIndex: 2), // Removed const
    );
  }

  Widget buildLanguagesContent(BuildContext context) {
    return Positioned(
      top: 150.h,
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w).copyWith(top: 44.h),
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.secondaryWhite,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(70.w),
          ),
        ),
        child: Consumer<LanguageProvider>(
          builder: (context, languageProvider, child) {
            if (languageProvider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            
print('Languages in Language screen: ${languageProvider.languages}');
            if (languageProvider.errorMessage.isNotEmpty) {
              return Center(
                child: Text(
                  languageProvider.errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }

            if (languageProvider.languages.isEmpty) {
              return const Center(child: Text("No languages available."));
            }

            return ListView.builder(
              itemCount: languageProvider.languages.length,
              itemBuilder: (context, index) {
                final language = languageProvider.languages[index];
                final isSelected =
                    true;

                return ListTile(
                  title: Text(language['translated_name'] ?? language['name']),
                  trailing: isSelected ? const Icon(Icons.check_circle) : null,
                  onTap: () {
                    // languageProvider.setSelectedLanguage(language['code']);
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget buildLanguageOption(
    BuildContext context,
    Locale locale,
    String language,
    bool isSelected,
  ) {
    return ListTile(
      title: Text(language, style: TextStyle(fontSize: 18.h)),
      trailing: isSelected
          ? const Icon(Icons.check_circle, color: Colors.green)
          : null,
      onTap: () {
        final languageProvider =
            Provider.of<LanguageProvider>(context, listen: false);
        // languageProvider.setSelectedLanguage(locale.languageCode);
      },
    );
  }
}
