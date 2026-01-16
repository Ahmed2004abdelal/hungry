import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'core/constant/app_color.dart';
import 'features/auth/data/auth_repo.dart';
import 'features/auth/view/login_view.dart';
import 'root.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;
  late Animation<double> _fadeAnim;

  AuthRepo authRepo = AuthRepo();
  // Future<void> _checklogin()async{
  //   if(authRepo.currentuser != null){
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (c) => Root()),
  //     );
  //   }else if(authRepo.isGuest){
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (c) => Root()),
  //     );
  //   }else{
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (c) => LoginView()),
  //     );
  //   }
  // }

  Future<void> _checklogin() async {
    final user = await authRepo.autologin();

    if (user != null) {
      // مستخدم مسجل فعلاً
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (c) => Root()),
      );
    } else if (authRepo.isGuest) {
      // داخل كضيف
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (c) => Root()),
      );
    } else {
      // مش مسجل ولا ضيف
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (c) => LoginView()),
      );
    }
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _scaleAnim = CurvedAnimation(parent: _controller, curve: Curves.elasticOut);
    _fadeAnim = Tween<double>(begin: 0, end: 1).animate(_controller);

    _controller.forward();

    Future.delayed(const Duration(seconds: 4), _checklogin);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColor.prim,
      body: FadeTransition(
        opacity: _fadeAnim,
        child: ScaleTransition(
          scale: _scaleAnim,
          child: Stack(
            children: [
              Positioned(
                top: size.height * 0.15, // الربع الأول تقريباً
                left: 0,
                right: 0,
                child: Center(
                  child: SvgPicture.asset("assets/logo/Hungry.svg"),
                ),
              ),

              Positioned(
                bottom: -30, // مكان مناسب من الأسفل
                left: 0,
                right: 0,
                child: Center(
                  child: Image.asset('assets/splash/splash.png', height: 300),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
