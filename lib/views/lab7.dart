import 'package:flutter/material.dart';

class myapp extends StatefulWidget {
  const myapp({super.key});

  @override
  State<myapp> createState() => _myappState();
}

class _myappState extends State<myapp> {
  bool ishidden = true;

  final name = TextEditingController();
  final Email = TextEditingController();
  final pass = TextEditingController();
  final phone = TextEditingController();
  final key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        leading: Icon(Icons.menu, color: Colors.white),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Image.asset('/images/11.png', height: 40, width: 60),
          ),
        ],
        backgroundColor: Colors.pink,
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          SizedBox(height: 16),

          Text('ادخل بياناتك هنا ', style: TextStyle(color: Colors.pink)),

          Form(
            key: key,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  SizedBox(height: 30),

                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'يرجى ادخال نص';
                      }
                      return null;
                    },
                    controller: name,
                    decoration: InputDecoration(
                      labelText: 'الاسم ',

                      hintText: 'ادخل الاسم ',
                      prefixIcon: Icon(Icons.person, color: Colors.pink),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide(width: 10),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),

                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'يرجى ادخال  ايميل';
                      }

                      if (!RegExp(
                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                      ).hasMatch(value)) {
                        return 'الايميل غير صحيح';
                      }

                      return null;
                    },
                    controller: Email,
                    decoration: InputDecoration(
                      labelText: 'الايميل',

                      hintText: 'ادخل ايميلك ',
                      prefixIcon: Icon(Icons.email, color: Colors.pink),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide(width: 10),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),

                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'يرجى ادخال باسورد';
                      }
                      if (value.length <= 8) {
                        return 'يرجى ادخال كلمة سر قوية ';
                      }
                      return null;
                    },
                    obscureText: ishidden,
                    controller: pass,
                    decoration: InputDecoration(
                      labelText: 'كلمة المرور',

                      hintText: 'ادخل كلمة المرور   ',
                      prefixIcon: Icon(Icons.lock, color: Colors.pink),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            ishidden = !ishidden;
                          });
                        },
                        icon: ishidden
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide(width: 10),
                      ),
                    ),
                  ),

                  SizedBox(height: 16),

                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'يرجى ادخال رقم هاتف';
                      }
                      return null;
                    },
                    controller: phone,
                    decoration: InputDecoration(
                      labelText: 'رقم الهاتف',

                      hintText: 'ادخل رقم الهاتف ',
                      prefixIcon: Icon(
                        Icons.phone,
                        color: const Color.fromARGB(255, 172, 107, 129),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide(width: 10),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (key.currentState!.validate()) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('البيانات المدخلة'),
                              content: Column(
                                children: [
                                  Text('name : ${name.text}'),
                                  Text('Email : ${Email.text}'),

                                  Text('phone : ${phone.text}'),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('تم'),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        //kk
                      }
                    },
                    child: Text('عرض البيانات '),
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
