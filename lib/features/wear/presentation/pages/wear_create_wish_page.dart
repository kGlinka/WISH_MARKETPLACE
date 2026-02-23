import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/wish_model.dart';
import '../../../../core/providers/firebase_providers.dart';
import '../../core/wear_theme.dart';
import '../../core/wear_constants.dart';
import '../widgets/wear_scaffold.dart';
import '../widgets/wear_card.dart';
import '../widgets/wear_loading.dart';

class WearCreateWishPage extends ConsumerStatefulWidget {
  final VoidCallback onWishCreated;

  const WearCreateWishPage({super.key, required this.onWishCreated});

  @override
  ConsumerState<WearCreateWishPage> createState() => _WearCreateWishPageState();
}

class _WearCreateWishPageState extends ConsumerState<WearCreateWishPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  WishCategory _selectedCategory = WishCategory.other;
  WishPriority _selectedPriority = WishPriority.medium;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _createWish() async {
    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();

    if (title.isEmpty) {
      setState(() => _errorMessage = 'Title is required');
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final firestoreService = ref.read(firestoreServiceProvider);
      final userId = ref.read(currentUserIdProvider);

      if (userId == null) {
        setState(() {
          _errorMessage = 'Not authenticated';
          _isLoading = false;
        });
        return;
      }

      await firestoreService.createDocument(
        collection: 'wishes',
        data: {
          'userId': userId,
          'title': title,
          'description': description,
          'category': _selectedCategory.name,
          'priority': _selectedPriority.name,
          'status': WishStatus.active.name,
          'progress': 0,
          'tags': <String>[],
          'prerequisites': <String>[],
          'milestones': <Map<String, dynamic>>[],
          'imageUrls': <String>[],
          'isPublic': false,
          'isFavorite': false,
        },
      );

      widget.onWishCreated();
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return const WearLoading();

    return WearScaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: WearConstants.listTopPadding,
        ),
        children: [
          // Title
          const Text(
            'New Wish',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: WearColors.primary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),

          // Error message
          if (_errorMessage != null)
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: WearColors.error.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                _errorMessage!,
                style: const TextStyle(fontSize: 10, color: WearColors.error),
                textAlign: TextAlign.center,
              ),
            ),

          // Title field
          TextField(
            controller: _titleController,
            style: const TextStyle(fontSize: 12, color: WearColors.onSurface),
            decoration: InputDecoration(
              hintText: 'Title',
              hintStyle: const TextStyle(fontSize: 12, color: WearColors.onSurfaceVariant),
              filled: true,
              fillColor: WearColors.surface,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Description field
          TextField(
            controller: _descriptionController,
            maxLines: 2,
            style: const TextStyle(fontSize: 12, color: WearColors.onSurface),
            decoration: InputDecoration(
              hintText: 'Description (optional)',
              hintStyle: const TextStyle(fontSize: 12, color: WearColors.onSurfaceVariant),
              filled: true,
              fillColor: WearColors.surface,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Category selector
          WearCard(
            onTap: () => _showCategoryPicker(),
            child: Row(
              children: [
                const Icon(Icons.category, size: 16, color: WearColors.onSurfaceVariant),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _selectedCategory.displayName,
                    style: const TextStyle(fontSize: 12, color: WearColors.onSurface),
                  ),
                ),
                const Icon(Icons.chevron_right, size: 16, color: WearColors.onSurfaceVariant),
              ],
            ),
          ),

          // Priority selector
          WearCard(
            onTap: () => _showPriorityPicker(),
            child: Row(
              children: [
                Icon(Icons.flag, size: 16, color: _priorityColor(_selectedPriority)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _selectedPriority.name[0].toUpperCase() + _selectedPriority.name.substring(1),
                    style: const TextStyle(fontSize: 12, color: WearColors.onSurface),
                  ),
                ),
                const Icon(Icons.chevron_right, size: 16, color: WearColors.onSurfaceVariant),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Create button
          SizedBox(
            height: WearConstants.minTouchTarget,
            child: ElevatedButton.icon(
              onPressed: _createWish,
              icon: const Icon(Icons.add, size: 18),
              label: const Text('Create', style: TextStyle(fontSize: 13)),
              style: ElevatedButton.styleFrom(
                backgroundColor: WearColors.primary,
                foregroundColor: WearColors.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _priorityColor(WishPriority priority) {
    switch (priority) {
      case WishPriority.low:
        return WearColors.onSurfaceVariant;
      case WishPriority.medium:
        return WearColors.info;
      case WishPriority.high:
        return WearColors.warning;
      case WishPriority.urgent:
        return WearColors.error;
    }
  }

  void _showCategoryPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: WearColors.surface,
      builder: (context) {
        return ListView(
          padding: const EdgeInsets.symmetric(vertical: 8),
          children: WishCategory.values.map((category) {
            return ListTile(
              dense: true,
              title: Text(
                category.displayName,
                style: const TextStyle(fontSize: 12, color: WearColors.onSurface),
              ),
              selected: category == _selectedCategory,
              selectedTileColor: WearColors.primary.withValues(alpha: 0.2),
              onTap: () {
                setState(() => _selectedCategory = category);
                Navigator.pop(context);
              },
            );
          }).toList(),
        );
      },
    );
  }

  void _showPriorityPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: WearColors.surface,
      builder: (context) {
        return ListView(
          padding: const EdgeInsets.symmetric(vertical: 8),
          children: WishPriority.values.map((priority) {
            final label = priority.name[0].toUpperCase() + priority.name.substring(1);
            return ListTile(
              dense: true,
              leading: Icon(Icons.flag, size: 16, color: _priorityColor(priority)),
              title: Text(
                label,
                style: const TextStyle(fontSize: 12, color: WearColors.onSurface),
              ),
              selected: priority == _selectedPriority,
              selectedTileColor: WearColors.primary.withValues(alpha: 0.2),
              onTap: () {
                setState(() => _selectedPriority = priority);
                Navigator.pop(context);
              },
            );
          }).toList(),
        );
      },
    );
  }
}
