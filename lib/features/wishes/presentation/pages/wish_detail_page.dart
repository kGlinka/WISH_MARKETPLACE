import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/models/wish_model.dart';
import '../../../../core/theme/app_colors.dart';
import '../providers/wish_providers.dart';

/// Page for displaying detailed wish information
class WishDetailPage extends ConsumerStatefulWidget {
  final String wishId;

  const WishDetailPage({
    super.key,
    required this.wishId,
  });

  @override
  ConsumerState<WishDetailPage> createState() => _WishDetailPageState();
}

class _WishDetailPageState extends ConsumerState<WishDetailPage> {
  WishModel? _wish;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadWish();
  }

  Future<void> _loadWish() async {
    setState(() => _isLoading = true);

    final repository = ref.read(wishRepositoryProvider);
    final result = await repository.getWish(widget.wishId);

    result.fold(
      (failure) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${failure.message}')),
          );
        }
      },
      (wish) {
        if (mounted) {
          setState(() {
            _wish = wish;
            _isLoading = false;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(title: const Text('Wish Details')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_wish == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Wish Details')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              const Text('Wish not found'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => context.pop(),
                child: const Text('Go Back'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Wish Details'),
        actions: [
          IconButton(
            icon: Icon(
              _wish!.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: _wish!.isFavorite ? Colors.red : null,
            ),
            onPressed: () async {
              await ref
                  .read(wishActionsProvider.notifier)
                  .toggleFavorite(_wish!.id, !_wish!.isFavorite);
              _loadWish();
            },
          ),
          PopupMenuButton<String>(
            onSelected: (value) async {
              if (value == 'edit') {
                final result = await context.push(
                  '${AppConstants.editWishRoute}/${widget.wishId}',
                );
                if (result == true) {
                  _loadWish();
                }
              } else if (value == 'delete') {
                _showDeleteDialog();
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'edit',
                child: Row(
                  children: [
                    Icon(Icons.edit),
                    SizedBox(width: 8),
                    Text('Edit'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(Icons.delete, color: Colors.red),
                    SizedBox(width: 8),
                    Text('Delete', style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status and Priority
            Row(
              children: [
                _buildStatusChip(_wish!.status),
                const SizedBox(width: 8),
                _buildPriorityChip(_wish!.priority),
              ],
            ),
            const SizedBox(height: 16),

            // Title
            Text(
              _wish!.title,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),

            // Category and Target Date
            Row(
              children: [
                Icon(
                  _getCategoryIcon(_wish!.category),
                  color: AppColors.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  _wish!.category.displayName,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                if (_wish!.targetDate != null) ...[
                  const Spacer(),
                  Icon(Icons.calendar_today, color: Colors.grey[600]),
                  const SizedBox(width: 4),
                  Text(
                    _wish!.targetDate!,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ],
            ),
            const SizedBox(height: 24),

            // Progress (if in progress or completed)
            if (_wish!.status == WishStatus.inProgress ||
                _wish!.status == WishStatus.completed) ...[
              _buildProgressSection(),
              const SizedBox(height: 24),
            ],

            // Description
            _buildSection(
              'Description',
              _wish!.description,
            ),

            // Prerequisites
            if (_wish!.prerequisites.isNotEmpty) ...[
              const SizedBox(height: 24),
              _buildListSection(
                'Prerequisites',
                _wish!.prerequisites,
                Icons.check_box_outline_blank,
              ),
            ],

            // Tags
            if (_wish!.tags.isNotEmpty) ...[
              const SizedBox(height: 24),
              _buildTagsSection(),
            ],

            // Milestones
            if (_wish!.milestones.isNotEmpty) ...[
              const SizedBox(height: 24),
              _buildMilestonesSection(),
            ],

            // Notes
            if (_wish!.notes != null && _wish!.notes!.isNotEmpty) ...[
              const SizedBox(height: 24),
              _buildSection('Notes', _wish!.notes!),
            ],

            // Metadata
            if (_wish!.metadata != null) ...[
              if (_wish!.metadata!.inspiration != null &&
                  _wish!.metadata!.inspiration!.isNotEmpty) ...[
                const SizedBox(height: 24),
                _buildSection('Inspiration', _wish!.metadata!.inspiration!),
              ],
              if (_wish!.metadata!.motivation != null &&
                  _wish!.metadata!.motivation!.isNotEmpty) ...[
                const SizedBox(height: 24),
                _buildSection('Motivation', _wish!.metadata!.motivation!),
              ],
            ],

            const SizedBox(height: 32),
          ],
        ),
      ),
      bottomNavigationBar: _wish!.status != WishStatus.completed
          ? _buildActionButtons()
          : null,
    );
  }

  Widget _buildProgressSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Progress',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Text(
              '${_wish!.progress}%',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: _wish!.progress / 100,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
            minHeight: 12,
          ),
        ),
        const SizedBox(height: 8),
        Slider(
          value: _wish!.progress.toDouble(),
          min: 0,
          max: 100,
          divisions: 20,
          label: '${_wish!.progress}%',
          onChanged: (value) async {
            await ref
                .read(wishActionsProvider.notifier)
                .updateProgress(_wish!.id, value.toInt());
            _loadWish();
          },
        ),
      ],
    );
  }

  Widget _buildSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }

  Widget _buildListSection(String title, List<String> items, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        ...items.map((item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(icon, size: 20, color: Colors.grey[600]),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      item,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }

  Widget _buildTagsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tags',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _wish!.tags.map((tag) {
            return Chip(
              label: Text(tag),
              backgroundColor: Colors.grey[200],
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildMilestonesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Milestones',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        ..._wish!.milestones.map((milestone) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 4),
            child: ListTile(
              leading: Icon(
                milestone.isCompleted
                    ? Icons.check_circle
                    : Icons.radio_button_unchecked,
                color: milestone.isCompleted ? Colors.green : Colors.grey,
              ),
              title: Text(
                milestone.title,
                style: TextStyle(
                  decoration: milestone.isCompleted
                      ? TextDecoration.lineThrough
                      : null,
                ),
              ),
              subtitle: milestone.description != null
                  ? Text(milestone.description!)
                  : null,
            ),
          );
        }),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () async {
                await ref
                    .read(wishActionsProvider.notifier)
                    .markCompleted(_wish!.id);
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Congratulations! Wish marked as completed!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                  _loadWish();
                }
              },
              icon: const Icon(Icons.check_circle),
              label: const Text('Mark Complete'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(WishStatus status) {
    // Same implementation as in WishCard
    Color backgroundColor;
    Color textColor;
    String label;

    switch (status) {
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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildPriorityChip(WishPriority priority) {
    // Same implementation as in WishCard
    Color backgroundColor;
    Color textColor;
    String label;

    switch (priority) {
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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  IconData _getCategoryIcon(WishCategory category) {
    // Same implementation as in WishCard
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

  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Wish'),
        content: const Text(
          'Are you sure you want to delete this wish? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final navigator = Navigator.of(context);
              final scaffoldMessenger = ScaffoldMessenger.of(context);
              final router = GoRouter.of(context);

              navigator.pop();
              await ref
                  .read(wishFormProvider.notifier)
                  .deleteWish(_wish!.id);
              if (mounted) {
                scaffoldMessenger.showSnackBar(
                  const SnackBar(content: Text('Wish deleted')),
                );
                router.pop();
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
