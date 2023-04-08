import 'package:flutter/material.dart';

class Profile extends StatefulWidget{
  const Profile({super.key});

  @override
  State<Profile> createState() => _Profile();
}

class _Profile extends State<Profile>{

  final mainImage = Image.asset(
    'images/pavlova.jpeg',
  );

  @override
  Widget build(BuildContext context){
    return ListView(
      children: [
        Expanded(child: mainImage),
        _tileWithTrailing(Icons.arrow_right_sharp, "Nguyen Cao Duc", "Student"),
        _tileWithoutTrailing(Icons.email, "nguyencaoduc0922@gmail.com"),
        _tileWithoutTrailing(Icons.phone, "0123456789"),
        _tileNote(Icons.note, "Sinh viên năm 4 tại Đại học Cần Thơ với kinh nghiệm 2 năm làm việc tại FPT DPS Cần Thơ, 2 tháng thử việc tại TMA Solutions."),
      ],
    );
  }

  ListTile _tileWithTrailing(IconData icon, String text, String trailing){
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.grey[500],
      ),
      title: Text(
        text,
        style: const TextStyle(
          color: Colors.blueAccent,
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
      ),
      trailing: Text(
          trailing,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            color: Colors.blueAccent,
            fontSize: 15,
          ),
      ),
    );
  }

  ListTile _tileWithoutTrailing(IconData icon, String text){
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.grey[500],
      ),
      title: Text(
        text,
        style: const TextStyle(
          color: Colors.blueAccent,
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
      ),
    );
  }

  ListTile _tileNote(IconData icon, String text){
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.grey[500],
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ),
          const Text(
            "Câu nói ưa thích",
            style: TextStyle(
              color: Colors.blueAccent,
              fontWeight: FontWeight.w400,
              fontSize: 18,
            ),
          ),
        ],

      )
    );
  }
}