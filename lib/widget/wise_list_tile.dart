import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

enum WiseListTileStyle {
  /// Use a title font that's appropriate for a [WiseListTile] in a list.
  list,

  /// Use a title font that's appropriate for a [WiseListTile] that appears in a [Drawer].
  drawer,
}

class WiseListTileTheme extends InheritedTheme {
  /// Creates a list tile theme that controls the color and style parameters for
  const WiseListTileTheme({
    Key? key,
    this.dense = false,
    this.shape,
    this.style = WiseListTileStyle.list,
    this.selectedColor,
    this.iconColor,
    this.textColor,
    this.contentPadding,
    this.tileColor,
    this.selectedTileColor,
    this.enableFeedback,
    this.horizontalTitleGap,
    this.minVerticalPadding,
    this.minLeadingWidth,
    required Widget child,
  }) : super(key: key, child: child);

  /// Creates a list tile theme that controls the color and style parameters for
  /// and merges in the current list tile theme, if any.
  ///
  /// The [child] argument must not be null.
  static Widget merge({
    Key? key,
    bool? dense,
    ShapeBorder? shape,
    WiseListTileStyle? style,
    Color? selectedColor,
    Color? iconColor,
    Color? textColor,
    EdgeInsetsGeometry? contentPadding,
    Color? tileColor,
    Color? selectedTileColor,
    bool? enableFeedback,
    double? horizontalTitleGap,
    double? minVerticalPadding,
    double? minLeadingWidth,
    required Widget child,
  }) {
    assert(child != null);
    return Builder(
      builder: (BuildContext context) {
        final WiseListTileTheme parent = WiseListTileTheme.of(context);
        return WiseListTileTheme(
          key: key,
          dense: dense ?? parent.dense,
          shape: shape ?? parent.shape,
          style: style ?? parent.style,
          selectedColor: selectedColor ?? parent.selectedColor,
          iconColor: iconColor ?? parent.iconColor,
          textColor: textColor ?? parent.textColor,
          contentPadding: contentPadding ?? parent.contentPadding,
          tileColor: tileColor ?? parent.tileColor,
          selectedTileColor: selectedTileColor ?? parent.selectedTileColor,
          enableFeedback: enableFeedback ?? parent.enableFeedback,
          horizontalTitleGap: horizontalTitleGap ?? parent.horizontalTitleGap,
          minVerticalPadding: minVerticalPadding ?? parent.minVerticalPadding,
          minLeadingWidth: minLeadingWidth ?? parent.minLeadingWidth,
          child: child,
        );
      },
    );
  }

  /// If true then [WiseListTile]s will have the vertically dense layout.
  final bool dense;

  /// {@template flutter.material.ListTileMoreCustomizableTheme.shape}
  /// If specified, [shape] defines the [WiseListTile]'s shape.
  /// {@endtemplate}
  final ShapeBorder? shape;

  /// If specified, [style] defines the font used for [WiseListTile] titles.
  final WiseListTileStyle style;

  /// If specified, the color used for icons and text when a [WiseListTile] is selected.
  final Color? selectedColor;

  /// If specified, the icon color used for enabled [WiseListTile]s that are not selected.
  final Color? iconColor;

  /// If specified, the text color used for enabled [WiseListTile]s that are not selected.
  final Color? textColor;

  /// The tile's internal padding.
  ///
  /// Insets a [WiseListTile]'s contents: its [WiseListTile.leading], [WiseListTile.title],
  /// [WiseListTile.subtitle], and [WiseListTile.trailing] widgets.
  final EdgeInsetsGeometry? contentPadding;

  /// If specified, defines the background color for `ListTileMoreCustomizable` when
  /// [WiseListTile.selected] is false.
  ///
  /// If [WiseListTile.tileColor] is provided, [tileColor] is ignored.
  final Color? tileColor;

  /// If specified, defines the background color for `ListTileMoreCustomizable` when
  /// [WiseListTile.selected] is true.
  ///
  /// If [WiseListTile.selectedTileColor] is provided, [selectedTileColor] is ignored.
  final Color? selectedTileColor;

  /// The horizontal gap between the titles and the leading/trailing widgets.
  ///
  /// If specified, overrides the default value of [WiseListTile.horizontalTitleGap].
  final double? horizontalTitleGap;

  /// The minimum padding on the top and bottom of the title and subtitle widgets.
  ///
  /// If specified, overrides the default value of [WiseListTile.minVerticalPadding].
  final double? minVerticalPadding;

  /// The minimum width allocated for the [WiseListTile.leading] widget.
  ///
  /// If specified, overrides the default value of [WiseListTile.minLeadingWidth].
  final double? minLeadingWidth;

  /// If specified, defines the feedback property for `ListTileMoreCustomizable`.
  ///
  /// If [WiseListTile.enableFeedback] is provided, [enableFeedback] is ignored.
  final bool? enableFeedback;

  /// The closest instance of this class that encloses the given context.
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// ListTileMoreCustomizableTheme theme = ListTileMoreCustomizableTheme.of(context);
  /// ```
  static WiseListTileTheme of(BuildContext context) {
    final WiseListTileTheme? result =
        context.dependOnInheritedWidgetOfExactType<WiseListTileTheme>();
    return result ?? const WiseListTileTheme(child: SizedBox());
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return WiseListTileTheme(
      dense: dense,
      shape: shape,
      style: style,
      selectedColor: selectedColor,
      iconColor: iconColor,
      textColor: textColor,
      contentPadding: contentPadding,
      tileColor: tileColor,
      selectedTileColor: selectedTileColor,
      enableFeedback: enableFeedback,
      horizontalTitleGap: horizontalTitleGap,
      minVerticalPadding: minVerticalPadding,
      minLeadingWidth: minLeadingWidth,
      child: child,
    );
  }

