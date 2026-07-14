import 'package:bookia/core/theme/app_colors.dart';
import 'package:bookia/features/auth/domain/entities/user_entity.dart';
import 'package:bookia/features/orders/presentation/pages/order_history_page.dart';
import 'package:bookia/features/profile/presentation/pages/edit_profile_page.dart';
import 'package:bookia/features/profile/presentation/pages/update_password_page.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final UserEntity user;

  const ProfilePage({super.key, required this.user});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late UserEntity _user = widget.user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              const Center(
                child: Text(
                  'Profile',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 36,
                      backgroundColor: Colors.white,
                      backgroundImage:
                          _user.image != null && _user.image!.isNotEmpty
                              ? NetworkImage(_user.image!)
                              : null,
                      child: _user.image == null || _user.image!.isEmpty
                          ? const Icon(Icons.person,
                              size: 32, color: AppColors.hintGray)
                          : null,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _user.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      _user.email,
                      style: const TextStyle(
                          color: AppColors.hintGray, fontSize: 13),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              _MenuTile(
                icon: Icons.receipt_long_outlined,
                label: 'My Orders',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const OrderHistoryPage()),
                ),
              ),
              _MenuTile(
                icon: Icons.edit_outlined,
                label: 'Edit Profile',
                onTap: () async {
                  final updated = await Navigator.push<UserEntity>(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EditProfilePage(user: _user),
                    ),
                  );
                  if (updated != null) setState(() => _user = updated);
                },
              ),
              _MenuTile(
                icon: Icons.lock_outline,
                label: 'Reset Password',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const UpdatePasswordPage()),
                ),
              ),
              _MenuTile(
                icon: Icons.help_outline,
                label: 'FAQ',
                onTap: () {},
              ),
              _MenuTile(
                icon: Icons.mail_outline,
                label: 'Contact Us',
                onTap: () {},
              ),
              _MenuTile(
                icon: Icons.privacy_tip_outlined,
                label: 'Privacy & Terms',
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _MenuTile({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: onTap,
      leading: Icon(icon, color: AppColors.textDark, size: 22),
      title: Text(label,
          style: const TextStyle(fontSize: 15, color: AppColors.textDark)),
      trailing:
          const Icon(Icons.chevron_right, color: AppColors.hintGray, size: 20),
    );
  }
}
