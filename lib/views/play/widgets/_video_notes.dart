part of '../play.dart';

class _VideoNotesPanel extends StatefulWidget {
  const _VideoNotesPanel();

  @override
  State<_VideoNotesPanel> createState() => _VideoNotesPanelState();
}

class _VideoNotesPanelState extends State<_VideoNotesPanel> {
  List<VideoNoteEntity> _notes = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    setState(() => _isLoading = true);
    final cubit = context.read<_ScreenCubit>();
    final notes = await cubit.getNotesForCurrentVideo();
    if (mounted) {
      setState(() {
        _notes = notes;
        _isLoading = false;
      });
    }
  }

  void _showAddNoteDialog() {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.black2,
        title: Text(LocaleKeys.player_add_note.tr()),
        content: TextField(
          controller: controller,
          autofocus: true,
          maxLines: 3,
          style: const TextStyle(color: AppColors.white1),
          decoration: InputDecoration(
            hintText: LocaleKeys.player_note_placeholder.tr(),
            hintStyle: TextStyle(color: AppColors.grey1.withValues(alpha: 0.5)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide:
                  BorderSide(color: AppColors.white1.withValues(alpha: 0.2)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide:
                  BorderSide(color: AppColors.white1.withValues(alpha: 0.2)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.white1),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(
              LocaleKeys.common_cancel.tr(),
              style: const TextStyle(color: AppColors.grey1),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              if (controller.text.trim().isNotEmpty) {
                Navigator.pop(dialogContext);
                final cubit = context.read<_ScreenCubit>();
                await cubit.addNote(controller.text.trim());
                await _loadNotes();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.white1,
              foregroundColor: AppColors.black1,
            ),
            child: Text(LocaleKeys.common_save.tr()),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      decoration: BoxDecoration(
        color: AppColors.black2,
        border: Border(
          left: BorderSide(
            color: AppColors.white1.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: AppColors.white1.withValues(alpha: 0.1),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.note, color: AppColors.white1, size: 20),
                const SizedBox(width: 8),
                Text(
                  LocaleKeys.player_notes.tr(),
                  style: AppTypography.bodyLarge.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close, size: 20),
                  onPressed: () => context.read<_ScreenCubit>().toggleNotes(),
                  tooltip: LocaleKeys.common_close.tr(),
                ),
              ],
            ),
          ),

          // Add note button
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _showAddNoteDialog,
                icon: const Icon(Icons.add),
                label: Text(LocaleKeys.player_add_note.tr()),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.white1,
                  foregroundColor: AppColors.black1,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ),

          // Notes list
          Expanded(
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: AppColors.white1),
                  )
                : _notes.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.note_outlined,
                              size: 64,
                              color: AppColors.grey1.withValues(alpha: 0.3),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              LocaleKeys.player_no_notes.tr(),
                              style: AppTypography.bodyMedium.copyWith(
                                color: AppColors.grey1,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: _notes.length,
                        itemBuilder: (context, index) {
                          final note = _notes[index];
                          return _NoteCard(
                            note: note,
                            onTap: () async {
                              final cubit = context.read<_ScreenCubit>();
                              await cubit.seekToNote(note.timestampSeconds);
                            },
                            onDelete: () async {
                              final cubit = context.read<_ScreenCubit>();
                              await cubit.deleteNote(note.id);
                              await _loadNotes();
                            },
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}

class _NoteCard extends StatelessWidget {
  final VideoNoteEntity note;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const _NoteCard({
    required this.note,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.white1.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.white1.withValues(alpha: 0.1),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.white1.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.access_time,
                            size: 14,
                            color: AppColors.white1,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            note.formattedTimestamp,
                            style: AppTypography.bodySmall.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.delete_outline, size: 18),
                      color: AppColors.grey1,
                      onPressed: onDelete,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  note.noteText,
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.white1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
