import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class AppModal extends StatefulWidget {
  final String title;
  final Widget body;
  final String? primaryLabel;
  final VoidCallback? onPrimary;
  final String? secondaryLabel;
  final VoidCallback? onSecondary;
  final bool requireScrollToBottom;
  final Widget? footer;

  const AppModal({
    super.key,
    required this.title,
    required this.body,
    this.primaryLabel,
    this.onPrimary,
    this.secondaryLabel,
    this.onSecondary,
    this.requireScrollToBottom = false,
    this.footer,
  });

  static Future<void> show({
    required BuildContext context,
    required String title,
    required Widget body,
    String? primaryLabel,
    VoidCallback? onPrimary,
    String? secondaryLabel,
    VoidCallback? onSecondary,
    bool requireScrollToBottom = false,
    Widget? footer,
  }) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: title,
      barrierColor: AppColors.background.withValues(alpha: 0.8),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (ctx, anim1, anim2) => AppModal(
        title: title,
        body: body,
        primaryLabel: primaryLabel,
        onPrimary: onPrimary,
        secondaryLabel: secondaryLabel,
        onSecondary: onSecondary,
        requireScrollToBottom: requireScrollToBottom,
        footer: footer,
      ),
      transitionBuilder: (ctx, anim, secondaryAnim, child) {
        return FadeTransition(
          opacity: anim,
          child: ScaleTransition(
            scale: CurvedAnimation(parent: anim, curve: Curves.easeOutCubic),
            child: child,
          ),
        );
      },
    );
  }

  @override
  State<AppModal> createState() => _AppModalState();
}

class _AppModalState extends State<AppModal> {
  final ScrollController _scrollController = ScrollController();
  bool _hasReachedBottom = false;
  double _scrollProgress = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    final progress = maxScroll > 0 ? (currentScroll / maxScroll).clamp(0.0, 1.0) : 1.0;
    final atBottom = currentScroll >= maxScroll - 10;

    if (progress != _scrollProgress || atBottom != _hasReachedBottom) {
      setState(() {
        _scrollProgress = progress;
        _hasReachedBottom = atBottom;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final canConfirm = !widget.requireScrollToBottom || _hasReachedBottom;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width < 600
              ? double.infinity
              : MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.width < 600
              ? double.infinity
              : MediaQuery.of(context).size.height * 0.9,
          constraints: const BoxConstraints(maxWidth: 1000),
          margin: MediaQuery.of(context).size.width < 600
              ? EdgeInsets.zero
              : const EdgeInsets.symmetric(vertical: 40),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(
              MediaQuery.of(context).size.width < 600 ? 0 : 24,
            ),
          ),
          child: Column(
            children: [
              _buildHeader(context),
              if (widget.requireScrollToBottom)
                _buildProgressBar(),
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  physics: const ClampingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: widget.body,
                  ),
                ),
              ),
              if (widget.footer != null || widget.primaryLabel != null || widget.secondaryLabel != null)
                _buildFooter(context, canConfirm),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(bottom: BorderSide(color: AppColors.border.withValues(alpha: 0.3))),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              widget.title,
              style: GoogleFonts.outfit(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close_rounded),
            style: IconButton.styleFrom(
              backgroundColor: AppColors.surfaceLight,
              foregroundColor: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    return Container(
      height: 3,
      color: AppColors.border,
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: _scrollProgress,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primary,
                AppColors.primary.withValues(alpha: 0.6),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context, bool canConfirm) {
    if (widget.footer != null) return widget.footer!;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.border.withValues(alpha: 0.3))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (widget.secondaryLabel != null)
            TextButton(
              onPressed: () {
                widget.onSecondary?.call();
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                foregroundColor: AppColors.textSecondary,
                textStyle: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              child: Text(widget.secondaryLabel!),
            ),
          if (widget.secondaryLabel != null) const SizedBox(width: 16),
          if (widget.primaryLabel != null)
            ElevatedButton(
              onPressed: canConfirm
                  ? () {
                      widget.onPrimary?.call();
                      Navigator.of(context).pop();
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: canConfirm ? AppColors.primary : AppColors.textMuted,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 0,
                textStyle: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              child: Text(widget.primaryLabel!),
            ),
        ],
      ),
    );
  }
}