  @override
  bool updateShouldNotify(WiseListTileTheme oldWidget) {
    return dense != oldWidget.dense ||
        shape != oldWidget.shape ||
        style != oldWidget.style ||
        selectedColor != oldWidget.selectedColor ||
        iconColor != oldWidget.iconColor ||
        textColor != oldWidget.textColor ||
        contentPadding != oldWidget.contentPadding ||
        tileColor != oldWidget.tileColor ||
        selectedTileColor != oldWidget.selectedTileColor ||
        enableFeedback != oldWidget.enableFeedback ||
        horizontalTitleGap != oldWidget.horizontalTitleGap ||
        minVerticalPadding != oldWidget.minVerticalPadding ||
        minLeadingWidth != oldWidget.minLeadingWidth;
  }
}

/// Where to place the control in widgets that use [ListTileMoreCustomizable] to position a
/// control next to a label.
///
/// See also:
///
///  * [CheckboxListTile], which combines a [WiseListTile] with a [Checkbox].
///  * [RadioListTile], which combines a [WiseListTile] with a [Radio] button.
///  * [SwitchListTile], which combines a [ListTile] with a [Switch].
///  * [ExpansionTile], which combines a [ListTile] with a button that expands
///    or collapses the tile to reveal or hide the children.
enum WiseListTileControlAffinity {
  /// Position the control on the leading edge, and the secondary widget, if
  /// any, on the trailing edge.
  leading,

  /// Position the control on the trailing edge, and the secondary widget, if
  /// any, on the leading edge.
  trailing,

  /// Position the control relative to the text in the fashion that is typical
  /// for the current platform, and place the secondary widget on the opposite
  /// side.
  platform,
}

class WiseListTile extends StatefulWidget {
  /// Creates a list tile.
  ///
  /// If [isThreeLine] is true, then [subtitle] must not be null.
  ///
  /// Requires one of its ancestors to be a [Material] widget.
  const WiseListTile({
    Key? key,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.isThreeLine = false,
    this.dense,
    this.visualDensity,
    this.shape,
    this.contentPadding,
    this.enabled = true,
    this.onTap,
    this.onLongPress,
    this.mouseCursor,
    this.selected = false,
    this.focusColor,
    this.hoverColor,
    this.focusNode,
    this.autofocus = false,
    this.tileColor,
    this.selectedTileColor,
    this.enableFeedback,
    this.horizontalTitleGap,
    this.minVerticalPadding,
    this.minLeadingWidth,
  })  : assert(isThreeLine != null),
        assert(enabled != null),
        assert(selected != null),
        assert(autofocus != null),
        assert(!isThreeLine || subtitle != null),
        super(key: key);

  /// A widget to display before the title.
  ///
  /// Typically an [Icon] or a [CircleAvatar] widget.
  final Widget? leading;

  /// The primary content of the list tile.
  ///
  /// Typically a [Text] widget.
  ///
  /// This should not wrap. To enforce the single line limit, use
  /// [Text.maxLines].
  final Widget? title;

  /// Additional content displayed below the title.
  ///
  /// Typically a [Text] widget.
  ///
  /// If [isThreeLine] is false, this should not wrap.
  ///
  /// If [isThreeLine] is true, this should be configured to take a maximum of
  /// two lines. For example, you can use [Text.maxLines] to enforce the number
  /// of lines.
  ///
  /// The subtitle's default [TextStyle] depends on [TextTheme.bodyText2] except
  /// [TextStyle.color]. The [TextStyle.color] depends on the value of [enabled]
  /// and [selected].
  ///
  /// When [enabled] is false, the text color is set to [ThemeData.disabledColor].
  ///
  /// When [selected] is false, the text color is set to [WiseListTile.textColor]
  /// if it's not null and to [TextTheme.caption]'s color if [WiseListTile.textColor]
  /// is null.
  final Widget? subtitle;

  /// A widget to display after the title.
  ///
  /// Typically an [Icon] widget.
  ///
  /// To show right-aligned metadata (assuming left-to-right reading order;
  /// left-aligned for right-to-left reading order), consider using a [Row] with
  /// [CrossAxisAlignment.baseline] alignment whose first item is [Expanded] and
  /// whose second child is the metadata text, instead of using the [trailing]
  /// property.
  final Widget? trailing;

  /// Whether this list tile is intended to display three lines of text.
  ///
  /// If true, then [subtitle] must be non-null (since it is expected to give
  /// the second and third lines of text).
  ///
  /// If false, the list tile is treated as having one line if the subtitle is
  /// null and treated as having two lines if the subtitle is non-null.
  ///
  /// When using a [Text] widget for [title] and [subtitle], you can enforce
  /// line limits using [Text.maxLines].
  final bool isThreeLine;

  /// Whether this list tile is part of a vertically dense list.
  ///
  /// If this property is null then its value is based on [WiseListTile.dense].
  ///
  /// Dense list tiles default to a smaller height.
  final bool? dense;

  /// Defines how compact the list tile's layout will be.
  ///
  /// {@macro flutter.material.themedata.visualDensity}
  ///
  /// See also:
  ///
  ///  * [ThemeData.visualDensity], which specifies the [visualDensity] for all
  ///    widgets within a [Theme].
  final VisualDensity? visualDensity;

  /// The tile's shape.
  ///
  /// Defines the tile's [InkWell.customBorder] and [Ink.decoration] shape.
  ///
  /// If this property is null then [WiseListTile.shape] is used.
  /// If that's null then a rectangular [Border] will be used.
  final ShapeBorder? shape;

  /// The tile's internal padding.
  ///
  /// Insets a [WiseListTile]'s contents: its [leading], [title], [subtitle],
  /// and [trailing] widgets.
  ///
  /// If null, `EdgeInsets.symmetric(horizontal: 16.0)` is used.
  final EdgeInsetsGeometry? contentPadding;

