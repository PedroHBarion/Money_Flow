import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFFFFFFF),
      margin: EdgeInsetsDirectional.fromSTEB(0, 32, 0, 16),
      padding: EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: SvgPicture.asset('assets/icons/icon_app_green.svg'),
              ),
              SizedBox(width: 8),
              Text(
                'MoneyFlow',
                style: TextStyle(
                  color: Color(0xFF087F5B),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          Row(
            children: const [
              IconButton(
                icon: Icon(Icons.notifications_outlined,
                    color: Color(0xFF087F5B)),
                onPressed: null, // Adicione a função desejada aqui
              ),
              SizedBox(width: 8),
              CircleAvatar(
                backgroundColor: Color(0xFF087F5B),
                child: Text(
                  'AT',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
