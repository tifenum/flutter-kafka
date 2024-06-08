import 'package:flutter/material.dart';

showErrorSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          const Icon(
            Icons.error_outline_outlined,
            color: Colors.red,
            size: 30,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(fontSize: 18.0),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.black.withOpacity(0.8),
      dismissDirection: DismissDirection.horizontal,
      behavior: SnackBarBehavior.floating,
    ),
  );
}

showSuccessSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          const Icon(
            Icons.check_circle_outline,
            color: Colors.green,
            size: 30,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(fontSize: 18.0),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.black.withOpacity(0.8),
      dismissDirection: DismissDirection.horizontal,
      behavior: SnackBarBehavior.floating,
    ),
  );
}

showInfoSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          const Icon(
            Icons.info_outline,
            color: Colors.yellow,
            size: 30,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(fontSize: 18.0),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.black.withOpacity(0.8),
      dismissDirection: DismissDirection.horizontal,
      behavior: SnackBarBehavior.floating,
    ),
  );
}
