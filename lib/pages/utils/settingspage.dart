import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

// BounceButton widget
class BounceButton extends StatefulWidget {

  final Widget child;
  final VoidCallback onTap;

  const BounceButton({super.key , required this.child , required this.onTap});

  @override
  State<BounceButton> createState() => _BounceButtonState();
}

class _BounceButtonState extends State<BounceButton> {

  double scale = 1.0;

  void _ontapdown(_){
    HapticFeedback.lightImpact();
    setState(() {
      scale = 0.95;
    });
  }
  void _ontapup(_) => setState(() => scale = 1.0);
  void _ontapcancel() => setState(() => scale = 1.0);


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: _ontapdown,
      onTapUp: _ontapup,
      onTapCancel: _ontapcancel,
      child: AnimatedScale(
        scale: scale,
        duration: Duration(milliseconds: 100),
        child: widget.child,
      ),
    );
  }
}

class Settingspage extends StatefulWidget {
  const Settingspage({super.key});

  @override
  State<Settingspage> createState() => _SettingspageState();
}

class _SettingspageState extends State<Settingspage> {

  void _launchGitHub() async {
  final Uri url = Uri.parse('https://github.com/GGRISHAV/flutter-calculator');

  if (!await launchUrl(
    url,
    mode: LaunchMode.externalApplication, // this is important!
  )) {
    throw 'Could not launch $url';
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Settings",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
    
      body: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: 2,
        itemBuilder: (context, index) {
          final items = [
            {'icon': Icons.color_lens, 'text': 'Theme'},
            {'icon': Icons.code, 'text': 'About Developer'},
          ];
      
          return BounceButton(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.grey.shade800,
                  borderRadius: BorderRadius.circular(25)
                ),
              
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Icon(items[index]['icon'] as IconData , color: Colors.white,),
                    ),
              
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        items[index]['text'] as String,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            onTap: (){
              if (index == 0){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Theme toggle coming soon!')),
                );
              }else if(index == 1){
                _launchGitHub();
              }
            },
          );
        }
      )
    );
  }
}