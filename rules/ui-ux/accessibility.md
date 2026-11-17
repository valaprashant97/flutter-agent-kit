# Accessibility (A11y) & Inclusive Design Rules

These rules ensure Flutter applications meet WCAG 2.1 AA accessibility guidelines across touch and desktop interfaces.

---

## 1. Touch Target Sizes
- **Minimum Interactive Size**: Interactive elements (buttons, icon buttons, checkboxes, chips) must have a minimum interactive tap target of **48 × 48 dp** on mobile and **32 × 32 dp** on desktop (mouse pointer).
- If visual size is smaller than 48dp, wrap with `IconButton` (which includes 48dp target padding by default) or use `MaterialTapTargetSize.padded`:
  ```dart
  IconButton(
    iconSize: 20,
    padding: const EdgeInsets.all(14), // Expands tap target to 48dp
    onPressed: _handleAction,
    icon: const Icon(Icons.favorite),
  )
  ```

---

## 2. Screen Reader Semantics
- **Icon-Only Buttons**: Every `IconButton` or clickable gesture without adjacent text **must** include an action-descriptive `tooltip` or `Semantics(label: ...)`:
  ```dart
  IconButton(
    icon: const Icon(Icons.delete),
    tooltip: 'Delete draft invoice', // Action-descriptive, NOT "delete icon"
    onPressed: _delete,
  )
  ```
- **Action Description Invariant**: Accessibility labels must describe the action performed, never the visual icon name (`docs/NAVIGATION_AND_ICON_STANDARDS.md`).
- **Decorative Images**: Mark decorative illustrations with `excludeFromSemantics: true` to avoid cluttering screen reader announcements:
  ```dart
  Image.asset('assets/images/background_pattern.png', excludeFromSemantics: true)
  ```
- **Custom Gestures**: If using `GestureDetector` or `InkWell` for complex custom components, wrap with a `Semantics` widget:
  ```dart
  Semantics(
    button: true,
    label: 'Open transaction details for Invoice #102',
    child: InkWell(onTap: _openDetails, child: ...),
  )
  ```

---

## 3. Contrast Ratios & Scalable Typography
- **Contrast Ratios**: Body text must achieve at least **4.5:1** contrast against its background. Large text (bold >18pt) must achieve at least **3.0:1**.
- **Font Scaling (Dynamic Type / Accessibility Fonts)**: Never disable font scaling by hardcoding `textScaler: TextScaler.noScaling` unless in constrained layout chips where overflow breaks layout. Always verify layouts don't break when user sets 1.5x font scaling in OS settings.
