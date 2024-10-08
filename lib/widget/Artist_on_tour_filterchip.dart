import 'package:flutter/material.dart';

class ArtistOnTourFilterchip extends StatefulWidget {
  final String selectedChip;
  final int currentPageIndex;
  final ValueChanged<String> onChipSelected;

  ArtistOnTourFilterchip({
    required this.selectedChip,
    required this.currentPageIndex,
    required this.onChipSelected,
  });

  @override
  _ArtistOnTourFilterchipState createState() => _ArtistOnTourFilterchipState();
}

class _ArtistOnTourFilterchipState extends State<ArtistOnTourFilterchip> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildFilterChip('Near you', 0),
          _buildFilterChip('Popular', 1),
          _buildFilterChip('Music', 2),
          _buildFilterChip('Comedy', 3),
          _buildFilterChip('Video', 4),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, int index) {
    bool isSelected = widget.selectedChip == label;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: GestureDetector(
        onTap: () => widget.onChipSelected(label),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color.fromARGB(255, 217, 233, 246)
                : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: isSelected
                ? Border.all(color: Colors.blue)
                : Border.all(color: Colors.grey),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.blue : Colors.grey,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
