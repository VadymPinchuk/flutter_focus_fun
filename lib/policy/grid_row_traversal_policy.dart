import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_focus_fun_tv_demo/constants.dart';
import 'package:flutter_focus_fun_tv_demo/scrollable_ensure_alignment.dart'
    show ScrollableX;

/// A custom [FocusTraversalPolicy] for grid layouts that enables
/// intuitive row and column navigation using keyboard or remote controls.
///
/// - Horizontal navigation (left/right) moves within a row.
/// - Vertical navigation (up/down) jumps between rows, focusing the closest item.
class GridRowTraversalPolicy extends ReadingOrderTraversalPolicy {
  /// Compares two offsets by their vertical distance to [target].
  static int _verticalCompare(Offset target, Offset a, Offset b) {
    return (a.dy - target.dy).abs().compareTo((b.dy - target.dy).abs());
  }

  /// Compares two offsets by their horizontal distance to [target].
  static int _horizontalCompare(Offset target, Offset a, Offset b) {
    return (a.dx - target.dx).abs().compareTo((b.dx - target.dx).abs());
  }

  /// Sorts [nodes] by horizontal distance to [target], breaking ties by vertical distance.
  static Iterable<FocusNode> _sortByDistancePreferHorizontal(
    Offset target,
    Iterable<FocusNode> nodes,
  ) {
    final List<FocusNode> sorted = nodes.toList();
    mergeSort<FocusNode>(
      sorted,
      compare: (FocusNode nodeA, FocusNode nodeB) {
        final Offset a = nodeA.rect.center;
        final Offset b = nodeB.rect.center;
        final int horizontal = _horizontalCompare(target, a, b);
        if (horizontal == 0) {
          return _verticalCompare(target, a, b);
        }
        return horizontal;
      },
    );
    return sorted;
  }

  /// Filters and sorts [nodes] horizontally for left/right navigation.
  ///
  /// Only nodes to the left (for left) or right (for right) of [target] are considered.
  Iterable<FocusNode> _sortAndFilterHorizontally(
    TraversalDirection direction,
    Rect target,
    Iterable<FocusNode> nodes,
  ) {
    assert(
      direction == TraversalDirection.left ||
          direction == TraversalDirection.right,
    );
    final Iterable<FocusNode> filtered =
        direction == TraversalDirection.left
            ? nodes.where(
              (FocusNode node) =>
                  node.rect != target && node.rect.center.dx <= target.left,
            )
            : nodes.where(
              (FocusNode node) =>
                  node.rect != target && node.rect.center.dx >= target.right,
            );
    final List<FocusNode> sorted = filtered.toList();
    mergeSort<FocusNode>(
      sorted,
      compare:
          (FocusNode a, FocusNode b) =>
              a.rect.center.dx.compareTo(b.rect.center.dx),
    );
    return sorted;
  }

  /// Handles directional focus traversal from [currentNode] in [direction].
  ///
  /// Returns true if a node was focused, otherwise falls back to the superclass.
  @override
  bool inDirection(FocusNode currentNode, TraversalDirection direction) {
    final nearestScope = currentNode.nearestScope;
    if (nearestScope == null) return false;

    final FocusNode? focusedChild = nearestScope.focusedChild;
    if (focusedChild == null) {
      return inDirectionNoCurrentFocus(currentNode, direction);
    }

    FocusNode? found;
    switch (direction) {
      case TraversalDirection.down:
        found = _findFirstInNextRow(
          focusedChild,
          nearestScope.traversalDescendants,
        );
        break;
      case TraversalDirection.up:
        found = _findFirstInPrevRow(
          focusedChild,
          nearestScope.traversalDescendants,
        );
        break;
      case TraversalDirection.left:
      case TraversalDirection.right:
        Iterable<FocusNode> eligibleNodes = _sortAndFilterHorizontally(
          direction,
          focusedChild.rect,
          nearestScope.traversalDescendants,
        );
        if (eligibleNodes.isNotEmpty) {
          if (direction == TraversalDirection.left) {
            eligibleNodes = eligibleNodes.toList().reversed;
          }
          final Rect band = Rect.fromLTRB(
            -double.infinity,
            focusedChild.rect.top,
            double.infinity,
            focusedChild.rect.bottom,
          );
          final Iterable<FocusNode> inBand = eligibleNodes.where(
            (FocusNode node) => !node.rect.intersect(band).isEmpty,
          );
          if (inBand.isNotEmpty) {
            found =
                _sortByDistancePreferHorizontal(
                  focusedChild.rect.center,
                  inBand,
                ).first;
          }
        }
        break;
    }
    if (found != null) {
      return foundNodeToFocus(found, direction);
    }
    return false;
  }

