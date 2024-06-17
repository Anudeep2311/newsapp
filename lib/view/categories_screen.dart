import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news/models/categories_news_model.dart';
import 'package:news/view_model/news_view_model.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  NewsViewModel newsViewModel = NewsViewModel();

  final format = DateFormat('MMMM dd, yyyy');

  String categoryName = 'General';

  List<String> categoriesList = [
    'General',
    'Entertainmaint',
    'Health',
    'Sports',
    'Business',
    'Technology'
  ];
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categoriesList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        categoryName = categoriesList[index];
                        setState(() {});
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Container(
                          decoration: BoxDecoration(
                            color: categoryName == categoriesList[index]
                                ? Colors.blue
                                : Colors.blueGrey,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Center(
                              child: Text(
                                categoriesList[index].toString(),
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            const SizedBox(
              height: 20,
            ),
            FutureBuilder<CategoriesNewsModel>(
              future: newsViewModel.fetchCategoriesNewsApi(categoryName),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: SpinKitDancingSquare(
                      color: Colors.blue,
                      size: 40,
                    ),
                  );
                } else {
                  return Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data!.articles!.length,
                        itemBuilder: (context, index) {
                          DateTime dateTime = DateTime.parse(snapshot
                              .data!.articles![index].publishedAt
                              .toString());
                          return Padding(
                            padding: const EdgeInsets.only(
                              bottom: 15,
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: CachedNetworkImage(
                                    imageUrl: snapshot
                                        .data!.articles![index].urlToImage
                                        .toString(),
                                    fit: BoxFit.cover,
                                    height: height * 0.18,
                                    width: width * 0.3,
                                    placeholder: (context, url) =>
                                        const SizedBox(
                                      child: Center(
                                        child: SpinKitDancingSquare(
                                          color: Colors.blue,
                                          size: 40,
                                        ),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(
                                      Icons.error_outline,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: height * .18,
                                    padding: const EdgeInsets.only(left: 15),
                                    child: Column(
                                      children: [
                                        Text(
                                          snapshot
                                              .data!.articles![index].urlToImage
                                              .toString(),
                                          style: GoogleFonts.poppins(
                                            fontSize: 15,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w700,
                                          ),
                                          maxLines: 3,
                                        ),
                                        const Spacer(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              snapshot.data!.articles![index]
                                                  .source!.name
                                                  .toString(),
                                              style: GoogleFonts.poppins(
                                                fontSize: 13,
                                                color: Colors.black54,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              format.format(dateTime),
                                              style: GoogleFonts.poppins(
                                                fontSize: 13,
                                                color: Colors.black54,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                          // return SizedBox(
                          //   child: Stack(
                          //     alignment: Alignment.center,
                          //     children: [
                          //       Container(
                          //         height: height * 0.6,
                          //         width: width * 0.9,
                          //         padding: EdgeInsets.symmetric(
                          //           horizontal: height * .02,
                          //         ),
                          //         child: ClipRRect(
                          //           borderRadius: BorderRadius.circular(16),
                          //           child: CachedNetworkImage(
                          //             imageUrl: snapshot
                          //                 .data!.articles![index].urlToImage
                          //                 .toString(),
                          //             fit: BoxFit.cover,
                          //             placeholder: (context, url) => Container(
                          //               child: spinKit2,
                          //             ),
                          //             errorWidget: (context, url, error) =>
                          //                 const Icon(
                          //               Icons.error_outline,
                          //               color: Colors.red,
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //       Positioned(
                          //         bottom: 20,
                          //         child: Card(
                          //           elevation: 5,
                          //           shape: RoundedRectangleBorder(
                          //             borderRadius: BorderRadius.circular(14),
                          //           ),
                          //           child: Container(
                          //             padding: const EdgeInsets.all(15),
                          //             height: height * 0.22,
                          //             alignment: Alignment.bottomCenter,
                          //             child: Column(
                          //               mainAxisAlignment:
                          //                   MainAxisAlignment.center,
                          //               crossAxisAlignment:
                          //                   CrossAxisAlignment.center,
                          //               children: [
                          //                 SizedBox(
                          //                   width: width * 0.7,
                          //                   child: Text(
                          //                     snapshot
                          //                         .data!.articles![index].title
                          //                         .toString(),
                          //                     maxLines: 2,
                          //                     overflow: TextOverflow.ellipsis,
                          //                     style: GoogleFonts.poppins(
                          //                       fontSize: 18,
                          //                       fontWeight: FontWeight.w700,
                          //                     ),
                          //                   ),
                          //                 ),
                          //                 const Spacer(),
                          //                 SizedBox(
                          //                   width: width * 0.7,
                          //                   child: Row(
                          //                     mainAxisAlignment:
                          //                         MainAxisAlignment.spaceBetween,
                          //                     children: [
                          //                       Text(
                          //                         snapshot.data!.articles![index]
                          //                             .source!.name
                          //                             .toString(),
                          //                         maxLines: 2,
                          //                         overflow: TextOverflow.ellipsis,
                          //                         style: GoogleFonts.poppins(
                          //                           fontSize: 14,
                          //                           color: Colors.blue,
                          //                         ),
                          //                       ),
                          //                       Text(
                          //                         format.format(dateTime),
                          //                         maxLines: 2,
                          //                         overflow: TextOverflow.ellipsis,
                          //                         style: GoogleFonts.poppins(
                          //                           fontSize: 14,
                          //                           color: Colors.blue,
                          //                         ),
                          //                       )
                          //                     ],
                          //                   ),
                          //                 )
                          //               ],
                          //             ),
                          //           ),
                          //         ),
                          //       )
                          //     ],
                          //   ),
                          // );
                        }),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
