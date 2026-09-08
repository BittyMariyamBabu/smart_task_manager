import 'package:flutter/material.dart';
import 'package:task_manager/features/auth/presentation/pages/login_page.dart';
import 'package:task_manager/features/onboarding/models/onboarding_model.dart';
import 'package:task_manager/features/onboarding/presentation/widgets/onboarding_background.dart';
import 'package:task_manager/features/onboarding/presentation/widgets/onboarding_bottom_section.dart';
import 'package:task_manager/features/onboarding/presentation/widgets/onboarding_content.dart';
import 'package:task_manager/features/onboarding/presentation/widgets/onboarding_header_logo.dart';

/// A page that displays the onboarding flow for the Smart Task Manager application.
/// 
/// This page consists of multiple onboarding screens that introduce the app's features to the user.
class OnboardingPage extends StatefulWidget {
  const OnboardingPage({
    super.key,
  });

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();

  int _currentPage = 0;

  static const List<OnboardingModel> _items = [
    OnboardingModel(
      title: 'Organize your tasks',
      description:
          'Keep everything in one place and turn your busy day into a clear, manageable plan.',
      illustration: OnboardingIllustration.organize,
    ),
    OnboardingModel(
      title: 'Never miss a deadline',
      description:
          'Set priorities, track due dates, and always know what deserves your attention next.',
      illustration: OnboardingIllustration.deadlines,
    ),
    OnboardingModel(
      title: 'Get more done',
      description:
          'Complete tasks, track your progress, and build a more productive daily routine.',
      illustration: OnboardingIllustration.productivity,
    ),
  ];

  bool get _isFirstPage => _currentPage == 0;

  bool get _isLastPage =>
      _currentPage == _items.length - 1;

  void _nextPage() {
    if (_isLastPage) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const LoginPage(),
        ),
      );
      return;
    }

    _pageController.nextPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutCubic,
    );
  }

  void _previousPage() {
    if (_isFirstPage) {
      return;
    }

    _pageController.previousPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnboardingBackground(
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;
              final height = constraints.maxHeight;

              final isTablet = width >= 600;

              return Column(
                children: [

                  OnboardingHeader(
                    isTablet: isTablet,
                    onPressed:() => Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) => const LoginPage(),
                      ),
                    ),
                  ),

                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: _items.length,
                      onPageChanged: (index) {
                        setState(() {
                          _currentPage = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        return OnboardingContent(
                          item: _items[index],
                          availableHeight: height,
                          availableWidth: width,
                        );
                      },
                    ),
                  ),

                  OnboardingBottomSection(
                    isTablet: isTablet,
                    currentPage: _currentPage,
                    itemCount: _items.length,
                    onNext: _nextPage,
                    onBack: _previousPage,
                    isFirstPage: _isFirstPage,
                    isLastPage: _isLastPage,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}