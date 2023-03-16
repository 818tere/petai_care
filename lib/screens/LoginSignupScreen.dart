import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginSignupScreen extends StatefulWidget {
  const LoginSignupScreen({super.key});

  @override
  State<LoginSignupScreen> createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  bool isSignupScreen = true;
  final _formKey = GlobalKey<FormState>();
  String userId = '';
  String password = '';
  String userName = '';

  void _tryValidation() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
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
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.blue.shade800,
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.pets, color: Colors.blue.shade200, size: 30),
                        const SizedBox(width: 10),
                        Text(
                          'Pet Care',
                          style: GoogleFonts.lato(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            //배경
            Positioned(
              top: 180,
              child: Container(
                padding: const EdgeInsets.all(18),
                height: isSignupScreen ? 280 : 280,
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
                                    color: Colors.blue.shade500,
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
                                    color: Colors.blue.shade500,
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
                                      return '아이디는 최소 4자 이상 입력해주세요';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    userId = value!;
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.account_circle,
                                        color: Colors.blue.shade500),
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
                                    hintText: '아이디',
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
                                    prefixIcon: Icon(Icons.create_outlined,
                                        color: Colors.blue.shade500),
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
                                    prefixIcon: Icon(Icons.lock,
                                        color: Colors.blue.shade500),
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
                                      return '아이디는 최소 4자 이상 입력해주세요';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    userId = value!;
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.account_circle,
                                        color: Colors.blue.shade500),
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
                                    hintText: '아이디',
                                    hintStyle: GoogleFonts.lato(
                                      color: Colors.grey,
                                      fontSize: 14,
                                    ),
                                    contentPadding: const EdgeInsets.all(10),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
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
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.lock,
                                        color: Colors.blue.shade500),
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
                        )
                    ],
                  ),
                ),
              ),
            ),
            //텍스트 폼 필드
            Positioned(
              top: 500,
              left: 0,
              right: 0,
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    _tryValidation();
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
                        color: Colors.blue.shade500,
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
