import 'package:flutter/material.dart';

import '../../generated/assets.dart' show Assets;
import '../../repositories/shared_preferences_service.dart';
import '../authentication/sign_in_screen.dart';

class OnboardingScreen extends StatefulWidget {
  static const String route = '/onboarding';

  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late SharedPreferencesService _prefsService;

  final List<String> images = [
    Assets.onBoardUi1,
    Assets.onBoardUi2,
    Assets.onBoardUi3,
  ];

  final List<String> titles = [
    'We serve incomparable delicacies',
    'We serve incomparable delicacies',
    'We serve incomparable delicacies',
  ];

  final List<String> descriptions = [
    "All the best restaurants with their top menu waiting for you, they can't wait for your order!!",
    "All the best restaurants with their top menu waiting for you, they can't wait for your order!!",
    "All the best restaurants with their top menu waiting for you, they can't wait for your order!!",
  ];

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  void _nextPage() async {
    if (_currentPage < images.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Mark onboarding as completed
      await _prefsService.setOnboardingCompleted();
      print('Onboarding completed via Next button');
      Navigator.of(context).pushReplacementNamed(SignInScreen.route);
    }
  }

  void _skip() async {
    // Mark onboarding as completed
    await _prefsService.setOnboardingCompleted();
    print('Onboarding completed via Skip button');
    Navigator.of(context).pushReplacementNamed(SignInScreen.route);
  }

  @override
  void initState() {
    super.initState();
    _initializePrefsService();
  }

  Future<void> _initializePrefsService() async {
    _prefsService = await SharedPreferencesService.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Header with search and profile buttons
          Positioned(
            top: 50,
            right: 16,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 18,
                    ),
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(minWidth: 36, minHeight: 36),
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.person_outline,
                      color: Colors.white,
                      size: 18,
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/profile');
                    },
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(minWidth: 36, minHeight: 36),
                  ),
                ),
              ],
            ),
          ),
          PageView.builder(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            itemCount: images.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(images[index]),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    titles[_currentPage],
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    descriptions[_currentPage],
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Page indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(images.length, (index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: _currentPage == index ? 24 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? Colors.white
                              : Colors.white54,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _currentPage < images.length - 1
                          ? TextButton(
                              onPressed: _skip,
                              child: Text(
                                'Skip',
                                style: Theme.of(context).textTheme.labelLarge
                                    ?.copyWith(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onPrimary,
                                    ),
                              ),
                            )
                          : SizedBox(),
                      _currentPage < images.length - 1
                          ? TextButton(
                              onPressed: _nextPage,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Next',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge
                                        ?.copyWith(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.onPrimary,
                                        ),
                                  ),
                                  const SizedBox(width: 8),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onPrimary,
                                  ),
                                ],
                              ),
                            )
                          : GestureDetector(
                              onTap: _nextPage,
                              child: Container(
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onPrimary,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onPrimary,
                                    width: 3,
                                  ),
                                ),
                                child: Icon(
                                  Icons.arrow_forward,
                                  color: Theme.of(context).colorScheme.primary,
                                  size: 28,
                                ),
                              ),
                            ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
