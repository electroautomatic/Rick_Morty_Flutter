import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rick_morty/data/models/chracter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'character_status.dart';

class CustomListTile extends StatelessWidget {
  final Results result;
  const CustomListTile({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        height: MediaQuery.of(context).size.height / 7,
        color: const Color.fromRGBO(86, 86, 86, 0.8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: result.image,
              placeholder: (context, url) => CircularProgressIndicator(
                color: Colors.grey,
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    child: Text(
                      result.name,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ChatacterStatus(
                    liveState: result.status == 'Alive'
                        ? LiveState.alive
                        : result.status == 'Dead'
                            ? LiveState.dead
                            : LiveState.unknown,
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Species',
                              style: Theme.of(context).textTheme.caption,
                            ),
                            SizedBox(height: 2),
                            Text(
                              result.species,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Gender',
                              style: Theme.of(context).textTheme.caption,
                            ),
                            SizedBox(height: 2),
                            Text(
                              result.gender,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
