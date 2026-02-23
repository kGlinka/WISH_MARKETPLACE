import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/firebase_providers.dart';
import '../../core/wear_theme.dart';
import '../../core/wear_constants.dart';
import '../../core/wear_model_extensions.dart';
import '../../data/providers/wear_providers.dart';
import '../widgets/wear_scaffold.dart';
import '../widgets/wear_card.dart';
import '../widgets/wear_chip.dart';
import '../widgets/wear_progress_bar.dart';
import '../widgets/wear_loading.dart';
import '../widgets/wear_error_state.dart';

class WearWishDetailPage extends ConsumerStatefulWidget {
  final String wishId;

  const WearWishDetailPage({super.key, required this.wishId});

  @override
  ConsumerState<WearWishDetailPage> createState() => _WearWishDetailPageState();
}

class _WearWishDetailPageState extends ConsumerState<WearWishDetailPage> {
  bool _isUpdating = false;

  Future<void> _updateProgress(int newProgress) async {
    setState(() => _isUpdating = true);
    try {
      final firestoreService = ref.read(firestoreServiceProvider);
      await firestoreService.updateDocument(
        collection: 'wishes',
        documentId: widget.wishId,
        data: {'progress': newProgress},
      );
      // Refresh the provider
      ref.invalidate(wearWishDetailProvider(widget.wishId));
    } catch (e) {
      // Error handled silently on watch
    }
    setState(() => _isUpdating = false);
  }

  @override
  Widget build(BuildContext context) {
    final wishAsync = ref.watch(wearWishDetailProvider(widget.wishId));

    return WearScaffold(
      body: wishAsync.when(
        loading: () => const WearLoading(),
        error: (error, _) => WearErrorState(message: error.toString()),
        data: (wish) {
          if (wish == null) {
            return const WearErrorState(message: 'Wish not found');
          }

          return ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: WearConstants.listTopPadding,
            ),
            children: [
              // Title
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  wish.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: WearColors.onSurface,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              // Status and Priority card
              WearCard(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Status', style: TextStyle(fontSize: 12, color: WearColors.onSurfaceVariant)),
                        Text(
                          wish.status.name[0].toUpperCase() + wish.status.name.substring(1),
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: wish.statusColor),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text('Priority', style: TextStyle(fontSize: 12, color: WearColors.onSurfaceVariant)),
                        Row(
                          children: [
                            Text(
                              wish.priority.name[0].toUpperCase() + wish.priority.name.substring(1),
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: wish.priorityColor),
                            ),
                            const SizedBox(width: 4),
                            Container(
                              width: 8, height: 8,
                              decoration: BoxDecoration(color: wish.priorityColor, shape: BoxShape.circle),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Description
              WearCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 4),
                      child: Text('Description', style: TextStyle(fontSize: 12, color: WearColors.onSurfaceVariant)),
                    ),
                    Text(
                      wish.description,
                      style: const TextStyle(fontSize: 14, color: WearColors.onSurface),
                      maxLines: 6,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              // Progress section
              WearCard(
                backgroundColor: WearColors.primary.withValues(alpha: 0.1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 8),
                      child: Text('Progress', style: TextStyle(fontSize: 12, color: WearColors.onSurfaceVariant)),
                    ),
                    WearProgressBar(progress: wish.progress),
                  ],
                ),
              ),

              // Update Progress label
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  'Update Progress',
                  style: TextStyle(fontSize: 12, color: WearColors.onSurfaceVariant),
                  textAlign: TextAlign.center,
                ),
              ),

              // +25% button
              WearChip(
                label: '+25%',
                onTap: () {
                  final newProgress = (wish.progress + 25).clamp(0, 100);
                  _updateProgress(newProgress);
                },
                enabled: !_isUpdating && wish.progress < 100,
              ),

              // +10% button
              WearChip(
                label: '+10%',
                onTap: () {
                  final newProgress = (wish.progress + 10).clamp(0, 100);
                  _updateProgress(newProgress);
                },
                enabled: !_isUpdating && wish.progress < 100,
              ),

              // Mark Complete button
              if (wish.progress < 100)
                WearChip(
                  label: 'Mark Complete',
                  icon: Icons.check_circle,
                  backgroundColor: WearColors.success,
                  labelColor: Colors.white,
                  onTap: () => _updateProgress(100),
                  enabled: !_isUpdating,
                ),

              // Category and target date
              WearCard(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Category', style: TextStyle(fontSize: 12, color: WearColors.onSurfaceVariant)),
                        Text(wish.categoryDisplay, style: const TextStyle(fontSize: 14, color: WearColors.onSurface)),
                      ],
                    ),
                    if (wish.targetDate != null) ...[
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Target Date', style: TextStyle(fontSize: 12, color: WearColors.onSurfaceVariant)),
                          Text(wish.targetDate!, style: const TextStyle(fontSize: 14, color: WearColors.onSurface)),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
