import 'package:flutter/material.dart';
import 'package:fluttermoji/fluttermojiCircleAvatar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:news_api_flutter_package/news_api_flutter_package.dart';
import 'package:news_api_flutter_package/model/article.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:go_router/go_router.dart';
import '../widget/wellness_carousel.dart';


class Dashboard extends StatefulWidget {
  const Dashboard({super.key});
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  
  final NewsAPI _newsAPI = NewsAPI(apiKey: "a1747ed859ee43cabfbece39d2d64f56");
  String userName = "";


  final supabase = Supabase.instance.client;

  @override
  void initState() {
    super.initState();
    getUserName();
  }

  Future<void> _launchURL(String urlString) async {
    final Uri uri = Uri.parse(urlString.trim());
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } 
  }

  Future<void> getUserName() async {
    final user = supabase.auth.currentUser;
    if (user != null) {
      final response = await supabase
          .from('User')
          .select('name')
          .eq('email', user.email!)
          .single();
      setState(() {
        userName = response['name'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30.0, left: 15.0),
                  child: GestureDetector(
                    onTap: () async{
                      await supabase.auth.signOut();
                      if(context.mounted)context.go('/');
                    },
                    child: const Icon(Icons.logout_rounded),
                  )
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 285,
                      top: 50), // Match this value to align with the Text
                  child: GestureDetector(
                    onTap: () {
                      context.push('/custom-avatar');
                    },
                    child: FluttermojiCircleAvatar(
                      backgroundColor: const Color(0xFF20795E), // Optional background color
                      radius: 50, // Optional radius
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 90.0, left: 15.0),
                  child: Text(
                    'Welcome back, $userName\nHow are you feeling today?',
                    style:
                        const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(top: 30.0, bottom: 30.0),
              child: Center(
                child: WellnessCarousel()
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Article>>(
                future: _newsAPI.getEverything(query: "practicing mental wellness"),
                builder: (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: const Color(0xFFFFFFFF)
                        ),
                        child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final article = snapshot.data![index];
                            return ListTile(
                              title: Text(
                              article.title!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Text(
                              article.description ?? article.content ?? "",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: article.urlToImage == null
                                ? null
                                : SizedBox(
                                    width: 80,
                                    child: Image.network(article.urlToImage!),
                                  ),
                              onTap: () async{
                                if (article.url != null) {
                                  await _launchURL(article.url!);
                                } 
                              } 
                            );
                          },
                        )
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                  }
                  return const Center(child: Text('Unexpected error occurred.'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