  /// Whether this list tile is interactive.
  ///
  /// If false, this list tile is styled with the disabled color from the
  /// current [Theme] and the [onTap] and [onLongPress] callbacks are
  /// inoperative.
  final bool enabled;

  /// Called when the user taps this list tile.
  /// The details information is recorded when InkWell's onTapDown occurred.
  ///
  /// Inoperative if [enabled] is false.
  final GestureTapDownCallback? onTap;

  /// Called when the user long-presses on this list tile.
  /// The details information is recorded when InkWell's onTapDown occurred.
  ///
  /// Inoperative if [enabled] is false.
  final GestureTapDownCallback? onLongPress;

  /// The cursor for a mouse pointer when it enters or is hovering over the
  /// widget.
  ///
  /// If [mouseCursor] is a [MaterialStateProperty<MouseCursor>],
  /// [MaterialStateProperty.resolve] is used for the following [MaterialState]s:
  ///
  ///  * [MaterialState.selected].
  ///  * [MaterialState.disabled].
  ///
  /// If this property is null, [MaterialStateMouseCursor.clickable] will be used.
  final MouseCursor? mouseCursor;

  /// If this tile is also [enabled] then icons and text are rendered with the same color.
  ///
  /// By default the selected color is the theme's primary color. The selected color
  /// can be overridden with a [WiseListTileTheme].
  final bool selected;

  /// The color for the tile's [Material] when it has the input focus.
  final Color? focusColor;

  /// The color for the tile's [Material] when a pointer is hovering over it.
  final Color? hoverColor;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  /// {@template flutter.material.ListTile.tileColor}
  /// Defines the background color of `ListTile` when [selected] is false.
  ///
  /// When the value is null, the `tileColor` is set to [WiseListTile.tileColor]
  /// if it's not null and to [Colors.transparent] if it's null.
  /// {@endtemplate}
  final Color? tileColor;

  /// Defines the background color of `ListTile` when [selected] is true.
  ///
  /// When the value if null, the `selectedTileColor` is set to [WiseListTileTheme.selectedTileColor]
  /// if it's not null and to [Colors.transparent] if it's null.
  final Color? selectedTileColor;

  /// Whether detected gestures should provide acoustic and/or haptic feedback.
  ///
  /// For example, on Android a tap will produce a clicking sound and a
  /// long-press will produce a short vibration, when feedback is enabled.
  ///
  /// See also:
  ///
  ///  * [Feedback] for providing platform-specific feedback to certain actions.
  final bool? enableFeedback;

  /// The horizontal gap between the titles and the leading/trailing widgets.
  ///
  /// If null, then the value of [WiseListTileTheme.horizontalTitleGap] is used. If
  /// that is also null, then a default value of 16 is used.
  final double? horizontalTitleGap;

  /// The minimum padding on the top and bottom of the title and subtitle widgets.
  ///
  /// If null, then the value of [WiseListTileTheme.minVerticalPadding] is used. If
  /// that is also null, then a default value of 4 is used.
  final double? minVerticalPadding;

  /// The minimum width allocated for the [WiseListTile.leading] widget.
  ///
  /// If null, then the value of [WiseListTileTheme.minLeadingWidth] is used. If
  /// that is also null, then a default value of 40 is used.
  final double? minLeadingWidth;

  /// Add a one pixel border in between each tile. If color isn't specified the
  /// [ThemeData.dividerColor] of the context's [Theme] is used.
  ///
  /// See also:
  ///
  ///  * [Divider], which you can use to obtain this effect manually.
  static Iterable<Widget> divideTiles(
      {BuildContext? context,
      required Iterable<Widget> tiles,
      Color? color}) sync* {
    assert(tiles != null);
    assert(color != null || context != null);

    final Iterator<Widget> iterator = tiles.iterator;
    final bool hasNext = iterator.moveNext();

    if (!hasNext) return;

    final Decoration decoration = BoxDecoration(
      border: Border(
        bottom: Divider.createBorderSide(context, color: color),
      ),
    );

    Widget tile = iterator.current;
    while (iterator.moveNext()) {
      yield DecoratedBox(
        position: DecorationPosition.foreground,
        decoration: decoration,
        child: tile,
      );
      tile = iterator.current;
    }
    if (hasNext) yield tile;
  }

  @override
  _WiseListTileState createState() => _WiseListTileState();
}

class _WiseListTileState extends State<WiseListTile> {
  late TapDownDetails tapDownDetails;

  Color? _iconColor(ThemeData theme, WiseListTileTheme? tileTheme) {
    if (!widget.enabled) return theme.disabledColor;

    if (widget.selected && tileTheme?.selectedColor != null)
      return tileTheme!.selectedColor;

    if (!widget.selected && tileTheme?.iconColor != null)
      return tileTheme!.iconColor;

    switch (theme.brightness) {
      case Brightness.light:
        // For the sake of backwards compatibility, the default for unselected
        // tiles is Colors.black45 rather than colorScheme.onSurface.withAlpha(0x73).
        return widget.selected ? theme.colorScheme.primary : Colors.black45;
      case Brightness.dark:
        return widget.selected
            ? theme.colorScheme.primary
            : null; // null - use current icon theme color
    }
  }

  Color? _textColor(
      ThemeData theme, WiseListTileTheme? tileTheme, Color? defaultColor) {
    if (!widget.enabled) return theme.disabledColor;

    if (widget.selected && tileTheme?.selectedColor != null)
      return tileTheme!.selectedColor;

    if (!widget.selected && tileTheme?.textColor != null)
      return tileTheme!.textColor;

    if (widget.selected) return theme.colorScheme.primary;

    return defaultColor;
  }

