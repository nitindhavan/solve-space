import 'package:flutter/material.dart';

class SidebarMenu extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onMenuItemTap;

  SidebarMenu({
    required this.selectedIndex,
    required this.onMenuItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: Color(0xFF1E1E2E), // Background color to match the sidebar
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(Icons.dashboard, color: Colors.white, size: 28),
                SizedBox(width: 10),
                Text(
                  'Solve Space',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Divider(color: Colors.grey),
          Expanded(
            child: ListView(
              children: [
                _buildMenuItem(
                  index: 0,
                  icon: Icons.chat_bubble_outline,
                  label: 'SolveSpace Bot',
                ),
                _buildMenuItem(
                  index: 1,
                  icon: Icons.dashboard_customize,
                  label: 'News',
                ),
                _buildMenuItem(
                  index: 2,
                  icon: Icons.insert_chart,
                  label: 'Communities',
                ),
                _buildMenuItem(
                  index: 3,
                  icon: Icons.bar_chart,
                  label: 'Updates',
                ),
                _buildMenuItem(
                  index: 4,
                  icon: Icons.settings,
                  label: 'Profile',
                ),
                _buildMenuItem(
                  index: 5,
                  icon: Icons.question_mark_sharp,
                  label: 'Post Question',
                ),
              ],
            ),
          ),
          Divider(color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required int index,
    required IconData icon,
    required String label,
  }) {
    final bool isSelected = index == selectedIndex;

    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? Colors.white : Colors.grey,
      ),
      title: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.grey,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      onTap: () {
        onMenuItemTap(index); // Call the provided callback with the menu index
      },
      selected: isSelected,
      selectedTileColor: Colors.purple,
    );
  }
}
