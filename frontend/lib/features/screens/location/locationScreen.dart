import 'package:flutter/material.dart';
import 'package:frontend/features/screens/home/homeGenerator.dart';
import 'package:frontend/features/screens/messages/messageScreen.dart';
import 'package:frontend/features/screens/notifications/notificationScreen.dart';
import 'package:frontend/features/screens/profile/profileScreen.dart';

class LocationPage extends StatefulWidget {
  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = GenerateHomePage();
        break;
      case 1:
        // page = GenerateLocationPage();
        page = LocationPage();
        break;
      case 2:
        // page = GenerateMessagePage();
        page = MessagesPage();
        break;
      case 3:
        // page = GenerateNotificationPage();
        page = NotificationPage();
        break;
      case 4:
        // page = GenerateProfilePage();
        page = ProfilePage();
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: Row(
          children: [
            SafeArea(
              child: NavigationRail(
                extended: constraints.maxWidth >= 600,
                destinations: [
                  NavigationRailDestination(
                    icon: Icon(Icons.home),
                    label: Text('Home'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.add_location_sharp),
                    label: Text('Location'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.message_rounded),
                    label: Text('Messages'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.add_alert),
                    label: Text('Notifications'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.account_box_rounded),
                    label: Text('Profile'),
                  ),
                ],
                selectedIndex: selectedIndex,
                onDestinationSelected: (value) {
                  setState(() {
                    selectedIndex = value;
                  });
                },
              ),
            ),
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: page,
              ),
            ),
          ],
        ),
      );
    });
  }
}