  bool _isDenseLayout(WiseListTileTheme? tileTheme) {
    return widget.dense ?? tileTheme?.dense ?? false;
  }

  TextStyle _titleTextStyle(ThemeData theme, WiseListTileTheme? tileTheme) {
    final TextStyle style;
    if (tileTheme != null) {
      switch (tileTheme.style) {
        case WiseListTileStyle.drawer:
          style = theme.textTheme.bodyText1!;
          break;
        case WiseListTileStyle.list:
          style = theme.textTheme.subtitle1!;
          break;
      }
    } else {
      style = theme.textTheme.subtitle1!;
    }
    final Color? color = _textColor(theme, tileTheme, style.color);
    return _isDenseLayout(tileTheme)
        ? style.copyWith(fontSize: 13.0, color: color)
        : style.copyWith(color: color);
  }

  TextStyle _subtitleTextStyle(ThemeData theme, WiseListTileTheme? tileTheme) {
    final TextStyle style = theme.textTheme.bodyText2!;
    final Color? color =
        _textColor(theme, tileTheme, theme.textTheme.caption!.color);
    return _isDenseLayout(tileTheme)
        ? style.copyWith(color: color, fontSize: 12.0)
        : style.copyWith(color: color);
  }

  TextStyle _trailingAndLeadingTextStyle(
      ThemeData theme, WiseListTileTheme? tileTheme) {
    final TextStyle style = theme.textTheme.bodyText2!;
    final Color? color = _textColor(theme, tileTheme, style.color);
    return style.copyWith(color: color);
  }

  Color _tileBackgroundColor(WiseListTileTheme? tileTheme) {
    if (!widget.selected) {
      if (widget.tileColor != null) return widget.tileColor!;
      if (tileTheme?.tileColor != null) return tileTheme!.tileColor!;
    }

    if (widget.selected) {
      if (widget.selectedTileColor != null) return widget.selectedTileColor!;
      if (tileTheme?.selectedTileColor != null)
        return tileTheme!.selectedTileColor!;
    }

    return Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    final ThemeData theme = Theme.of(context);
    final WiseListTileTheme tileTheme = WiseListTileTheme.of(context);

    IconThemeData? iconThemeData;
    TextStyle? leadingAndTrailingTextStyle;
    if (widget.leading != null || widget.trailing != null) {
      iconThemeData = IconThemeData(color: _iconColor(theme, tileTheme));
      leadingAndTrailingTextStyle =
          _trailingAndLeadingTextStyle(theme, tileTheme);
    }

    Widget? leadingIcon;
    if (widget.leading != null) {
      leadingIcon = AnimatedDefaultTextStyle(
        style: leadingAndTrailingTextStyle!,
        duration: kThemeChangeDuration,
        child: IconTheme.merge(
          data: iconThemeData!,
          child: widget.leading!,
        ),
      );
    }

    final TextStyle titleStyle = _titleTextStyle(theme, tileTheme);
    final Widget titleText = AnimatedDefaultTextStyle(
      style: titleStyle,
      duration: kThemeChangeDuration,
      child: widget.title ?? const SizedBox(),
    );

    Widget? subtitleText;
    TextStyle? subtitleStyle;
    if (widget.subtitle != null) {
      subtitleStyle = _subtitleTextStyle(theme, tileTheme);
      subtitleText = AnimatedDefaultTextStyle(
        style: subtitleStyle,
        duration: kThemeChangeDuration,
        child: widget.subtitle!,
      );
    }

    Widget? trailingIcon;
    if (widget.trailing != null) {
      trailingIcon = AnimatedDefaultTextStyle(
        style: leadingAndTrailingTextStyle!,
        duration: kThemeChangeDuration,
        child: IconTheme.merge(
          data: iconThemeData!,
          child: widget.trailing!,
        ),
      );
    }

    const EdgeInsets _defaultContentPadding =
        EdgeInsets.symmetric(horizontal: 16.0);
    final TextDirection textDirection = Directionality.of(context);
    final EdgeInsets resolvedContentPadding =
        widget.contentPadding?.resolve(textDirection) ??
            tileTheme.contentPadding?.resolve(textDirection) ??
            _defaultContentPadding;

    final MouseCursor resolvedMouseCursor =
        MaterialStateProperty.resolveAs<MouseCursor>(
      widget.mouseCursor ?? MaterialStateMouseCursor.clickable,
      <MaterialState>{
        if (!widget.enabled ||
            (widget.onTap == null && widget.onLongPress == null))
          MaterialState.disabled,
        if (widget.selected) MaterialState.selected,
      },
    );

    return InkWell(
      customBorder: widget.shape ?? tileTheme.shape,
      onTap: widget.enabled && widget.onTap != null ? toOnTap : null,
      onLongPress:
          widget.enabled && widget.onLongPress != null ? toOnLongPress : null,
      mouseCursor: resolvedMouseCursor,
      onTapDown: widget.enabled ? recordTapDownDetails : null,
      canRequestFocus: widget.enabled,
      focusNode: widget.focusNode,
      focusColor: widget.focusColor,
      hoverColor: widget.hoverColor,
      autofocus: widget.autofocus,
      enableFeedback: widget.enableFeedback ?? tileTheme.enableFeedback ?? true,
      child: Semantics(
        selected: widget.selected,
        enabled: widget.enabled,
        child: Ink(
          decoration: ShapeDecoration(
            shape: widget.shape ?? tileTheme.shape ?? const Border(),
            color: _tileBackgroundColor(tileTheme),
          ),
          child: SafeArea(
            top: false,
            bottom: false,
            minimum: resolvedContentPadding,
            child: _WiseListTile(
              leading: leadingIcon,
              title: titleText,
              subtitle: subtitleText,
              trailing: trailingIcon,
              isDense: _isDenseLayout(tileTheme),
              visualDensity: widget.visualDensity ?? theme.visualDensity,
              isThreeLine: widget.isThreeLine,
              textDirection: textDirection,
              titleBaselineType: titleStyle.textBaseline!,
              subtitleBaselineType: subtitleStyle?.textBaseline,
              horizontalTitleGap: widget.horizontalTitleGap ??
                  tileTheme.horizontalTitleGap ??
                  16,
              minVerticalPadding: widget.minVerticalPadding ??
                  tileTheme.minVerticalPadding ??
                  4,
              minLeadingWidth:
                  widget.minLeadingWidth ?? tileTheme.minLeadingWidth ?? 40,
            ),
          ),
        ),
      ),
    );
  }

