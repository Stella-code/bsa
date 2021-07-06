import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final String avatarUrl;
  final Function onTap;

  const Avatar({this.avatarUrl, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Stack(
          children: [
            Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                border: Border.all(
                    width: 4, color: Theme.of(context).scaffoldBackgroundColor),
                boxShadow: [
                  BoxShadow(
                      spreadRadius: 2,
                      blurRadius: 10,
                      color: Colors.black.withOpacity(0.1),
                      offset: Offset(0, 10))
                ],
                shape: BoxShape.circle,
                // image: DecorationImage(
                //   fit: BoxFit.cover,
                //   image: NetworkImage(
                //     "https://images.pexels.com/photos/3307758/pexels-photo-3307758.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=250",
                //   ),
                // ),
              ),
            ),
            Positioned(
              bottom: 4,
              right: 5,
              child: avatarUrl == null
                  ? CircleAvatar(
                      radius: 60.0,
                      child: Icon(Icons.photo_camera),
                    )
                  : CircleAvatar(
                      radius: 60.0,
                      backgroundImage: NetworkImage(avatarUrl),
                    ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      width: 4,
                      color: Theme.of(context).scaffoldBackgroundColor),
                  color: Colors.green,
                ),
                child: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
