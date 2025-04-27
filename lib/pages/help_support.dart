import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class HelpSupportApp extends StatelessWidget {
  const HelpSupportApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Help & Support',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HelpSupportPage(),
    );
  }
}

class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Using SingleChildScrollView to allow scrolling on smaller screens.
    return Scaffold(
      appBar: AppBar(
        title: Text('Help & Support'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar Section
            TextField(
              decoration: InputDecoration(
                hintText: 'Search for answers...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 20),

            // FAQ Section
            Text('Frequently Asked Questions',
                style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: 10),
            FAQSection(),
            SizedBox(height: 20),

            // Support Articles Section
            Text('Support Articles & Guides',
                style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: 10),
            SupportArticlesSection(),
            SizedBox(height: 20),

            // Contact Form Section
            Text('Contact Support',
                style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: 10),
            ContactFormSection(),
            SizedBox(height: 20),

            // Live Chat Section
            Text('Live Chat', style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Implement your live chat functionality here
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: Text('Start Chat'),
              ),
            ),
            SizedBox(height: 20),

            // Footer
            Center(
              child: Text(
                '© 2025 Your Company. All rights reserved.',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// FAQ Section using ExpansionTile widgets for collapsible FAQ items.
class FAQSection extends StatelessWidget {
  final List<FAQItem> faqItems = [
    FAQItem(
      question: 'How do I reset my password?',
      answer:
          'To reset your password, click on "Forgot Password" at the login screen and follow the instructions.',
    ),
    FAQItem(
      question: 'How can I update my profile information?',
      answer:
          'You can update your profile by navigating to your account settings and clicking "Edit Profile".',
    ),
    // Add more FAQ items as needed.
  ];

  FAQSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: faqItems
          .map(
            (item) => ExpansionTile(
              title: Text(item.question),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Text(item.answer),
                ),
              ],
            ),
          )
          .toList(),
    );
  }
}

class FAQItem {
  final String question;
  final String answer;

  FAQItem({required this.question, required this.answer});
}

// Support Articles Section using a horizontal ListView to display articles.
class SupportArticlesSection extends StatelessWidget {
  final List<Article> articles = [
    Article(
      title: 'Getting Started',
      description:
          'Learn the basics of using our platform with this introductory guide.',
    ),
    Article(
      title: 'Account Management',
      description:
          'Step-by-step instructions for managing your account and settings.',
    ),
    // Add more articles as needed.
  ];

  SupportArticlesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      // Horizontal scrolling list for articles.
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: articles.length,
        itemBuilder: (context, index) {
          final article = articles[index];
          return Container(
            width: 200,
            margin: EdgeInsets.only(right: 16),
            child: Card(
              elevation: 2,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(article.title,
                        style: Theme.of(context).textTheme.subtitle1),
                    SizedBox(height: 10),
                    Text(article.description,
                        style: Theme.of(context).textTheme.bodyMedium),
                    Spacer(),
                    TextButton(
                      onPressed: () {
                        // Navigate to detailed article page
                      },
                      child: Text('Read More'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

extension on TextTheme {
  get subtitle1 => null;
}

class Article {
  final String title;
  final String description;

  Article({required this.title, required this.description});
}

// Contact Form Section using a stateful widget with a form.
class ContactFormSection extends StatefulWidget {
  const ContactFormSection({super.key});

  @override
  _ContactFormSectionState createState() => _ContactFormSectionState();
}

class _ContactFormSectionState extends State<ContactFormSection> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String email = '';
  String message = '';

  bool isLoading = false; // NEW: For showing loading indicator

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;  // Firestore instance

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Name field
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(),
            ),
            onSaved: (value) {
              name = value ?? '';
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          SizedBox(height: 10),

          // Email field
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
            onSaved: (value) {
              email = value ?? '';
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                return 'Please enter a valid email address';
              }
              return null;
            },
          ),
          SizedBox(height: 10),

          // Message field
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Message',
              border: OutlineInputBorder(),
            ),
            onSaved: (value) {
              message = value ?? '';
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a message';
              }
              return null;
            },
            maxLines: 5,
          ),
          SizedBox(height: 10),

          // Send Message button
          isLoading
              ? CircularProgressIndicator()  // NEW: Show loading while sending
              : ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      setState(() {
                        isLoading = true;
                      });

                      try {
                        // Send message data to Firestore
                        await createMessage({
                          'name': name,
                          'email': email,
                          'message': message,
                          'timestamp': DateTime.now(),
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Message sent successfully!')),
                        );

                        _formKey.currentState!.reset();
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Failed to send message: $e')),
                        );
                      } finally {
                        setState(() {
                          isLoading = false;
                        });
                      }
                    }
                  },
                  child: Text('Send Message'),
                )
        ],
      ),
    );
  }

  // Function to send the message data to Firestore
  Future<void> createMessage(Map<String, dynamic> messageData) async {
    try {
      await _firestore.collection('messages').add(messageData);  // Firestore interaction
    } catch (e) {
      throw Exception('Error creating message: $e');
    }
  }
}