  toOnTap() {
    widget.onTap!(tapDownDetails);
  }

  toOnLongPress() {
    widget.onLongPress!(tapDownDetails);
  }

  // Records TapDownDetails when the onTapDown event fired.
  recordTapDownDetails(TapDownDetails d) {
    tapDownDetails = d;
  }
}

// Identifies the children of a _ListTileElement.
enum _WiseListTileSlot {
  leading,
  title,
  subtitle,
  trailing,
}

class _WiseListTile extends RenderObjectWidget {
  const _WiseListTile({
    Key? key,
    this.leading,
    required this.title,
    this.subtitle,
    this.trailing,
    required this.isThreeLine,
    required this.isDense,
    required this.visualDensity,
    required this.textDirection,
    required this.titleBaselineType,
    required this.horizontalTitleGap,
    required this.minVerticalPadding,
    required this.minLeadingWidth,
    this.subtitleBaselineType,
  })  : assert(isThreeLine != null),
        assert(isDense != null),
        assert(visualDensity != null),
        assert(textDirection != null),
        assert(titleBaselineType != null),
        assert(horizontalTitleGap != null),
        assert(minVerticalPadding != null),
        assert(minLeadingWidth != null),
        super(key: key);

  final Widget? leading;
  final Widget title;
  final Widget? subtitle;
  final Widget? trailing;
  final bool isThreeLine;
  final bool isDense;
  final VisualDensity visualDensity;
  final TextDirection textDirection;
  final TextBaseline titleBaselineType;
  final TextBaseline? subtitleBaselineType;
  final double horizontalTitleGap;
  final double minVerticalPadding;
  final double minLeadingWidth;

  @override
  _WiseListTileElement createElement() => _WiseListTileElement(this);

  @override
  _RenderWiseListTile createRenderObject(BuildContext context) {
    return _RenderWiseListTile(
      isThreeLine: isThreeLine,
      isDense: isDense,
      visualDensity: visualDensity,
      textDirection: textDirection,
      titleBaselineType: titleBaselineType,
      subtitleBaselineType: subtitleBaselineType,
      horizontalTitleGap: horizontalTitleGap,
      minVerticalPadding: minVerticalPadding,
      minLeadingWidth: minLeadingWidth,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, _RenderWiseListTile renderObject) {
    renderObject
      ..isThreeLine = isThreeLine
      ..isDense = isDense
      ..visualDensity = visualDensity
      ..textDirection = textDirection
      ..titleBaselineType = titleBaselineType
      ..subtitleBaselineType = subtitleBaselineType
      ..horizontalTitleGap = horizontalTitleGap
      ..minLeadingWidth = minLeadingWidth
      ..minVerticalPadding = minVerticalPadding;
  }
}

class _WiseListTileElement extends RenderObjectElement {
  _WiseListTileElement(_WiseListTile widget) : super(widget);

  final Map<_WiseListTileSlot, Element> slotToChild =
      <_WiseListTileSlot, Element>{};

  @override
  _WiseListTile get widget => super.widget as _WiseListTile;

  @override
  _RenderWiseListTile get renderObject =>
      super.renderObject as _RenderWiseListTile;

  @override
  void visitChildren(ElementVisitor visitor) {
    slotToChild.values.forEach(visitor);
  }

  @override
  void forgetChild(Element child) {
    assert(slotToChild.containsValue(child));
    assert(child.slot is _WiseListTileSlot);
    assert(slotToChild.containsKey(child.slot));
    slotToChild.remove(child.slot);
    super.forgetChild(child);
  }

  void _mountChild(Widget? widget, _WiseListTileSlot slot) {
    final Element? oldChild = slotToChild[slot];
    final Element? newChild = updateChild(oldChild, widget, slot);
    if (oldChild != null) {
      slotToChild.remove(slot);
    }
    if (newChild != null) {
      slotToChild[slot] = newChild;
    }
  }

  @override
  void mount(Element? parent, Object? newSlot) {
    super.mount(parent, newSlot);
    _mountChild(widget.leading, _WiseListTileSlot.leading);
    _mountChild(widget.title, _WiseListTileSlot.title);
    _mountChild(widget.subtitle, _WiseListTileSlot.subtitle);
    _mountChild(widget.trailing, _WiseListTileSlot.trailing);
  }

  void _updateChild(Widget? widget, _WiseListTileSlot slot) {
    final Element? oldChild = slotToChild[slot];
    final Element? newChild = updateChild(oldChild, widget, slot);
    if (oldChild != null) {
      slotToChild.remove(slot);
    }
    if (newChild != null) {
      slotToChild[slot] = newChild;
    }
  }

  @override
  void update(_WiseListTile newWidget) {
    super.update(newWidget);
    assert(widget == newWidget);
    _updateChild(widget.leading, _WiseListTileSlot.leading);
    _updateChild(widget.title, _WiseListTileSlot.title);
    _updateChild(widget.subtitle, _WiseListTileSlot.subtitle);
    _updateChild(widget.trailing, _WiseListTileSlot.trailing);
  }

