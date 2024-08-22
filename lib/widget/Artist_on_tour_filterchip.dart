import 'package:flutter/material.dart';

class ArtistOnTourFilterchip extends StatefulWidget {
  final ValueChanged<String> onChipSelected;

  ArtistOnTourFilterchip({required this.onChipSelected});

  @override
  _ArtistOnTourFilterchipState createState() => _ArtistOnTourFilterchipState();
}

class _ArtistOnTourFilterchipState extends State<ArtistOnTourFilterchip> {
  String _selectedChip = 'Near you';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          FilterChipWidget(
            label: 'Near you',
            selected: _selectedChip == 'Near you',
            onTap: () {
              setState(() {
                _selectedChip = 'Near you';
              });
              widget.onChipSelected('Near you');
            },
          ),
          FilterChipWidget(
            label: 'Popular',
            selected: _selectedChip == 'Popular',
            onTap: () {
              setState(() {
                _selectedChip = 'Popular';
              });
              widget.onChipSelected('Popular');
            },
          ),
          FilterChipWidget(
            label: 'Music',
            selected: _selectedChip == 'Music',
            onTap: () {
              setState(() {
                _selectedChip = 'Music';
              });
              widget.onChipSelected('Music');
            },
          ),
          FilterChipWidget(
            label: 'Comedy',
            selected: _selectedChip == 'Comedy',
            onTap: () {
              setState(() {
                _selectedChip = 'Comedy';
              });
              widget.onChipSelected('Comedy');
            },
          ),
        ],
      ),
    );
  }
}

class FilterChipWidget extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  FilterChipWidget({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          decoration: BoxDecoration(
            color: selected
                ? const Color.fromARGB(255, 217, 233, 246)
                : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: selected
                ? Border.all(color: Colors.blue)
                : Border.all(color: Colors.grey),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: selected ? Colors.blue : Colors.grey,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
