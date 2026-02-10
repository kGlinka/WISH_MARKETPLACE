import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/services/wish_service.dart';

/// Card widget for displaying wish statistics
class WishStatisticsCard extends StatelessWidget {
  final WishStatistics statistics;

  const WishStatisticsCard({
    Key? key,
    required this.statistics,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Wish Statistics',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildStatItem(
                    context,
                    'Total',
                    statistics.totalWishes,
                    AppColors.primary,
                    Icons.stars,
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    context,
                    'Active',
                    statistics.activeWishes,
                    Colors.blue,
                    Icons.radio_button_checked,
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    context,
                    'In Progress',
                    statistics.inProgressWishes,
                    Colors.orange,
                    Icons.trending_up,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildStatItem(
                    context,
                    'Completed',
                    statistics.completedWishes,
                    Colors.green,
                    Icons.check_circle,
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    context,
                    'Deferred',
                    statistics.deferredWishes,
                    Colors.grey,
                    Icons.pause_circle,
                  ),
                ),
                const Expanded(child: SizedBox()), // Empty space for alignment
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context,
    String label,
    int value,
    Color color,
    IconData icon,
  ) {
    return Column(
      children: [
        Icon(icon, color: color, size: 32),
        const SizedBox(height: 8),
        Text(
          value.toString(),
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