  void _updateRenderObject(RenderBox? child, _WiseListTileSlot slot) {
    switch (slot) {
      case _WiseListTileSlot.leading:
        renderObject.leading = child;
        break;
      case _WiseListTileSlot.title:
        renderObject.title = child;
        break;
      case _WiseListTileSlot.subtitle:
        renderObject.subtitle = child;
        break;
      case _WiseListTileSlot.trailing:
        renderObject.trailing = child;
        break;
    }
  }

  @override
  void insertRenderObjectChild(RenderObject child, _WiseListTileSlot slot) {
    assert(child is RenderBox);
    _updateRenderObject(child as RenderBox, slot);
    assert(renderObject.children.keys.contains(slot));
  }

  @override
  void removeRenderObjectChild(RenderObject child, _WiseListTileSlot slot) {
    assert(child is RenderBox);
    assert(renderObject.children[slot] == child);
    _updateRenderObject(null, slot);
    assert(!renderObject.children.keys.contains(slot));
  }

  @override
  void moveRenderObjectChild(
      RenderObject child, Object? oldSlot, Object? newSlot) {
    assert(false, 'not reachable');
  }
}

class _RenderWiseListTile extends RenderBox {
  _RenderWiseListTile({
    required bool isDense,
    required VisualDensity visualDensity,
    required bool isThreeLine,
    required TextDirection textDirection,
    required TextBaseline titleBaselineType,
    TextBaseline? subtitleBaselineType,
    required double horizontalTitleGap,
    required double minVerticalPadding,
    required double minLeadingWidth,
  })  : assert(isDense != null),
        assert(visualDensity != null),
        assert(isThreeLine != null),
        assert(textDirection != null),
        assert(titleBaselineType != null),
        assert(horizontalTitleGap != null),
        assert(minVerticalPadding != null),
        assert(minLeadingWidth != null),
        _isDense = isDense,
        _visualDensity = visualDensity,
        _isThreeLine = isThreeLine,
        _textDirection = textDirection,
        _titleBaselineType = titleBaselineType,
        _subtitleBaselineType = subtitleBaselineType,
        _horizontalTitleGap = horizontalTitleGap,
        _minVerticalPadding = minVerticalPadding,
        _minLeadingWidth = minLeadingWidth;

  final Map<_WiseListTileSlot, RenderBox> children =
      <_WiseListTileSlot, RenderBox>{};

  RenderBox? _updateChild(
      RenderBox? oldChild, RenderBox? newChild, _WiseListTileSlot slot) {
    if (oldChild != null) {
      dropChild(oldChild);
      children.remove(slot);
    }
    if (newChild != null) {
      children[slot] = newChild;
      adoptChild(newChild);
    }
    return newChild;
  }

  RenderBox? _leading;

  RenderBox? get leading => _leading;

  set leading(RenderBox? value) {
    _leading = _updateChild(_leading, value, _WiseListTileSlot.leading);
  }

  RenderBox? _title;

  RenderBox? get title => _title;

  set title(RenderBox? value) {
    _title = _updateChild(_title, value, _WiseListTileSlot.title);
  }

  RenderBox? _subtitle;

  RenderBox? get subtitle => _subtitle;

  set subtitle(RenderBox? value) {
    _subtitle = _updateChild(_subtitle, value, _WiseListTileSlot.subtitle);
  }

  RenderBox? _trailing;

  RenderBox? get trailing => _trailing;

  set trailing(RenderBox? value) {
    _trailing = _updateChild(_trailing, value, _WiseListTileSlot.trailing);
  }

  // The returned list is ordered for hit testing.
  Iterable<RenderBox> get _children sync* {
    if (leading != null) yield leading!;
    if (title != null) yield title!;
    if (subtitle != null) yield subtitle!;
    if (trailing != null) yield trailing!;
  }

  bool get isDense => _isDense;
  bool _isDense;

  set isDense(bool value) {
    assert(value != null);
    if (_isDense == value) return;
    _isDense = value;
    markNeedsLayout();
  }

  VisualDensity get visualDensity => _visualDensity;
  VisualDensity _visualDensity;

  set visualDensity(VisualDensity value) {
    assert(value != null);
    if (_visualDensity == value) return;
    _visualDensity = value;
    markNeedsLayout();
  }

  bool get isThreeLine => _isThreeLine;
  bool _isThreeLine;

  set isThreeLine(bool value) {
    assert(value != null);
    if (_isThreeLine == value) return;
    _isThreeLine = value;
    markNeedsLayout();
  }

  TextDirection get textDirection => _textDirection;
  TextDirection _textDirection;

  set textDirection(TextDirection value) {
    assert(value != null);
    if (_textDirection == value) return;
    _textDirection = value;
    markNeedsLayout();
  }

  TextBaseline get titleBaselineType => _titleBaselineType;
  TextBaseline _titleBaselineType;

  set titleBaselineType(TextBaseline value) {
    assert(value != null);
    if (_titleBaselineType == value) return;
    _titleBaselineType = value;
    markNeedsLayout();
  }

  TextBaseline? get subtitleBaselineType => _subtitleBaselineType;
  TextBaseline? _subtitleBaselineType;

  set subtitleBaselineType(TextBaseline? value) {
    if (_subtitleBaselineType == value) return;
    _subtitleBaselineType = value;
    markNeedsLayout();
  }

  double get horizontalTitleGap => _horizontalTitleGap;
  double _horizontalTitleGap;

  double get _effectiveHorizontalTitleGap =>
      _horizontalTitleGap + visualDensity.horizontal * 2.0;

  set horizontalTitleGap(double value) {
    assert(value != null);
    if (_horizontalTitleGap == value) return;
    _horizontalTitleGap = value;
    markNeedsLayout();
  }

