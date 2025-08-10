import 'package:flutter/material.dart';

/// A custom focus policy for TV rails that provides predictable navigation.
///
/// This policy implements the following rules:
/// 1. When moving vertically (Up/Down) to a new rail, focus is always
///    set to the first item in that rail.
/// 2. When on the first item of a rail, pressing Left does nothing.
/// 3. When on the last item of a rail, pressing Right does nothing.
class RailFocusTraversalPolicy extends FocusTraversalPolicy {
  @override
  bool inDirection(FocusNode currentNode, TraversalDirection direction) {
    final FocusNode? targetNode;

    // Determine the target node based on the direction of traversal.
    if (direction == TraversalDirection.up ||
        direction == TraversalDirection.down) {
      targetNode = _findTargetInVerticalDirection(currentNode, direction);
    } else {
      targetNode = _findTargetInHorizontalDirection(currentNode, direction);
    }

    if (targetNode != null) {
      // The policy is responsible for requesting focus on the target node.
      requestFocusCallback(targetNode);
      return true; // Return true because we successfully moved the focus.
    }

    // Return false to indicate that we did not handle the traversal,
    // allowing the framework to try the next policy up the tree.
    return false;
  }

  /// Finds the target node for left/right navigation within a single rail.
  FocusNode? _findTargetInHorizontalDirection(
    FocusNode currentNode,
    TraversalDirection direction,
  ) {
    // Get all focusable sibling nodes in the current rail.
    final List<FocusNode> siblings =
        currentNode.parent?.children.where((n) => n.canRequestFocus).toList() ??
        [];
    final int currentIndex = siblings.indexOf(currentNode);

    if (currentIndex == -1) return null;

    if (direction == TraversalDirection.left) {
      // If at the beginning of the rail, do not move focus.
      if (currentIndex == 0) return null;
      return siblings[currentIndex - 1];
    } else {
      // TraversalDirection.right
      // If at the end of the rail, do not move focus.
      if (currentIndex == siblings.length - 1) return null;
      return siblings[currentIndex + 1];
    }
  }

  /// Finds the target node for up/down navigation between rails.
  FocusNode? _findTargetInVerticalDirection(
    FocusNode currentNode,
    TraversalDirection direction,
  ) {
    // Find the FocusTraversalGroup that represents the current rail by traversing up the tree.
    FocusNode? currentRailNode = currentNode;
    while (currentRailNode != null) {
      final FocusNode? parent = currentRailNode.parent;
      // We've found the rail's group when its parent's context has a FocusTraversalGroup
      // that uses this policy instance. This is the most reliable way to find the scope boundary.
      if (parent != null &&
          parent.context != null &&
          FocusTraversalGroup.of(parent.context!) == this) {
        break;
      }
      currentRailNode = parent;
    }
    if (currentRailNode == null) return null;

    final List<FocusNode> railGroups =
        currentRailNode.parent?.children
            .where((n) => n.canRequestFocus)
            .toList() ??
        [];
    final int currentRailIndex = railGroups.indexOf(currentRailNode);

    if (currentRailIndex == -1) return null;

    int targetRailIndex;
    if (direction == TraversalDirection.down) {
      // If on the last rail, let the parent policy handle it.
      if (currentRailIndex >= railGroups.length - 1) return null;
      targetRailIndex = currentRailIndex + 1;
    } else {
      // TraversalDirection.up
      // If on the first rail, let the parent policy handle it (e.g., to go to the AppBar).
      if (currentRailIndex <= 0) return null;
      targetRailIndex = currentRailIndex - 1;
    }

    final FocusNode targetRailNode = railGroups[targetRailIndex];

    // The key principle: always find the *first* focusable child in the target rail.
    return findFirstFocus(targetRailNode, ignoreCurrentFocus: true);
  }

  // --- Required Abstract Method Implementations ---

  @override
  FocusNode? findFirstFocusInDirection(
    FocusNode currentNode,
    TraversalDirection direction,
  ) {
    // This is called when no node in the scope has focus. We'll find the
    // first focusable descendant as a sensible default.
    final FocusScopeNode scope = currentNode.nearestScope!;
    final Iterable<FocusNode> descendants = scope.traversalDescendants;
    if (descendants.isNotEmpty) {
      return descendants.first;
    }
    return null;
  }

  @override
  Iterable<FocusNode> sortDescendants(
    Iterable<FocusNode> descendants,
    FocusNode currentNode,
  ) {
    // We are not using next/previous traversal (tabbing), so the default order is fine.
    return descendants;
  }
}
