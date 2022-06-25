import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_affair_app/views/catagory_view.dart';

class CatagoryTile extends StatelessWidget {
  final imageUrl, catagoryName;
  const CatagoryTile(
      {Key? key, required this.imageUrl, required this.catagoryName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        print(catagoryName);
        final response = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CatagoryView(
                    category: catagoryName.toString().toLowerCase())));
      },
      child: Container(
        padding: EdgeInsets.only(right: 16),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.fill,
                width: 120,
                height: 60,
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: 120,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black26,
              ),
              child: Text(
                catagoryName,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