  double get minVerticalPadding => _minVerticalPadding;
  double _minVerticalPadding;

  set minVerticalPadding(double value) {
    assert(value != null);
    if (_minVerticalPadding == value) return;
    _minVerticalPadding = value;
    markNeedsLayout();
  }

  double get minLeadingWidth => _minLeadingWidth;
  double _minLeadingWidth;

  set minLeadingWidth(double value) {
    assert(value != null);
    if (_minLeadingWidth == value) return;
    _minLeadingWidth = value;
    markNeedsLayout();
  }

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    for (final RenderBox child in _children) child.attach(owner);
  }

  @override
  void detach() {
    super.detach();
    for (final RenderBox child in _children) child.detach();
  }

  @override
  void redepthChildren() {
    _children.forEach(redepthChild);
  }

  @override
  void visitChildren(RenderObjectVisitor visitor) {
    _children.forEach(visitor);
  }

  @override
  List<DiagnosticsNode> debugDescribeChildren() {
    final List<DiagnosticsNode> value = <DiagnosticsNode>[];
    void add(RenderBox? child, String name) {
      if (child != null) value.add(child.toDiagnosticsNode(name: name));
    }

    add(leading, 'leading');
    add(title, 'title');
    add(subtitle, 'subtitle');
    add(trailing, 'trailing');
    return value;
  }

  @override
  bool get sizedByParent => false;

  static double _minWidth(RenderBox? box, double height) {
    return box == null ? 0.0 : box.getMinIntrinsicWidth(height);
  }

  static double _maxWidth(RenderBox? box, double height) {
    return box == null ? 0.0 : box.getMaxIntrinsicWidth(height);
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    final double leadingWidth = leading != null
        ? math.max(leading!.getMinIntrinsicWidth(height), _minLeadingWidth) +
            _effectiveHorizontalTitleGap
        : 0.0;
    return leadingWidth +
        math.max(_minWidth(title, height), _minWidth(subtitle, height)) +
        _maxWidth(trailing, height);
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    final double leadingWidth = leading != null
        ? math.max(leading!.getMaxIntrinsicWidth(height), _minLeadingWidth) +
            _effectiveHorizontalTitleGap
        : 0.0;
    return leadingWidth +
        math.max(_maxWidth(title, height), _maxWidth(subtitle, height)) +
        _maxWidth(trailing, height);
  }

  double get _defaultTileHeight {
    final bool hasSubtitle = subtitle != null;
    final bool isTwoLine = !isThreeLine && hasSubtitle;
    final bool isOneLine = !isThreeLine && !hasSubtitle;

    final Offset baseDensity = visualDensity.baseSizeAdjustment;
    if (isOneLine) return (isDense ? 48.0 : 56.0) + baseDensity.dy;
    if (isTwoLine) return (isDense ? 64.0 : 72.0) + baseDensity.dy;
    return (isDense ? 76.0 : 88.0) + baseDensity.dy;
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    return math.max(
      _defaultTileHeight,
      title!.getMinIntrinsicHeight(width) +
          (subtitle?.getMinIntrinsicHeight(width) ?? 0.0),
    );
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    return computeMinIntrinsicHeight(width);
  }

  @override
  double computeDistanceToActualBaseline(TextBaseline baseline) {
    assert(title != null);
    final BoxParentData parentData = title!.parentData! as BoxParentData;
    return parentData.offset.dy + title!.getDistanceToActualBaseline(baseline)!;
  }

  static double? _boxBaseline(RenderBox box, TextBaseline baseline) {
    return box.getDistanceToBaseline(baseline);
  }

  static Size _layoutBox(RenderBox? box, BoxConstraints constraints) {
    if (box == null) return Size.zero;
    box.layout(constraints, parentUsesSize: true);
    return box.size;
  }

  static void _positionBox(RenderBox box, Offset offset) {
    final BoxParentData parentData = box.parentData! as BoxParentData;
    parentData.offset = offset;
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    assert(debugCannotComputeDryLayout(
      reason:
          'Layout requires baseline metrics, which are only available after a full layout.',
    ));
    return Size.zero;
  }

