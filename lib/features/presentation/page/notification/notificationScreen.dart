import 'package:flutter/material.dart';

class notificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Notification',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
        ),
        body: ListView.builder(
          itemBuilder: (context, index) => SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => const AlertDialog(
                              content: Text(
                                'There is a new  donation you may need .',
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.purpleAccent,
                            ));
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 10, bottom: 8, left: 10),
                    child: Row(
                      children: [
                        Container(
                          height: 70.0,
                          width: 70.0,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            image: DecorationImage(
                              image: AssetImage('assets/Logo.png'),
                              fit: BoxFit.fill,
                            ),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text('Hayat-Eg'),
                                  Spacer(),
                                  Text(
                                    '11-7-2023',
                                    style: TextStyle(
                                        color: Colors.black45,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                      child: Text(
                                    'There is a new  donation you may need .',
                                    style: TextStyle(
                                        color: Colors.black45,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14),
                                  )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => const AlertDialog(
                              content: Text(
                                'Your donation is accepted,people can now request it',
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.amber,
                            ));
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 10, bottom: 8, left: 10),
                    child: Row(
                      children: [
                        Container(
                          height: 70.0,
                          width: 70.0,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            image: DecorationImage(
                              image: AssetImage('assets/Logo.png'),
                              fit: BoxFit.fill,
                            ),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text('Hayat-Eg'),
                                  Spacer(),
                                  Text(
                                    '11-7-2023',
                                    style: TextStyle(
                                        color: Colors.black45,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                      child: Text(
                                    'Your donation is accepted,people can now request it.',
                                    style: TextStyle(
                                        color: Colors.black45,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14),
                                  )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => const AlertDialog(
                              content: Text(
                                'Your request has been rejected.',
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.red,
                            ));
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 10, bottom: 8, left: 10),
                    child: Row(
                      children: [
                        Container(
                          height: 70.0,
                          width: 70.0,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            image: DecorationImage(
                              image: AssetImage('assets/Logo.png'),
                              fit: BoxFit.fill,
                            ),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text('Hayat-Eg'),
                                  Spacer(),
                                  Text(
                                    '11-7-2023',
                                    style: TextStyle(
                                        color: Colors.black45,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                      child: Text(
                                    'Your request has been rejected.',
                                    style: TextStyle(
                                        color: Colors.black45,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14),
                                  )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              content: const Text(
                                'We are reviewing your donation,please wait .',
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.blue.shade400,
                            ));
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 10, bottom: 8, left: 10),
                    child: Row(
                      children: [
                        Container(
                          height: 70.0,
                          width: 70.0,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            image: DecorationImage(
                              image: AssetImage('assets/Logo.png'),
                              fit: BoxFit.fill,
                            ),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text('Mohamed Ahmed'),
                                  Spacer(),
                                  Text(
                                    '11-7-2023',
                                    style: TextStyle(
                                        color: Colors.black45,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                      child: Text(
                                    'Your donation is accepted,people can now request it.',
                                    style: TextStyle(
                                        color: Colors.black45,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14),
                                  )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              content: const Text(
                                'A reputation has been add to your request .',
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.blue.shade400,
                            ));
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 10, bottom: 8, left: 10),
                    child: Row(
                      children: [
                        Container(
                          height: 70.0,
                          width: 70.0,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            image: DecorationImage(
                              image: AssetImage('assets/Logo.png'),
                              fit: BoxFit.fill,
                            ),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text('Mohamed Ahmed'),
                                  Spacer(),
                                  Text(
                                    '11-7-2023',
                                    style: TextStyle(
                                        color: Colors.black45,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                      child: Text(
                                    'We are reviewing your donation,please wait .',
                                    style: TextStyle(
                                        color: Colors.black45,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14),
                                  )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          itemCount: 12,
        ));
  }
}
