import 'package:flutter/material.dart';
import 'package:watch_it/models/vedio_items_model.dart';
import 'package:watch_it/widgets/vedio_list_title.dart';

class SearchSheet extends StatefulWidget {
  const SearchSheet({super.key});

  @override
  State<SearchSheet> createState() => _SearchSheetState();
}

class _SearchSheetState extends State<SearchSheet> {
  final _controller = TextEditingController();
  List<VideoItem> _results = [];

  void _search(String query) {
    setState(() {
      _results = kVideos
          .where((v) =>
              v.title.toLowerCase().contains(query.toLowerCase()) ||
              v.channel.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
        color: Color(0xFF141420),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Handle
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 36,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),
          // Search Field
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _controller,
              autofocus: true,
              onChanged: _search,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'ابحث عن فيديو...',
                hintStyle: const TextStyle(color: Colors.white38),
                prefixIcon:
                    const Icon(Icons.search_rounded, color: Colors.white38),
                filled: true,
                fillColor: const Color(0xFF1E1E2E),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Results
          Expanded(
            child: _results.isEmpty && _controller.text.isEmpty
                ? const Center(
                    child: Text(
                      'ابحث عن أي فيديو',
                      style: TextStyle(color: Colors.white38),
                    ),
                  )
                : _results.isEmpty
                    ? const Center(
                        child: Text(
                          'لا توجد نتائج',
                          style: TextStyle(color: Colors.white38),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _results.length,
                        itemBuilder: (context, i) => VideoListTile(
                          video: _results[i],
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}
