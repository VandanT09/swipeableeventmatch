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
      "description": "Coldplay is a British rock band...",
      "image": "images/convert.webp"
    },
    {
      "name": "Music Festival",
      "description": "A great music event featuring top artists!",
      "image":
          "images/hands-happy-people-crowd-having-fun-stage-summer-live-rock-festival_367038-255.webp"
    },
    // Add more events as needed
  ];

  void _showSwipeFeedback(String feedback) {
    setState(() {
      _swipeFeedback = feedback;
    });

    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _swipeFeedback = null;
      });
      _controller.next(); // Move to the next card after feedback disappears
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Swiper(
            controller: _controller,
            itemBuilder: (BuildContext context, int index) {
              final event = events[index];
              return GestureDetector(
                onHorizontalDragEnd: (details) {
                  if (details.velocity.pixelsPerSecond.dx > 0) {
                    _showSwipeFeedback('👍 Like');
                  } else if (details.velocity.pixelsPerSecond.dx < 0) {
                    _showSwipeFeedback('👎 Dislike');
                  }
                },
                onVerticalDragEnd: (details) {
                  if (details.velocity.pixelsPerSecond.dy < 0) {
                    _showSwipeFeedback('💙 Superlike');
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
          ),
          if (_swipeFeedback != null)
            Center(
              child: Text(
                _swipeFeedback!,
                style: const TextStyle(
                  fontSize: 60,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
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
