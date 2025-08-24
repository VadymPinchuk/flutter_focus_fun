import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// A custom [FocusTraversalPolicy] for grid layouts that enables
/// intuitive row and column navigation using keyboard or remote controls.
///
/// - Horizontal navigation (left/right) moves within a row.
/// - Vertical navigation (up/down) jumps between rows, focusing the closest item.
class GridRowTraversalPolicy extends ReadingOrderTraversalPolicy {
  /// Handles directional focus traversal from [currentNode] in [direction].
  ///
  /// Returns true if a node was focused, otherwise falls back to the superclass.
  /// DO NOT CALL SUPER
  @override
  bool inDirection(FocusNode currentNode, TraversalDirection direction) {
    final nearestScope = currentNode.nearestScope;
    if (nearestScope == null) return false;

    final FocusNode? focusedChild = nearestScope.focusedChild;
    if (focusedChild == null) {
      return _inDirectionNoCurrentFocus(currentNode, direction);
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
        found = _findPreviousInTheRow(
          focusedChild,
          nearestScope.traversalDescendants,
        );
        break;
      case TraversalDirection.right:
        found = _findNextInTheRow(
          focusedChild,
          nearestScope.traversalDescendants,
        );
        break;
    }
    found?.requestFocus();
    return found != null;
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

  /// Finds all nodes in the same row as [focusedChild].
  Iterable<FocusNode> _findEligibleInSameRow(
    FocusNode focusedChild,
    Iterable<FocusNode> nodes,
  ) {
    final double currentTop = focusedChild.rect.top;
    final double currentBottom = focusedChild.rect.bottom;
    return nodes.where(
      (n) => n.rect.top == currentTop && n.rect.bottom == currentBottom,
    );
  }

  /// Finds the first node to the left of [focusedChild].
  FocusNode? _findPreviousInTheRow(
    FocusNode focusedChild,
    Iterable<FocusNode> nodes,
  ) {
    final eligible = _findEligibleInSameRow(focusedChild, nodes);
    final eligibleToLeft =
        eligible.where((n) => n.rect.right < focusedChild.rect.left).toList();
    if (eligibleToLeft.isEmpty) return null;
    eligibleToLeft.sort((a, b) => a.rect.right.compareTo(b.rect.right));
    return eligibleToLeft.last;
  }

  /// Finds the first node to the right of [focusedChild].
  FocusNode? _findNextInTheRow(
    FocusNode focusedChild,
    Iterable<FocusNode> nodes,
  ) {
    final eligible = _findEligibleInSameRow(focusedChild, nodes);
    final eligibleToRight =
        eligible.where((n) => n.rect.left > focusedChild.rect.right).toList();
    if (eligibleToRight.isEmpty) return null;
    eligibleToRight.sort((a, b) => a.rect.left.compareTo(b.rect.left));
    return eligibleToRight.first;
  }

  /// Handles focus traversal when no node is currently focused.
  ///
  /// Focuses the first eligible node in [direction], or [currentNode] if none found.
  bool _inDirectionNoCurrentFocus(
    FocusNode currentNode,
    TraversalDirection direction,
  ) {
    final FocusNode firstFocus =
        findFirstFocusInDirection(currentNode, direction) ?? currentNode;
    firstFocus.requestFocus();
    return true;
  }
}
