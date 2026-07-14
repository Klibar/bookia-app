import 'package:bookia/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

/// TODO: replace this static list with the real governorates once the
/// backend exposes them (e.g. GET /governorates).
const List<String> kGovernorates = [
  'Cairo',
  'Giza',
  'Alexandria',
  'Qalyubia',
];

Future<String?> showGovernorateSelector(BuildContext context) {
  return showModalBottomSheet<String>(
    context: context,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select Governorate',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 12),
              ...kGovernorates.map(
                (g) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(g, style: const TextStyle(fontSize: 15)),
                  onTap: () => Navigator.pop(context, g),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
