import 'package:flutter/material.dart';

class PickImageDialog extends StatelessWidget {
  const PickImageDialog({super.key,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
        height: MediaQuery.of(context).size.height/4,
        width: MediaQuery.of(context).size.width/1.5,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.black,border: Border.all(color: Colors.white,width: 2)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [ 
            Text('Choose the source', style: Theme.of(context).textTheme.bodyMedium,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [ 
              GestureDetector(
                onTap: (){
                  Navigator.pop(context,'Camera');
                },
                child: Column(
                  children: [ 
                    const Icon(Icons.camera, color: Colors.white,),
                    Text('Camera', style: Theme.of(context).textTheme.bodyMedium,)
                  ],
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.pop(context,'Gallery');
                },
                child: Column(
                  children: [ 
                    const Icon(Icons.image, color: Colors.white,),
                    Text('Gallery', style: Theme.of(context).textTheme.bodyMedium,)
                  ],
                ),
              ),
            ],)
          ],
        ),
            ),
      ),
    );
  }
}