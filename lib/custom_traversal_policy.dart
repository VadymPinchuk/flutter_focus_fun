import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_focus_fun_tv_demo/constants.dart';
import 'package:flutter_focus_fun_tv_demo/scrollable_ensure_alignment.dart'
    show ScrollableX;

class CustomTraversalPolicy extends ReadingOrderTraversalPolicy {
  static int _verticalCompare(Offset target, Offset a, Offset b) {
    return (a.dy - target.dy).abs().compareTo((b.dy - target.dy).abs());
  }

  static int _horizontalCompare(Offset target, Offset a, Offset b) {
    return (a.dx - target.dx).abs().compareTo((b.dx - target.dx).abs());
  }

  // Sort the ones that are closest horizontally first, and if two are the same
  // horizontal distance, pick the one that is closest vertically.
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

  static int _verticalCompareClosestEdge(Offset target, Rect a, Rect b) {
    // Find which edge is closest to the target for each.
    final double aCoord =
        (a.top - target.dy).abs() < (a.bottom - target.dy).abs()
            ? a.top
            : a.bottom;
    final double bCoord =
        (b.top - target.dy).abs() < (b.bottom - target.dy).abs()
            ? b.top
            : b.bottom;
    return (aCoord - target.dy).abs().compareTo((bCoord - target.dy).abs());
  }

  // Sort the ones that have edges that are closest vertically first, and if
  // two are the same vertical distance, pick the one that is closest
  // horizontally.
  static Iterable<FocusNode> _sortClosestEdgesByDistancePreferVertical(
    Offset target,
    Iterable<FocusNode> nodes,
  ) {
    final List<FocusNode> sorted = nodes.toList();
    mergeSort<FocusNode>(
      sorted,
      compare: (FocusNode nodeA, FocusNode nodeB) {
        final int vertical = _verticalCompareClosestEdge(
          target,
          nodeA.rect,
          nodeB.rect,
        );
        if (vertical == 0) {
          // If they're the same distance vertically, pick the closest one
          // horizontally.
          return _horizontalCompare(
            target,
            nodeA.rect.center,
            nodeB.rect.center,
          );
        }
        return vertical;
      },
    );
    return sorted;
  }

  // Sorts nodes from left to right horizontally, and removes nodes that are
  // either to the right of the left side of the target node if we're going
  // left, or to the left of the right side of the target node if we're going
  // right.
  //
  // This doesn't need to take into account directionality because it is
  // typically intending to actually go left or right, not in a reading
  // direction.
  Iterable<FocusNode> _sortAndFilterHorizontally(
    TraversalDirection direction,
    Rect target,
    Iterable<FocusNode> nodes,
  ) {
    assert(
      direction == TraversalDirection.left ||
          direction == TraversalDirection.right,
    );
    final Iterable<FocusNode> filtered;
    switch (direction) {
      case TraversalDirection.left:
        filtered = nodes.where(
          (FocusNode node) =>
              node.rect != target && node.rect.center.dx <= target.left,
        );
      case TraversalDirection.right:
        filtered = nodes.where(
          (FocusNode node) =>
              node.rect != target && node.rect.center.dx >= target.right,
        );
      case TraversalDirection.up:
      case TraversalDirection.down:
        throw ArgumentError('Invalid direction $direction');
    }
    final List<FocusNode> sorted = filtered.toList();
    // Sort all nodes from left to right.
    mergeSort<FocusNode>(
      sorted,
      compare:
          (FocusNode a, FocusNode b) =>
              a.rect.center.dx.compareTo(b.rect.center.dx),
    );
    return sorted;
  }

  // Sorts nodes from top to bottom vertically, and removes nodes that are
  // either below the top of the target node if we're going up, or above the
  // bottom of the target node if we're going down.
  Iterable<FocusNode> _sortAndFilterVertically(
    TraversalDirection direction,
    Rect target,
    Iterable<FocusNode> nodes,
  ) {
    assert(
      direction == TraversalDirection.up ||
          direction == TraversalDirection.down,
    );
    final Iterable<FocusNode> filtered;
    switch (direction) {
      case TraversalDirection.up:
        filtered = nodes.where(
          (FocusNode node) =>
              node.rect != target && node.rect.center.dy <= target.top,
        );
      case TraversalDirection.down:
        filtered = nodes.where(
          (FocusNode node) =>
              node.rect != target && node.rect.center.dy >= target.bottom,
        );
      case TraversalDirection.left:
      case TraversalDirection.right:
        throw ArgumentError('Invalid direction $direction');
    }
    final List<FocusNode> sorted = filtered.toList();
    mergeSort<FocusNode>(
      sorted,
      compare:
          (FocusNode a, FocusNode b) =>
              a.rect.center.dy.compareTo(b.rect.center.dy),
    );
    return sorted;
  }

