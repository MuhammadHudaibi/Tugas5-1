import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class KategoriDetail extends StatelessWidget {
  final String kategori;
  KategoriDetail({required this.kategori});

  Future<List<dynamic>> getMealsByCategory(String category) async {
    var url = 'https://www.themealdb.com/api/json/v1/1/filter.php?c=$category';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      return jsonData['meals'];
    } else {
      throw Exception('Failed to load meals');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$kategori Recipe'),
        titleTextStyle: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black),
      ),
      body: FutureBuilder(
        future: getMealsByCategory(kategori),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.data == null) {
            return Center(child: Text('Data is null'));
          } else {
            List<dynamic> meals = snapshot.data as List<dynamic>;
            return ListView.builder(
              itemCount: meals.length,
              itemBuilder: (context, index) {
                var meal = meals[index];
                return Container(
                  height: 200, // Set the height of the container
                  margin: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: NetworkImage(meal['strMealThumb'] ?? ''),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.5),
                        BlendMode.darken,
                      ),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 8,
                        bottom: 8,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.bottomLeft,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width - 30,
                            child: Text(
                              meal['strMeal'] ?? '',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}