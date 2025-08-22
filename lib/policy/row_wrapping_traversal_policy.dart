import 'package:flutter/widgets.dart';
import 'package:flutter_focus_fun_tv_demo/policy/grid_row_traversal_policy.dart';

/// A custom focus traversal policy for grid-like layouts that supports row wrapping.
///
/// - Down: Moves focus to the first (leftmost) item in the next row.
/// - Up: Moves focus to the nearest item above.
/// - Right: If at the end of a row, wraps to the first item of the next row.
/// - Left: If at the start of a row, wraps to the last item of the previous row.
class RowWrappingTraversalPolicy extends GridRowTraversalPolicy {
  @override
  bool inDirection(FocusNode currentNode, TraversalDirection direction) {
    final nearestScope = currentNode.nearestScope;
    if (nearestScope == null) return false;

    final FocusNode? focusedChild = nearestScope.focusedChild;
    if (focusedChild == null) {
      // If nothing is focused, use default logic.
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
        found = _findNearestAbove(
          focusedChild,
          nearestScope.traversalDescendants,
        );
        break;
      case TraversalDirection.right:
        found = _findNextOrWrap(
          focusedChild,
          nearestScope.traversalDescendants,
          forward: true,
        );
        break;
      case TraversalDirection.left:
        found = _findNextOrWrap(
          focusedChild,
          nearestScope.traversalDescendants,
          forward: false,
        );
        break;
    }
    if (found != null) {
      return foundNodeToFocus(found, direction);
    }
    return super.inDirection(currentNode, direction);
  }

  /// Returns all nodes in the same row as [focusedChild], sorted left to right.
  List<FocusNode> _getCurrentRow(
    FocusNode focusedChild,
    Iterable<FocusNode> nodes,
  ) {
    final double rowTop = focusedChild.rect.top;
    final row = nodes.where((n) => (n.rect.top - rowTop).abs() < 1.0).toList();
    row.sort((a, b) => a.rect.left.compareTo(b.rect.left));
    return row;
  }

  /// Finds the next or previous node in the current row, or wraps to the next/previous row.
  FocusNode? _findNextOrWrap(
    FocusNode focusedChild,
    Iterable<FocusNode> nodes, {
    required bool forward,
  }) {
    final row = _getCurrentRow(focusedChild, nodes);
    if (row.isEmpty) return null;
    final idx = row.indexOf(focusedChild);
    if (idx == -1) return null;

    if (forward) {
      // Move right: wrap to next row if at end.
      if (idx == row.length - 1) {
        return _findFirstInNextRow(focusedChild, nodes);
      } else {
        return row[idx + 1];
      }
    } else {
      // Move left: do NOT wrap to previous row if at start.
      // if (idx == 0) {
        return null;
      // } else {
      //   return row[idx - 1];
      // }
    }
  }

  /// Finds the first (leftmost) node in the next row below [focusedChild].
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
    nextRow.sort((a, b) => a.rect.left.compareTo(b.rect.left));
    return nextRow.isNotEmpty ? nextRow.first : null;
  }

  /// Finds the last (rightmost) node in the previous row above [focusedChild].
  FocusNode? _findLastInPreviousRow(
    FocusNode focusedChild,
    Iterable<FocusNode> nodes,
  ) {
    final double currentTop = focusedChild.rect.top;
    final above = nodes.where((n) => n.rect.bottom < currentTop).toList();
    if (above.isEmpty) return null;
    above.sort((a, b) => b.rect.top.compareTo(a.rect.top));
    final double prevRowTop = above.first.rect.top;
    final prevRow =
        above.where((n) => (n.rect.top - prevRowTop).abs() < 1.0).toList();
    prevRow.sort((a, b) => a.rect.left.compareTo(b.rect.left));
    return prevRow.isNotEmpty ? prevRow.last : null;
  }

  /// Finds the nearest node above [focusedChild] by vertical and horizontal proximity.
  FocusNode? _findNearestAbove(
    FocusNode focusedChild,
    Iterable<FocusNode> nodes,
  ) {
    final above =
        nodes.where((n) => n.rect.bottom <= focusedChild.rect.top).toList();
    if (above.isEmpty) return null;
    above.sort((a, b) {
      final dyA = (focusedChild.rect.top - a.rect.bottom).abs();
      final dyB = (focusedChild.rect.top - b.rect.bottom).abs();
      final dxA = (a.rect.center.dx - focusedChild.rect.center.dx).abs();
      final dxB = (b.rect.center.dx - focusedChild.rect.center.dx).abs();
      return dyA != dyB ? dyA.compareTo(dyB) : dxA.compareTo(dxB);
    });
    return above.first;
  }
}
