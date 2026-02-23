import 'package:flutter/material.dart';
import '../../../../core/models/wish_model.dart';
import '../../../../core/theme/app_colors.dart';

/// Card widget for displaying a wish in a list
class WishCard extends StatelessWidget {
  final WishModel wish;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteToggle;
  final VoidCallback? onDelete;

  const WishCard({
    super.key,
    required this.wish,
    this.onTap,
    this.onFavoriteToggle,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header row with status, priority, and favorite button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      _buildStatusChip(),
                      const SizedBox(width: 8),
                      _buildPriorityChip(),
                    ],
                  ),
                  IconButton(
                    icon: Icon(
                      wish.isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: wish.isFavorite ? Colors.red : Colors.grey,
                    ),
                    onPressed: onFavoriteToggle,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Title
              Text(
                wish.title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),

              // Description
              Text(
                wish.description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),

              // Category and target date
              Row(
                children: [
                  Icon(
                    _getCategoryIcon(wish.category),
                    size: 16,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    wish.category.displayName,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  if (wish.targetDate != null) ...[
                    const SizedBox(width: 16),
                    Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      wish.targetDate!,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey[600],
                          ),
                    ),
                  ],
                ],
              ),

              // Progress bar
              if (wish.status == WishStatus.inProgress ||
                  wish.status == WishStatus.completed) ...[
                const SizedBox(height: 12),
                _buildProgressBar(context),
              ],

              // Tags
              if (wish.tags.isNotEmpty) ...[
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: wish.tags.take(3).map((tag) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        tag,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    );
                  }).toList(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip() {
    Color backgroundColor;
    Color textColor;
    String label;

    switch (wish.status) {
      case WishStatus.active:
        backgroundColor = Colors.blue[100]!;
        textColor = Colors.blue[900]!;
        label = 'Active';
        break;
      case WishStatus.inProgress:
        backgroundColor = Colors.orange[100]!;
        textColor = Colors.orange[900]!;
        label = 'In Progress';
        break;
      case WishStatus.completed:
        backgroundColor = Colors.green[100]!;
        textColor = Colors.green[900]!;
        label = 'Completed';
        break;
      case WishStatus.deferred:
        backgroundColor = Colors.grey[300]!;
        textColor = Colors.grey[800]!;
        label = 'Deferred';
        break;
      case WishStatus.cancelled:
        backgroundColor = Colors.red[100]!;
        textColor = Colors.red[900]!;
        label = 'Cancelled';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildPriorityChip() {
    Color backgroundColor;
    Color textColor;
    String label;

    switch (wish.priority) {
      case WishPriority.low:
        backgroundColor = Colors.grey[200]!;
        textColor = Colors.grey[700]!;
        label = 'Low';
        break;
      case WishPriority.medium:
        backgroundColor = Colors.yellow[100]!;
        textColor = Colors.yellow[900]!;
        label = 'Medium';
        break;
      case WishPriority.high:
        backgroundColor = Colors.orange[100]!;
        textColor = Colors.orange[900]!;
        label = 'High';
        break;
      case WishPriority.urgent:
        backgroundColor = Colors.red[100]!;
        textColor = Colors.red[900]!;
        label = 'Urgent';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildProgressBar(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Progress',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            Text(
              '${wish.progress}%',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: wish.progress / 100,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
            minHeight: 6,
          ),
        ),
      ],
    );
  }

  IconData _getCategoryIcon(WishCategory category) {
    switch (category) {
      case WishCategory.personalGrowth:
        return Icons.self_improvement;
      case WishCategory.travel:
        return Icons.flight;
      case WishCategory.career:
        return Icons.work;
      case WishCategory.relationships:
        return Icons.favorite;
      case WishCategory.health:
        return Icons.fitness_center;
      case WishCategory.creativity:
        return Icons.palette;
      case WishCategory.financial:
        return Icons.attach_money;
      case WishCategory.education:
        return Icons.school;
      case WishCategory.adventure:
        return Icons.explore;
      case WishCategory.material:
        return Icons.shopping_bag;
      case WishCategory.spiritual:
        return Icons.spa;
      case WishCategory.other:
        return Icons.category;
    }
  }
}
