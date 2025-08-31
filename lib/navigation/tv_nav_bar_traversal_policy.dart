import 'package:flutter/widgets.dart';

/// A custom focus traversal policy for a TV app side menu.
/// Restricts vertical focus traversal to side menu items only,
/// while allowing unrestricted horizontal navigation.
class TvNavBarTraversalPolicy extends FocusTraversalPolicy
    with DirectionalFocusTraversalPolicyMixin {
  final List<FocusNode> navBarNodes;

  /// Creates a policy that restricts vertical focus traversal to the side menu.
  ///
  /// [navBarNodes] should contain the list of focus nodes that belong to the side menu.
  TvNavBarTraversalPolicy({required this.navBarNodes});

  @override
  bool inDirection(FocusNode currentNode, TraversalDirection direction) {
    if (direction == TraversalDirection.up ||
        direction == TraversalDirection.down) {
      // Restrict vertical navigation to side menu items only.
      if (navBarNodes.contains(currentNode)) {
        final int currentIndex = navBarNodes.indexOf(currentNode);
        final int nextIndex =
            direction == TraversalDirection.down
                ? currentIndex + 1
                : currentIndex - 1;

        if (nextIndex >= 0 && nextIndex < navBarNodes.length) {
          navBarNodes[nextIndex].requestFocus();
          return true;
        }
      }
      // Prevent vertical navigation outside the side menu.
      return false;
    }
    // Allow unrestricted horizontal navigation.
    return super.inDirection(currentNode, direction);
  }

  @override
  Iterable<FocusNode> sortDescendants(
    Iterable<FocusNode> descendants,
    FocusNode currentNode,
  ) {
    // Default sorting behavior (can be customized if needed).
    return descendants;
  }
}
