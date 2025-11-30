import 'package:flutter/material.dart';

class FancyTextField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final bool isNumber;

  const FancyTextField({
    Key? key,
    required this.label,
    required this.controller,
    this.isNumber = false,
  }) : super(key: key);

  @override
  State<FancyTextField> createState() => _FancyTextFieldState();
}

class _FancyTextFieldState extends State<FancyTextField> {
  late FocusNode _focusNode;
  bool _isFocused = false;
  final purpleColor = const Color(0xFF571874);

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _isFocused =
            _focusNode.hasFocus || widget.controller.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _focusNode.requestFocus(),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          TextField(
            focusNode: _focusNode,
            controller: widget.controller,
            keyboardType:
                widget.isNumber
                    ? TextInputType.number
                    : TextInputType.text,
            style: TextStyle(color: purpleColor, fontSize: 16),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 16,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide(color: purpleColor, width: 2),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide(
                  color: purpleColor.withOpacity(0.7),
                  width: 1.8,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide(
                  color: purpleColor,
                  width: 2.5,
                ),
              ),
            ),
          ),

          Positioned(
            left: 20,
            top: _isFocused ? -10 : 16,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: _isFocused ? purpleColor : Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                widget.label,
                style: TextStyle(
                  color:
                      _isFocused
                          ? Colors.white
                          : purpleColor.withOpacity(0.9),
                  fontSize: _isFocused ? 13 : 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