  @override
  bool inDirection(FocusNode currentNode, TraversalDirection direction) {
    final nearestScope = currentNode.nearestScope;
    if (nearestScope == null) {
      return false;
    }

    final FocusNode? focusedChild = nearestScope.focusedChild;
    if (focusedChild == null) {
      return inDirectionNoCurrentFocus(currentNode, direction);
    }

    FocusNode? found;
    final ScrollableState? focusedScrollable = Scrollable.maybeOf(
      focusedChild.context!,
    );
    switch (direction) {
      case TraversalDirection.down:
      case TraversalDirection.up:
        Iterable<FocusNode> eligibleNodes = _sortAndFilterVertically(
          direction,
          focusedChild.rect,
          nearestScope.traversalDescendants,
        );
        if (eligibleNodes.isEmpty) {
          break;
        }
        if (focusedScrollable != null && !focusedScrollable.position.atEdge) {
          final Iterable<FocusNode> filteredEligibleNodes = eligibleNodes.where(
            (FocusNode node) =>
                Scrollable.maybeOf(node.context!) == focusedScrollable,
          );
          if (filteredEligibleNodes.isNotEmpty) {
            eligibleNodes = filteredEligibleNodes;
          }
        }
        if (direction == TraversalDirection.up) {
          eligibleNodes = eligibleNodes.toList().reversed;
        }
        // Pick the one that is
        // closest to the center line vertically, and if any are the same
        // distance vertically, pick the closest one of those horizontally.
        found =
            _sortClosestEdgesByDistancePreferVertical(
              focusedChild.rect.center,
              eligibleNodes,
            ).first;
      case TraversalDirection.right:
      case TraversalDirection.left:
        Iterable<FocusNode> eligibleNodes = _sortAndFilterHorizontally(
          direction,
          focusedChild.rect,
          nearestScope.traversalDescendants,
        );
        if (eligibleNodes.isEmpty) {
          break;
        }
        if (focusedScrollable != null && !focusedScrollable.position.atEdge) {
          final Iterable<FocusNode> filteredEligibleNodes = eligibleNodes.where(
            (FocusNode node) =>
                Scrollable.maybeOf(node.context!) == focusedScrollable,
          );
          if (filteredEligibleNodes.isNotEmpty) {
            eligibleNodes = filteredEligibleNodes;
          }
        }
        if (direction == TraversalDirection.left) {
          eligibleNodes = eligibleNodes.toList().reversed;
        }
        // Find any nodes that intersect the band of the focused child.
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
          break;
        }
        // If we do not find any candidates in the horizontal band,
        // then we should not navigate anywhere
        return false;
    }
    if (found != null) {
      return foundNodeToFocus(found, direction);
    }
    return super.inDirection(currentNode, direction);
  }

  bool inDirectionNoCurrentFocus(
    FocusNode currentNode,
    TraversalDirection direction,
  ) {
    final FocusNode firstFocus =
        findFirstFocusInDirection(currentNode, direction) ?? currentNode;
    return foundNodeToFocus(firstFocus, direction);
  }

  bool foundNodeToFocus(FocusNode chosenNode, TraversalDirection direction) {
    final alignmentPolicy = switch (direction) {
      TraversalDirection.up || TraversalDirection.left =>
        ScrollPositionAlignmentPolicy.keepVisibleAtStart,
      TraversalDirection.right ||
      TraversalDirection.down => ScrollPositionAlignmentPolicy.keepVisibleAtEnd,
    };
    chosenNode.requestFocus();

    // requestFocusCallback(
    //   chosenNode,
    //   alignmentPolicy: alignmentPolicy,
    //   alignment: 0.5,
    //   curve: Curves.easeOut,
    //   duration: const Duration(milliseconds: 300),
    // );
    return true;
  }

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
