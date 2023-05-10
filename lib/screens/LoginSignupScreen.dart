import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:petai_care/screens/main_screens.dart';

class LoginSignupScreen extends StatefulWidget {
  const LoginSignupScreen({super.key});

  @override
  State<LoginSignupScreen> createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  final _auth = FirebaseAuth.instance;

  bool isSignupScreen = true;
  final _formKey = GlobalKey<FormState>();
  String userEmail = '';
  String password = '';
  String userName = '';

  void _tryValidation() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: const BoxDecoration(
                  color: Color(0xffF9DEDC),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 100),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/main_logo.png',
                          scale: 2,
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            //배경
            Positioned(
              top: 250,
              child: Container(
                padding: const EdgeInsets.all(18),
                height: isSignupScreen ? 280 : 220,
                width: MediaQuery.of(context).size.width - 40,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 15,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isSignupScreen = false;
                              });
                            },
                            child: Column(
                              children: [
                                Text(
                                  '로그인',
                                  style: GoogleFonts.lato(
                                    color: !isSignupScreen
                                        ? Colors.black
                                        : Colors.grey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                if (!isSignupScreen)
                                  Container(
                                    margin: const EdgeInsets.only(top: 3),
                                    height: 2,
                                    width: 55,
                                    color: const Color(0xff8C1D18),
                                  )
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isSignupScreen = true;
                              });
                            },
                            child: Column(
                              children: [
                                Text(
                                  '회원가입',
                                  style: GoogleFonts.lato(
                                    color: isSignupScreen
                                        ? Colors.black
                                        : Colors.grey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                if (isSignupScreen)
                                  Container(
                                    margin: const EdgeInsets.only(top: 3),
                                    height: 2,
                                    width: 55,
                                    color: const Color(0xff8C1D18),
                                  )
                              ],
                            ),
                          ),
                        ],
                      ),
                      if (isSignupScreen)
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  key: const ValueKey(1),
                                  validator: (value) {
                                    if (value!.isEmpty || value.length < 4) {
                                      return '이메일을 정확히 입력해주세요';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    userEmail = value!;
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.account_circle,
                                        color: Color(0xff8C1D18)),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    hintText: '이메일',
                                    hintStyle: GoogleFonts.lato(
                                      color: Colors.grey,
                                      fontSize: 14,
                                    ),
                                    contentPadding: const EdgeInsets.all(10),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
                                  key: const ValueKey(2),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return '닉네임을 입력해주세요';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    userName = value!;
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                        Icons.create_outlined,
                                        color: Color(0xff8C1D18)),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    hintText: '닉네임',
                                    hintStyle: GoogleFonts.lato(
                                      color: Colors.grey,
                                      fontSize: 14,
                                    ),
                                    contentPadding: const EdgeInsets.all(10),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
                                  obscureText: true,
                                  key: const ValueKey(3),
                                  validator: (value) {
                                    if (value!.isEmpty || value.length < 6) {
                                      return '패스워드는 최소 6자 이상 입력해주세요';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    password = value!;
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.lock,
                                        color: Color(0xff8C1D18)),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    hintText: '패스워드',
                                    hintStyle: GoogleFonts.lato(
                                      color: Colors.grey,
                                      fontSize: 14,
                                    ),
                                    contentPadding: const EdgeInsets.all(10),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      if (!isSignupScreen)
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  key: const ValueKey(4),
                                  validator: (value) {
                                    if (value!.isEmpty || value.length < 4) {
                                      return '이메일을 정확히 입력해주세요';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    userEmail = value!;
                                  },
                                  onChanged: (value) {
                                    userEmail = value;
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.account_circle,
                                        color: Color(0xff8C1D18)),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    hintText: '이메일',
                                    hintStyle: GoogleFonts.lato(
                                      color: Colors.grey,
                                      fontSize: 14,
                                    ),
                                    contentPadding: const EdgeInsets.all(10),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
                                  obscureText: true,
                                  key: const ValueKey(5),
                                  validator: (value) {
                                    if (value!.isEmpty || value.length < 6) {
                                      return '패스워드는 최소 6자 이상 입력해주세요';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    password = value!;
                                  },
                                  onChanged: (value) {
                                    password = value;
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.lock,
                                        color: Color(0xff8C1D18)),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    hintText: '패스워드',
                                    hintStyle: GoogleFonts.lato(
                                      color: Colors.grey,
                                      fontSize: 14,
                                    ),
                                    contentPadding: const EdgeInsets.all(10),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            //텍스트 폼 필드
            Positioned(
              top: 550,
              left: 0,
              right: 0,
              child: Center(
                child: GestureDetector(
                  onTap: () async {
                    if (isSignupScreen) {
                      _tryValidation();
                      try {
                        final newUser =
                            await _auth.createUserWithEmailAndPassword(
                                email: userEmail, password: password);
                        if (newUser.user != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return const MainScreens();
                            }),
                          );
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('이메일을 정확히 입력해주세요'),
                            backgroundColor: Colors.blue,
                          ),
                        );
                      }
                    } //회원가입 메서드
                    if (!isSignupScreen) {
                      _tryValidation();
                      try {
                        final newUser = await _auth.signInWithEmailAndPassword(
                            email: userEmail, password: password);
                        if (newUser.user != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return const MainScreens();
                            }),
                          );
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('이메일을 정확히 입력해주세요'),
                            backgroundColor: Colors.blue,
                          ),
                        );
                      }
                    } //로그인 메서드
                  },
                  child: Container(
                    height: 50,
                    width: 90,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xff8C1D18),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 1,
                            spreadRadius: 1,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          '다음',
                          style: GoogleFonts.lato(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            //전송버튼
          ],
        ),
      ),
    );
  }
}
