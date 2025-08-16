import 'package:flutter/widgets.dart';

/// A custom focus traversal policy for a TV app side menu.
/// Restricts vertical focus traversal to side menu items only,
/// while allowing unrestricted horizontal navigation.
class SideMenuTraversalPolicy extends FocusTraversalPolicy
    with DirectionalFocusTraversalPolicyMixin {
  final List<FocusNode> sideMenuNodes;

  /// Creates a policy that restricts vertical focus traversal to the side menu.
  ///
  /// [sideMenuNodes] should contain the list of focus nodes that belong to the side menu.
  SideMenuTraversalPolicy({required this.sideMenuNodes});

  @override
  Iterable<FocusNode> sortDescendants(
      Iterable<FocusNode> descendants, FocusNode currentNode) {
    // Default sorting behavior (can be customized if needed).
    return descendants;
  }

  @override
  bool inDirection(FocusNode currentNode, TraversalDirection direction) {
    if (direction == TraversalDirection.up ||
        direction == TraversalDirection.down) {
      // Restrict vertical navigation to side menu items only.
      if (sideMenuNodes.contains(currentNode)) {
        final int currentIndex = sideMenuNodes.indexOf(currentNode);
        final int nextIndex = direction == TraversalDirection.down
            ? currentIndex + 1
            : currentIndex - 1;

        if (nextIndex >= 0 && nextIndex < sideMenuNodes.length) {
          sideMenuNodes[nextIndex].requestFocus();
          return true;
        }
      }
      return false; // Prevent vertical navigation outside the side menu.
    }

    // Allow unrestricted horizontal navigation.
    return super.inDirection(currentNode, direction);
  }
}