  /// Finds the first node in the next row below [focusedChild].
  ///
  /// Returns the leftmost fully visible node in the next row, or null
  FocusNode? _findFirstInNextRow(
    FocusNode focusedChild,
    Iterable<FocusNode> nodes,
  ) {
    final double currentBottom = focusedChild.rect.bottom;
    final below = nodes.where((n) => n.rect.top > currentBottom).toList();
    if (below.isEmpty) return null;
    below.sort((a, b) => a.rect.top.compareTo(b.rect.top));
    final double nextRowTop = below.first.rect.top;
    final nextRow =
        below.where((n) => (n.rect.top - nextRowTop).abs() < 1.0).toList();
    final fullyVisible =
        nextRow.where((node) => node.rect.left >= 0.0).toList();
    fullyVisible.sort((a, b) => a.rect.left.compareTo(b.rect.left));
    return fullyVisible.first;
  }

  /// Finds the first node in the closest row above [focusedChild].
  ///
  /// Returns the leftmost fully visible node in the previous row, or null
  FocusNode? _findFirstInPrevRow(
    FocusNode focusedChild,
    Iterable<FocusNode> nodes,
  ) {
    final double currentTop = focusedChild.rect.top;
    final above = nodes.where((n) => n.rect.bottom < currentTop).toList();
    if (above.isEmpty) return null;
    above.sort((a, b) => a.rect.bottom.compareTo(b.rect.bottom));
    final double prevRowBottom = above.last.rect.bottom;
    final prevRow =
        above
            .where((n) => (n.rect.bottom - prevRowBottom).abs() < 1.0)
            .toList();
    final fullyVisible =
        prevRow.where((node) => node.rect.left >= 0.0).toList();
    fullyVisible.sort((a, b) => a.rect.left.compareTo(b.rect.left));
    return fullyVisible.first;
  }

  /// Handles focus traversal when no node is currently focused.
  ///
  /// Focuses the first eligible node in [direction], or [currentNode] if none found.
  bool inDirectionNoCurrentFocus(
    FocusNode currentNode,
    TraversalDirection direction,
  ) {
    final FocusNode firstFocus =
        findFirstFocusInDirection(currentNode, direction) ?? currentNode;
    return foundNodeToFocus(firstFocus, direction);
  }

  /// Requests focus for [chosenNode] and applies scroll alignment based on [direction].
  bool foundNodeToFocus(FocusNode chosenNode, TraversalDirection direction) {
    chosenNode.requestFocus();
    return true;
  }

  /// Callback to request focus and ensure the node is visible in a scrollable.
  @override
  TraversalRequestFocusCallback get requestFocusCallback => (
    FocusNode node, {
    ScrollPositionAlignmentPolicy? alignmentPolicy,
    double? alignment,
    Duration? duration,
    Curve? curve,
  }) {
    node.requestFocus();
    ScrollableX.ensureCenterVerticalAlignment(
      node.context!,
      alignmentPolicy,
      duration: kAnimationDuration,
      curve: curve ?? Curves.easeOut,
    );
  };
}
