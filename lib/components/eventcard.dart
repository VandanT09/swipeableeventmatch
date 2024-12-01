import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';

class SwipeableEvents extends StatefulWidget {
  const SwipeableEvents({Key? key}) : super(key: key);

  @override
  _SwipeableEventsState createState() => _SwipeableEventsState();
}

class _SwipeableEventsState extends State<SwipeableEvents> {
  final SwiperController _controller = SwiperController();
  String? _swipeFeedback;

  final List<Map<String, String>> events = [
    {
      "name": "ColdPlay",
      "description":
          "Coldplay is a British rock band formed in London in 1997. The band consists of vocalist and pianist Chris Martin, guitarist Jonny Buckland, bassist Guy Berryman, drummer Will Champion, and manager Phil Harvey.",
      "image": "images/convert.webp"
    },
    {
      "name": "Music Fest",
      "description": "A great music event featuring top artists!",
      "image":
          "images/hands-happy-people-crowd-having-fun-stage-summer-live-rock-festival_367038-255.webp"
    },
    {
      "name": "ChainSmokers",
      "description":
          "The Chainsmokers are an American electronic DJ and production duo consisting of Alex Pall and Drew Taggart.",
      "image": "images/friends-dance-at-formal-party.webp"
    },
    {
      "name": "SunBurn",
      "description":
          "Sunburn Festival is a commercial electronic dance music festival held in India. It was started by entrepreneur Shailendra Singh[1][2][3] of Percept Ltd.",
      "image":
          "images/rear-view-fans-watching-live-music-concert-night_1131848-5.webp"
    },
    {
      "name": "Food Carnival",
      "description":
          "A food carnival event is a celebration that showcases a variety of foods from around the world, often featuring creative and mouth-watering dishes created by experienced chefs.",
      "image": "images/concert-crowd.webp"
    },
    {
      "name": "YouTube FanFest",
      "description":
          "YouTube FanFest is a unique event that brings together fans of various franchises, including video games, sports, and entertainment.",
      "image": "images/defocused-image-crowd-music-concert_1048944-362744.webp"
    },
    // Add more events as needed
  ];

  void _showSwipeFeedback(String feedback) {
    setState(() {
      _swipeFeedback = feedback;
    });

    // Keep the text visible for 5 seconds
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        _swipeFeedback = null;
      });
    });
  }

  void _moveToNextCard() {
    if (_controller.index < events.length - 1) {
      _controller.next();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Swiper(
                  controller: _controller,
                  itemBuilder: (BuildContext context, int index) {
                    final event = events[index];
                    return GestureDetector(
                      onHorizontalDragEnd: (details) {
                        if (details.velocity.pixelsPerSecond.dx > 0) {
                          // Swipe Right (Like)
                          _showSwipeFeedback('💚 Like');
                          _moveToNextCard(); // Move to next card programmatically
                        } else if (details.velocity.pixelsPerSecond.dx < 0) {
                          // Swipe Left (Dislike)
                          _showSwipeFeedback('❌ Dislike');
                          _moveToNextCard(); // Move to next card programmatically
                        }
                      },
                      onVerticalDragEnd: (details) {
                        if (details.velocity.pixelsPerSecond.dy < 0) {
                          // Swipe Up (Superlike)
                          _showSwipeFeedback('⭐ Superlike');
                          _moveToNextCard(); // Move to next card programmatically
                        }
                      },
                      child: EventCard(
                        eventName: event['name']!,
                        description: event['description']!,
                        image: event['image']!,
                      ),
                    );
                  },
                  itemCount: events.length,
                  layout: SwiperLayout.STACK,
                  itemWidth: MediaQuery.of(context).size.width * 0.9,
                  itemHeight: MediaQuery.of(context).size.height * 0.7,
                  viewportFraction: 0.8,
                  scale: 0.9,
                  physics:
                      const BouncingScrollPhysics(), // Smooth swipe physics
                  onIndexChanged: (index) {
                    // Clear swipe feedback when card changes
                    setState(() {
                      _swipeFeedback = null;
                    });
                  },
                ),
              ),
              // Tinder-like icons below the card
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Dislike Button (Pink Cross)
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.pink.shade100,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Text(
                          '❌',
                          style: TextStyle(fontSize: 40, color: Colors.pink),
                        ),
                        onPressed: () {
                          _showSwipeFeedback('❌ Dislike');
                          _moveToNextCard(); // Move to next card programmatically
                        },
                      ),
                    ),
                    const SizedBox(width: 30), // Added spacing
                    // Superlike Button (Blue Star)
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Text(
                          '⭐',
                          style: TextStyle(fontSize: 40, color: Colors.blue),
                        ),
                        onPressed: () {
                          _showSwipeFeedback('⭐ Superlike');
                          _moveToNextCard(); // Move to next card programmatically
                        },
                      ),
                    ),
                    const SizedBox(width: 30), // Added spacing
                    // Like Button (Green Heart)
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.green.shade100,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Text(
                          '💚',
                          style: TextStyle(fontSize: 40, color: Colors.green),
                        ),
                        onPressed: () {
                          _showSwipeFeedback('💚 Like');
                          _moveToNextCard(); // Move to next card programmatically
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (_swipeFeedback != null)
            Center(
              child: AnimatedOpacity(
                opacity: 1.0,
                duration: const Duration(milliseconds: 300),
                child: TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 500),
                  builder: (context, value, child) {
                    return Transform.scale(
                      scale: value *
                          1.1, // Increased the scale for a larger effect
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          _swipeFeedback!,
                          style: TextStyle(
                            fontSize: 70, // Increased font size for larger text
                            fontWeight: FontWeight.bold,
                            color: _swipeFeedback == '💚 Like'
                                ? Colors.green
                                : _swipeFeedback == '❌ Dislike'
                                    ? Colors.pink
                                    : Colors.blue,
                            shadows: [
                              Shadow(
                                blurRadius:
                                    15.0, // Increased shadow blur for better effect
                                color: Colors.black.withOpacity(0.6),
                                offset: const Offset(5.0, 5.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final String eventName;
  final String description;
  final String image;

  const EventCard({
    Key? key,
    required this.eventName,
    required this.description,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            child: Image.asset(
              image,
              height: MediaQuery.of(context).size.height * 0.4,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  eventName,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: const TextStyle(fontSize: 14),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
