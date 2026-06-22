import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Semantic custom colors that are not covered by [ColorScheme].
/// Accessed via [BuildContext.appColors].
@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.surface,
    required this.onSurface,
    required this.onSurfaceSecondary,
    required this.inputBg,
    required this.containerBg,
    required this.chatRoomBg,
    required this.receiverBubbleBg,
    required this.receiverBubbleText,
    required this.senderReplyBg,
    required this.receiverReplyBg,
    required this.recordingBg,
    required this.dateSepBg,
    required this.dateSepText,
    required this.memberChipBg,
    required this.navBarBg,
    required this.divider,
    required this.versionText,
    required this.secondaryText,
    required this.green,
    required this.blueContainer,
    required this.biometricIdleBg,
    required this.biometricVerifyBg,
    required this.biometricIconActive,
    required this.biometricSubtitle,
    required this.fileBubbleReceiver,
  });

  /// AppBar / card / bottom-sheet background.
  final Color surface;

  /// Primary text (replaces kBlackColor).
  final Color onSurface;

  /// Secondary text (replaces kSecondaryGreyColor / kSecondaryBlackColor).
  final Color onSurfaceSecondary;

  /// TextField / input background (replaces kInputGreyColor).
  final Color inputBg;

  /// Search-field / container background (replaces secondaryWhiteColor).
  final Color containerBg;

  /// Chat-room wallpaper (replaces blueBackgroundColor).
  final Color chatRoomBg;

  /// Receiver chat-bubble background (white in light, dark surface in dark).
  final Color receiverBubbleBg;

  /// Receiver chat-bubble text.
  final Color receiverBubbleText;

  /// Reply-preview background on the sender side.
  final Color senderReplyBg;

  /// Reply-preview background on the receiver side.
  final Color receiverReplyBg;

  /// Recording-UI background.
  final Color recordingBg;

  /// Date-separator pill background.
  final Color dateSepBg;

  /// Date-separator pill text.
  final Color dateSepText;

  /// Group-member chip background.
  final Color memberChipBg;

  /// Bottom navigation bar background.
  final Color navBarBg;

  /// Thin divider / separator.
  final Color divider;

  /// App-version footnote text.
  final Color versionText;

  /// Timestamp / secondary-black text (replaces kSecondaryBlackColor).
  final Color secondaryText;

  /// Green used for call-answer button (replaces greenColor).
  final Color green;

  /// Blue container accent (replaces blueContainerColor).
  final Color blueContainer;

  // Biometric screen
  final Color biometricIdleBg;
  final Color biometricVerifyBg;
  final Color biometricIconActive;
  final Color biometricSubtitle;

  /// File-message bubble background for the receiver.
  final Color fileBubbleReceiver;

  // ─── Light palette ──────────────────────────────────────────────────────────

  static const AppColors light = AppColors(
    surface: Color(0xFFFFFFFF),
    onSurface: Color(0xFF101520),
    onSurfaceSecondary: Color(0xFF535353),
    inputBg: Color(0xFFF9FAFB),
    containerBg: Color(0xFFF3F5F7),
    chatRoomBg: Color(0xFFDCDFF8),
    receiverBubbleBg: Color(0xFFFFFFFF),
    receiverBubbleText: Color(0xFF101520),
    senderReplyBg: Color(0x99FFFFFF), // white @ 60 %
    receiverReplyBg: Color(0x4D00BC7D), // primary @ 30 %
    recordingBg: Color(0xFFFFF2F2),
    dateSepBg: Color(0x0D000000), // black @ 5 %
    dateSepText: Color(0xFF6B7280),
    memberChipBg: Color(0xFFECFDF5),
    navBarBg: Color(0xFFFFFFFF),
    divider: Color(0xFFF3F4F6),
    versionText: Color(0xFFD1D5DC),
    secondaryText: Color(0xE6223159), // kSecondaryBlackColor
    green: Color(0xFF2B8B57),
    blueContainer: Color(0xFF4F7CF6),
    biometricIdleBg: Color(0xFFF9FAFB),
    biometricVerifyBg: Color(0xFFECFDF5),
    biometricIconActive: Color.fromARGB(255, 159, 218, 199),
    biometricSubtitle: Color(0xFF8A94A6),
    fileBubbleReceiver: Color(0xFF64B5F6), // blue.shade400
  );

  // ─── Dark palette ───────────────────────────────────────────────────────────

  static const AppColors dark = AppColors(
    surface: Color(0xFF1A2232),
    onSurface: Color(0xFFF3F5F7),
    onSurfaceSecondary: Color(0xFFB0B8C8),
    inputBg: Color(0xFF1E2A3A),
    containerBg: Color(0xFF252E3D),
    chatRoomBg: Color(0xFF0E1522),
    receiverBubbleBg: Color(0xFF1E2A3A),
    receiverBubbleText: Color(0xFFF3F5F7),
    senderReplyBg: Color(0x26FFFFFF), // white @ 15 %
    receiverReplyBg: Color(0x3300BC7D), // primary @ 20 %
    recordingBg: Color(0xFF2A1A1A),
    dateSepBg: Color(0x1AFFFFFF), // white @ 10 %
    dateSepText: Color(0xFFB0B8C8),
    memberChipBg: Color(0xFF003828),
    navBarBg: Color(0xFF1A2232),
    divider: Color(0xFF252E3D),
    versionText: Color(0xFF535353),
    secondaryText: Color(0xE6C8D4F0),
    green: Color(0xFF2B8B57),
    blueContainer: Color(0xFF4F7CF6),
    biometricIdleBg: Color(0xFF1E2A3A),
    biometricVerifyBg: Color(0xFF003828),
    biometricIconActive: Color(0xFF2ECC9B),
    biometricSubtitle: Color(0xFF8A94A6),
    fileBubbleReceiver: Color(0xFF1565C0), // blue.shade900 — visible on dark bg
  );

  // ─── ThemeExtension overrides ────────────────────────────────────────────────

  @override
  AppColors copyWith({
    Color? surface,
    Color? onSurface,
    Color? onSurfaceSecondary,
    Color? inputBg,
    Color? containerBg,
    Color? chatRoomBg,
    Color? receiverBubbleBg,
    Color? receiverBubbleText,
    Color? senderReplyBg,
    Color? receiverReplyBg,
    Color? recordingBg,
    Color? dateSepBg,
    Color? dateSepText,
    Color? memberChipBg,
    Color? navBarBg,
    Color? divider,
    Color? versionText,
    Color? secondaryText,
    Color? green,
    Color? blueContainer,
    Color? biometricIdleBg,
    Color? biometricVerifyBg,
    Color? biometricIconActive,
    Color? biometricSubtitle,
    Color? fileBubbleReceiver,
  }) {
    return AppColors(
      surface: surface ?? this.surface,
      onSurface: onSurface ?? this.onSurface,
      onSurfaceSecondary: onSurfaceSecondary ?? this.onSurfaceSecondary,
      inputBg: inputBg ?? this.inputBg,
      containerBg: containerBg ?? this.containerBg,
      chatRoomBg: chatRoomBg ?? this.chatRoomBg,
      receiverBubbleBg: receiverBubbleBg ?? this.receiverBubbleBg,
      receiverBubbleText: receiverBubbleText ?? this.receiverBubbleText,
      senderReplyBg: senderReplyBg ?? this.senderReplyBg,
      receiverReplyBg: receiverReplyBg ?? this.receiverReplyBg,
      recordingBg: recordingBg ?? this.recordingBg,
      dateSepBg: dateSepBg ?? this.dateSepBg,
      dateSepText: dateSepText ?? this.dateSepText,
      memberChipBg: memberChipBg ?? this.memberChipBg,
      navBarBg: navBarBg ?? this.navBarBg,
      divider: divider ?? this.divider,
      versionText: versionText ?? this.versionText,
      secondaryText: secondaryText ?? this.secondaryText,
      green: green ?? this.green,
      blueContainer: blueContainer ?? this.blueContainer,
      biometricIdleBg: biometricIdleBg ?? this.biometricIdleBg,
      biometricVerifyBg: biometricVerifyBg ?? this.biometricVerifyBg,
      biometricIconActive: biometricIconActive ?? this.biometricIconActive,
      biometricSubtitle: biometricSubtitle ?? this.biometricSubtitle,
      fileBubbleReceiver: fileBubbleReceiver ?? this.fileBubbleReceiver,
    );
  }

  @override
  AppColors lerp(AppColors? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      surface: Color.lerp(surface, other.surface, t)!,
      onSurface: Color.lerp(onSurface, other.onSurface, t)!,
      onSurfaceSecondary: Color.lerp(
        onSurfaceSecondary,
        other.onSurfaceSecondary,
        t,
      )!,
      inputBg: Color.lerp(inputBg, other.inputBg, t)!,
      containerBg: Color.lerp(containerBg, other.containerBg, t)!,
      chatRoomBg: Color.lerp(chatRoomBg, other.chatRoomBg, t)!,
      receiverBubbleBg: Color.lerp(
        receiverBubbleBg,
        other.receiverBubbleBg,
        t,
      )!,
      receiverBubbleText: Color.lerp(
        receiverBubbleText,
        other.receiverBubbleText,
        t,
      )!,
      senderReplyBg: Color.lerp(senderReplyBg, other.senderReplyBg, t)!,
      receiverReplyBg: Color.lerp(receiverReplyBg, other.receiverReplyBg, t)!,
      recordingBg: Color.lerp(recordingBg, other.recordingBg, t)!,
      dateSepBg: Color.lerp(dateSepBg, other.dateSepBg, t)!,
      dateSepText: Color.lerp(dateSepText, other.dateSepText, t)!,
      memberChipBg: Color.lerp(memberChipBg, other.memberChipBg, t)!,
      navBarBg: Color.lerp(navBarBg, other.navBarBg, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
      versionText: Color.lerp(versionText, other.versionText, t)!,
      secondaryText: Color.lerp(secondaryText, other.secondaryText, t)!,
      green: Color.lerp(green, other.green, t)!,
      blueContainer: Color.lerp(blueContainer, other.blueContainer, t)!,
      biometricIdleBg: Color.lerp(biometricIdleBg, other.biometricIdleBg, t)!,
      biometricVerifyBg: Color.lerp(
        biometricVerifyBg,
        other.biometricVerifyBg,
        t,
      )!,
      biometricIconActive: Color.lerp(
        biometricIconActive,
        other.biometricIconActive,
        t,
      )!,
      biometricSubtitle: Color.lerp(
        biometricSubtitle,
        other.biometricSubtitle,
        t,
      )!,
      fileBubbleReceiver: Color.lerp(
        fileBubbleReceiver,
        other.fileBubbleReceiver,
        t,
      )!,
    );
  }
}