  // All of the dimensions below were taken from the Material Design spec:
  // https://material.io/design/components/lists.html#specs
  @override
  void performLayout() {
    final BoxConstraints constraints = this.constraints;
    final bool hasLeading = leading != null;
    final bool hasSubtitle = subtitle != null;
    final bool hasTrailing = trailing != null;
    final bool isTwoLine = !isThreeLine && hasSubtitle;
    final bool isOneLine = !isThreeLine && !hasSubtitle;
    final Offset densityAdjustment = visualDensity.baseSizeAdjustment;

    final BoxConstraints maxIconHeightConstraint = BoxConstraints(
      // One-line trailing and leading widget heights do not follow
      // Material specifications, but this sizing is required to adhere
      // to accessibility requirements for smallest tappable widget.
      // Two- and three-line trailing widget heights are constrained
      // properly according to the Material spec.
      maxHeight: (isDense ? 48.0 : 56.0) + densityAdjustment.dy,
    );
    final BoxConstraints looseConstraints = constraints.loosen();
    final BoxConstraints iconConstraints =
        looseConstraints.enforce(maxIconHeightConstraint);

    final double tileWidth = looseConstraints.maxWidth;
    final Size leadingSize = _layoutBox(leading, iconConstraints);
    final Size trailingSize = _layoutBox(trailing, iconConstraints);
    assert(
      tileWidth != leadingSize.width || tileWidth == 0.0,
      'Leading widget consumes entire tile width. Please use a sized widget, '
      'or consider replacing ListTile with a custom widget '
      '(see https://api.flutter.dev/flutter/material/ListTile-class.html#material.ListTile.4)',
    );
    assert(
      tileWidth != trailingSize.width || tileWidth == 0.0,
      'Trailing widget consumes entire tile width. Please use a sized widget, '
      'or consider replacing ListTile with a custom widget '
      '(see https://api.flutter.dev/flutter/material/ListTile-class.html#material.ListTile.4)',
    );

    final double titleStart = hasLeading
        ? math.max(_minLeadingWidth, leadingSize.width) +
            _effectiveHorizontalTitleGap
        : 0.0;
    final double adjustedTrailingWidth = hasTrailing
        ? math.max(trailingSize.width + _effectiveHorizontalTitleGap, 32.0)
        : 0.0;
    final BoxConstraints textConstraints = looseConstraints.tighten(
      width: tileWidth - titleStart - adjustedTrailingWidth,
    );
    final Size titleSize = _layoutBox(title, textConstraints);
    final Size subtitleSize = _layoutBox(subtitle, textConstraints);

    double? titleBaseline;
    double? subtitleBaseline;
    if (isTwoLine) {
      titleBaseline = isDense ? 28.0 : 32.0;
      subtitleBaseline = isDense ? 48.0 : 52.0;
    } else if (isThreeLine) {
      titleBaseline = isDense ? 22.0 : 28.0;
      subtitleBaseline = isDense ? 42.0 : 48.0;
    } else {
      assert(isOneLine);
    }

    final double defaultTileHeight = _defaultTileHeight;

    double tileHeight;
    double titleY;
    double? subtitleY;
    if (!hasSubtitle) {
      tileHeight = math.max(
          defaultTileHeight, titleSize.height + 2.0 * _minVerticalPadding);
      titleY = (tileHeight - titleSize.height) / 2.0;
    } else {
      assert(subtitleBaselineType != null);
      titleY = titleBaseline! - _boxBaseline(title!, titleBaselineType)!;
      subtitleY = subtitleBaseline! -
          _boxBaseline(subtitle!, subtitleBaselineType!)! +
          visualDensity.vertical * 2.0;
      tileHeight = defaultTileHeight;

      // If the title and subtitle overlap, move the title upwards by half
      // the overlap and the subtitle down by the same amount, and adjust
      // tileHeight so that both titles fit.
      final double titleOverlap = titleY + titleSize.height - subtitleY;
      if (titleOverlap > 0.0) {
        titleY -= titleOverlap / 2.0;
        subtitleY += titleOverlap / 2.0;
      }

      // If the title or subtitle overflow tileHeight then punt: title
      // and subtitle are arranged in a column, tileHeight = column height plus
      // _minVerticalPadding on top and bottom.
      if (titleY < _minVerticalPadding ||
          (subtitleY + subtitleSize.height + _minVerticalPadding) >
              tileHeight) {
        tileHeight =
            titleSize.height + subtitleSize.height + 2.0 * _minVerticalPadding;
        titleY = _minVerticalPadding;
        subtitleY = titleSize.height + _minVerticalPadding;
      }
    }

    // This attempts to implement the redlines for the vertical position of the
    // leading and trailing icons on the spec page:
    //   https://material.io/design/components/lists.html#specs
    // The interpretation for these redlines is as follows:
    //  - For large tiles (> 72dp), both leading and trailing controls should be
    //    a fixed distance from top. As per guidelines this is set to 16dp.
    //  - For smaller tiles, trailing should always be centered. Leading can be
    //    centered or closer to the top. It should never be further than 16dp
    //    to the top.
    final double leadingY;
    final double trailingY;
    if (tileHeight > 72.0) {
      leadingY = 16.0;
      trailingY = 16.0;
    } else {
      leadingY = math.min((tileHeight - leadingSize.height) / 2.0, 16.0);
      trailingY = (tileHeight - trailingSize.height) / 2.0;
    }

    switch (textDirection) {
      case TextDirection.rtl:
        {
          if (hasLeading)
            _positionBox(
                leading!, Offset(tileWidth - leadingSize.width, leadingY));
          _positionBox(title!, Offset(adjustedTrailingWidth, titleY));
          if (hasSubtitle)
            _positionBox(subtitle!, Offset(adjustedTrailingWidth, subtitleY!));
          if (hasTrailing) _positionBox(trailing!, Offset(0.0, trailingY));
          break;
        }
      case TextDirection.ltr:
        {
          if (hasLeading) _positionBox(leading!, Offset(0.0, leadingY));
          _positionBox(title!, Offset(titleStart, titleY));
          if (hasSubtitle)
            _positionBox(subtitle!, Offset(titleStart, subtitleY!));
          if (hasTrailing)
            _positionBox(
                trailing!, Offset(tileWidth - trailingSize.width, trailingY));
          break;
        }
    }

    size = constraints.constrain(Size(tileWidth, tileHeight));
    assert(size.width == constraints.constrainWidth(tileWidth));
    assert(size.height == constraints.constrainHeight(tileHeight));
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    void doPaint(RenderBox? child) {
      if (child != null) {
        final BoxParentData parentData = child.parentData! as BoxParentData;
        context.paintChild(child, parentData.offset + offset);
      }
    }

    doPaint(leading);
    doPaint(title);
    doPaint(subtitle);
    doPaint(trailing);
  }

  @override
  bool hitTestSelf(Offset position) => true;

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    assert(position != null);
    for (final RenderBox child in _children) {
      final BoxParentData parentData = child.parentData! as BoxParentData;
      final bool isHit = result.addWithPaintOffset(
        offset: parentData.offset,
        position: position,
        hitTest: (BoxHitTestResult result, Offset transformed) {
          assert(transformed == position - parentData.offset);
          return child.hitTest(result, position: transformed);
        },
      );
      if (isHit) return true;
    }
    return false;
  }
}
