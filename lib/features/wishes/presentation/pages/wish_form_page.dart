import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/models/wish_model.dart';
import '../../../../core/providers/firebase_providers.dart';
import '../../../../core/theme/app_colors.dart';
import '../providers/wish_providers.dart';

/// Page for creating and editing wishes
class WishFormPage extends ConsumerStatefulWidget {
  final String? wishId;

  const WishFormPage({
    Key? key,
    this.wishId,
  }) : super(key: key);

  @override
  ConsumerState<WishFormPage> createState() => _WishFormPageState();
}

class _WishFormPageState extends ConsumerState<WishFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _targetDateController = TextEditingController();
  final _notesController = TextEditingController();
  final _inspirationController = TextEditingController();
  final _motivationController = TextEditingController();

  WishCategory _selectedCategory = WishCategory.other;
  WishPriority _selectedPriority = WishPriority.medium;
  WishStatus _selectedStatus = WishStatus.active;
  List<String> _tags = [];
  List<String> _prerequisites = [];
  List<WishMilestone> _milestones = [];
  int _progress = 0;
  bool _isPublic = false;
  bool _isFavorite = false;

  bool _isLoading = false;
  WishModel? _existingWish;

  @override
  void initState() {
    super.initState();
    if (widget.wishId != null) {
      _loadWish();
    }
  }

  Future<void> _loadWish() async {
    setState(() => _isLoading = true);

    final repository = ref.read(wishRepositoryProvider);
    final result = await repository.getWish(widget.wishId!);

    result.fold(
      (failure) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${failure.message}')),
          );
        }
      },
      (wish) {
        if (wish != null && mounted) {
          setState(() {
            _existingWish = wish;
            _titleController.text = wish.title;
            _descriptionController.text = wish.description;
            _targetDateController.text = wish.targetDate ?? '';
            _notesController.text = wish.notes ?? '';
            _inspirationController.text = wish.metadata?.inspiration ?? '';
            _motivationController.text = wish.metadata?.motivation ?? '';
            _selectedCategory = wish.category;
            _selectedPriority = wish.priority;
            _selectedStatus = wish.status;
            _tags = List.from(wish.tags);
            _prerequisites = List.from(wish.prerequisites);
            _milestones = List.from(wish.milestones);
            _progress = wish.progress;
            _isPublic = wish.isPublic;
            _isFavorite = wish.isFavorite;
            _isLoading = false;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _targetDateController.dispose();
    _notesController.dispose();
    _inspirationController.dispose();
    _motivationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formState = ref.watch(wishFormProvider);

    ref.listen<WishFormState>(wishFormProvider, (previous, next) {
      if (next.successMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.successMessage!),
            backgroundColor: Colors.green,
          ),
        );
        context.pop(true);
      } else if (next.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.error!),
            backgroundColor: Colors.red,
          ),
        );
      }
    });

    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.wishId == null ? 'Create Wish' : 'Edit Wish'),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.wishId == null ? 'Create Wish' : 'Edit Wish'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Title
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title *',
                hintText: 'Enter your wish title',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Description
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description *',
                hintText: 'Describe your wish in detail',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a description';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Category
            DropdownButtonFormField<WishCategory>(
              value: _selectedCategory,
              decoration: const InputDecoration(
                labelText: 'Category *',
                border: OutlineInputBorder(),
              ),
              items: WishCategory.values.map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category.displayName),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => _selectedCategory = value);
                }
              },
            ),
            const SizedBox(height: 16),

            // Priority
            DropdownButtonFormField<WishPriority>(
              value: _selectedPriority,
              decoration: const InputDecoration(
                labelText: 'Priority *',
                border: OutlineInputBorder(),
              ),
              items: WishPriority.values.map((priority) {
                return DropdownMenuItem(
                  value: priority,
                  child: Text(priority.name.toUpperCase()),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => _selectedPriority = value);
                }
              },
            ),
            const SizedBox(height: 16),

            // Status
            DropdownButtonFormField<WishStatus>(
              value: _selectedStatus,
              decoration: const InputDecoration(
                labelText: 'Status *',
                border: OutlineInputBorder(),
              ),
              items: WishStatus.values.map((status) {
                return DropdownMenuItem(
                  value: status,
                  child: Text(status.name.toUpperCase()),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => _selectedStatus = value);
                }
              },
            ),
            const SizedBox(height: 16),

            // Target Date
            TextFormField(
              controller: _targetDateController,
              decoration: const InputDecoration(
                labelText: 'Target Date',
                hintText: 'When do you want to achieve this?',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.calendar_today),
              ),
              readOnly: true,
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 3650)),
                );
                if (date != null) {
                  _targetDateController.text =
                      '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
                }
              },
            ),
            const SizedBox(height: 16),

            // Progress (if in progress or completed)
            if (_selectedStatus == WishStatus.inProgress ||
                _selectedStatus == WishStatus.completed) ...[
              Text(
                'Progress: $_progress%',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Slider(
                value: _progress.toDouble(),
                min: 0,
                max: 100,
                divisions: 20,
                label: '$_progress%',
                onChanged: (value) {
                  setState(() => _progress = value.toInt());
                },
              ),
              const SizedBox(height: 16),
            ],

            // Notes
            TextFormField(
              controller: _notesController,
              decoration: const InputDecoration(
                labelText: 'Notes',
                hintText: 'Any additional notes',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),

            // Inspiration
            TextFormField(
              controller: _inspirationController,
              decoration: const InputDecoration(
                labelText: 'Inspiration',
                hintText: 'What inspired this wish?',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),

            // Motivation
            TextFormField(
              controller: _motivationController,
              decoration: const InputDecoration(
                labelText: 'Motivation',
                hintText: 'Why is this wish important to you?',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),

            // Tags
            _buildTagsSection(),
            const SizedBox(height: 16),

            // Prerequisites
            _buildPrerequisitesSection(),
            const SizedBox(height: 16),

            // Switches
            SwitchListTile(
              title: const Text('Mark as Favorite'),
              value: _isFavorite,
              onChanged: (value) {
                setState(() => _isFavorite = value);
              },
            ),
            SwitchListTile(
              title: const Text('Make Public'),
              subtitle: const Text('Share this wish with others'),
              value: _isPublic,
              onChanged: (value) {
                setState(() => _isPublic = value);
              },
            ),
            const SizedBox(height: 24),

            // Submit Button
            ElevatedButton(
              onPressed: formState.isLoading ? null : _submitForm,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: formState.isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text(
                      widget.wishId == null ? 'Create Wish' : 'Update Wish',
                      style: const TextStyle(fontSize: 16),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTagsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Tags',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            TextButton.icon(
              onPressed: _addTag,
              icon: const Icon(Icons.add),
              label: const Text('Add Tag'),
            ),
          ],
        ),
        if (_tags.isNotEmpty)
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _tags.map((tag) {
              return Chip(
                label: Text(tag),
                onDeleted: () {
                  setState(() => _tags.remove(tag));
                },
              );
            }).toList(),
          ),
      ],
    );
  }

  Widget _buildPrerequisitesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Prerequisites',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            TextButton.icon(
              onPressed: _addPrerequisite,
              icon: const Icon(Icons.add),
              label: const Text('Add'),
            ),
          ],
        ),
        if (_prerequisites.isNotEmpty)
          ..._prerequisites.asMap().entries.map((entry) {
            return ListTile(
              leading: const Icon(Icons.check_box_outline_blank),
              title: Text(entry.value),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  setState(() => _prerequisites.removeAt(entry.key));
                },
              ),
            );
          }),
      ],
    );
  }

  void _addTag() {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Tag'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Enter tag'),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                setState(() => _tags.add(controller.text));
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _addPrerequisite() {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Prerequisite'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Enter prerequisite'),
          autofocus: true,
          maxLines: 3,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                setState(() => _prerequisites.add(controller.text));
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final userId = ref.read(currentUserIdProvider);
    if (userId == null || userId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not authenticated')),
      );
      return;
    }

    final metadata = WishMetadata(
      inspiration: _inspirationController.text.isNotEmpty
          ? _inspirationController.text
          : null,
      motivation: _motivationController.text.isNotEmpty
          ? _motivationController.text
          : null,
    );

    final wish = WishModel(
      id: widget.wishId ?? '',
      userId: userId,
      title: _titleController.text,
      description: _descriptionController.text,
      category: _selectedCategory,
      priority: _selectedPriority,
      status: _selectedStatus,
      tags: _tags,
      prerequisites: _prerequisites,
      targetDate: _targetDateController.text.isNotEmpty
          ? _targetDateController.text
          : null,
      notes: _notesController.text.isNotEmpty ? _notesController.text : null,
      progress: _progress,
      milestones: _milestones,
      isPublic: _isPublic,
      isFavorite: _isFavorite,
      metadata: metadata,
      createdAt: _existingWish?.createdAt ?? DateTime.now(),
      updatedAt: DateTime.now(),
    );

    if (widget.wishId == null) {
      ref.read(wishFormProvider.notifier).createWish(wish);
    } else {
      ref.read(wishFormProvider.notifier).updateWish(widget.wishId!, wish);
    }
  }
}