/// Convenience accessor: `context.appColors`.
extension AppColorsContext on BuildContext {
  AppColors get appColors => Theme.of(this).extension<AppColors>()!;
}

// ---------------------------------------------------------------------------
// AppTheme — light + dark ThemeData
// ---------------------------------------------------------------------------

// Cached once at app startup (same pattern as main.dart's _textTheme).
final _interTextTheme = GoogleFonts.interTextTheme();
final _interTextThemeDark = GoogleFonts.interTextTheme(
  ThemeData.dark().textTheme,
);

class AppTheme {
  AppTheme._();

  static ThemeData get light => ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF00BC7D),
      onPrimary: Color(0xFFFFFFFF),
      primaryContainer: Color(0xFFECFDF5),
      onPrimaryContainer: Color(0xFF00BC7D),
      secondary: Color(0xFF4C82F6),
      onSecondary: Color(0xFFFFFFFF),
      secondaryContainer: Color(0xFFDCDFF8),
      onSecondaryContainer: Color(0xFF2B6DF1),
      surface: Color(0xFFFFFFFF),
      onSurface: Color(0xFF101520),
      onSurfaceVariant: Color(0xFF99A1AF),
      outline: Color(0xFFD9D9D9),
      error: Color(0xFFE53935),
      onError: Color(0xFFFFFFFF),
    ),
    scaffoldBackgroundColor: const Color(0xFFFFFFFF),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFFFFFFF),
      foregroundColor: Color(0xFF101520),
      elevation: 0,
      surfaceTintColor: Colors.transparent,
    ),
    tabBarTheme: const TabBarThemeData(
      labelColor: Color(0xFF101520),
      unselectedLabelColor: Color(0xFF99A1AF),
      indicatorColor: Color(0xFF00BC7D),
      dividerColor: Colors.transparent,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF00BC7D),
      foregroundColor: Color(0xFFFFFFFF),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF00BC7D),
        foregroundColor: const Color(0xFFFFFFFF),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    ),
    switchTheme: SwitchThemeData(
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const Color(0xFF00BC7D);
        }
        return const Color(0xFF00BC7D).withValues(alpha: 0.35);
      }),
      thumbColor: WidgetStateProperty.all(const Color(0xFFFFFFFF)),
      trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
    ),
    listTileTheme: const ListTileThemeData(iconColor: Color(0xFF99A1AF)),
    dividerTheme: const DividerThemeData(color: Color(0xFFF3F4F6)),
    textTheme: _interTextTheme,
    extensions: const [AppColors.light],
  );

  static ThemeData get dark => ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF00BC7D),
      onPrimary: Color(0xFFFFFFFF),
      primaryContainer: Color(0xFF003828),
      onPrimaryContainer: Color(0xFF00BC7D),
      secondary: Color(0xFF4C82F6),
      onSecondary: Color(0xFFFFFFFF),
      secondaryContainer: Color(0xFF1A2540),
      onSecondaryContainer: Color(0xFF7BA8FF),
      surface: Color(0xFF1A2232),
      onSurface: Color(0xFFF3F5F7),
      onSurfaceVariant: Color(0xFF99A1AF),
      outline: Color(0xFF374151),
      error: Color(0xFFFF6B6B),
      onError: Color(0xFFFFFFFF),
    ),
    scaffoldBackgroundColor: const Color(0xFF101622),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1A2232),
      foregroundColor: Color(0xFFF3F5F7),
      elevation: 0,
      surfaceTintColor: Colors.transparent,
    ),
    tabBarTheme: const TabBarThemeData(
      labelColor: Color(0xFFF3F5F7),
      unselectedLabelColor: Color(0xFF99A1AF),
      indicatorColor: Color(0xFF00BC7D),
      dividerColor: Colors.transparent,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF00BC7D),
      foregroundColor: Color(0xFFFFFFFF),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF00BC7D),
        foregroundColor: const Color(0xFFFFFFFF),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    ),
    switchTheme: SwitchThemeData(
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const Color(0xFF00BC7D);
        }
        return const Color(0xFF00BC7D).withValues(alpha: 0.35);
      }),
      thumbColor: WidgetStateProperty.all(const Color(0xFFFFFFFF)),
      trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
    ),
    listTileTheme: const ListTileThemeData(iconColor: Color(0xFF99A1AF)),
    dividerTheme: const DividerThemeData(color: Color(0xFF252E3D)),
    textTheme: _interTextThemeDark,
    extensions: const [AppColors.dark],
  );
}
