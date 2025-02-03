import 'package:flutter/material.dart';

enum TypeSearchBar { basic, withDropdownFilter }

class SearchBarPermit extends StatefulWidget {
  final String hintText;
  final TypeSearchBar searchType;
  final List<String>? items;
  final void Function(String query, String param)? onSearch;

  const SearchBarPermit({
    super.key,
    required this.hintText,
    this.searchType = TypeSearchBar.basic,
    this.items,
    this.onSearch,
  });

  @override
  State<SearchBarPermit> createState() => _SearchBarPermitState();
}

class _SearchBarPermitState extends State<SearchBarPermit> {
  final TextEditingController _controller = TextEditingController();
  String _selectedFilter = '';

  @override
  void initState() {
    super.initState();
    if (widget.searchType == TypeSearchBar.withDropdownFilter &&
        widget.items != null &&
        widget.items!.isNotEmpty) {
      _selectedFilter = widget.items!.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // If using dropdown filter, show a DropdownButton
        if (widget.searchType == TypeSearchBar.withDropdownFilter &&
            widget.items != null)
          DropdownButton<String>(
            value: _selectedFilter,
            items: widget.items!
                .map((item) => DropdownMenuItem(
              value: item,
              child: Text(item),
            ))
                .toList(),
            onChanged: (value) {
              setState(() {
                _selectedFilter = value ?? '';
              });
            },
          ),
        Expanded(
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: widget.hintText,
              suffixIcon: IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  if (_controller.text.isNotEmpty && widget.onSearch != null) {
                    // When using a dropdown filter, we send the filter as search param.
                    widget.onSearch!(_controller.text, _selectedFilter);
                  }
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
