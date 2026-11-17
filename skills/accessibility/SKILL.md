---
name: accessibility
description: WCAG 2.1 AA accessibility auditing, semantics tree optimization, screen reader support, and touch target compliance.
---

# accessibility

## 1. Skill Name
`accessibility`

## 2. Purpose
Ensures Flutter applications meet WCAG 2.1 AA accessibility standards: screen reader announcements (TalkBack on Android, VoiceOver on iOS, Narrator on Windows), semantic labels, accessible contrast ratios, dynamic font scaling, and minimum touch target sizes.

## 3. When to Use
- When auditing screens for accessibility compliance.
- When creating custom buttons, sliders, interactive charts, or custom painters.
- When fixing screen reader navigation order or unannounced icon buttons.

## 4. When Not to Use
- For headless CLI tools or backend services.

## 5. Required Project Context
- Target UI widgets and screens
- Color scheme and typography tokens

## 6. Step-by-Step Workflow
1. **Audit Touch Targets**: Verify all interactive elements meet the minimum 48x48dp tap bounds on mobile (or 32x32dp on desktop).
2. **Label Icon-Only Actions**: Attach `tooltip` or wrap with `Semantics(label: '...')` on all icon-only buttons.
3. **Exclude Decorative Visuals**: Set `excludeFromSemantics: true` on background illustrations, patterns, and non-informative visual dividers.
4. **Audit Color Contrast**: Check body text against background for at least 4.5:1 contrast ratio (3.0:1 for large/bold text).
5. **Support Dynamic Type**: Verify layouts do not overflow or clip when the user scales system fonts up to 1.5x or 2.0x.
6. **Verify Semantic Traversal**: Use the Semantics Debugger (`showSemanticsDebugger: true`) to verify the screen reader reading order.

## 7. Engineering Rules
- **No Unlabeled Buttons**: Every button must announce its action to screen readers.
- **Action-Descriptive Labels**: Semantic labels and tooltips on interactive icon controls must describe the operational action (e.g. "Search invoice history"), never merely the visual graphic name (e.g. "search icon") (`docs/NAVIGATION_AND_ICON_STANDARDS.md`).
- **Never Disable Font Scaling Globally**: Do NOT apply `textScaler: TextScaler.noScaling` across an entire application. Layouts must be flexible enough to accommodate larger text.
- **Form Error Announcement**: Form validation errors must be read aloud by screen readers when validation fails.

## 8. Code Examples
```dart
// Accessible Custom Action Card
Semantics(
  button: true,
  label: 'Pay Invoice #1024 for \$450.00',
  hint: 'Double tap to open payment confirmation',
  child: InkWell(
    onTap: _openPaymentModal,
    borderRadius: BorderRadius.circular(12),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          const Icon(Icons.receipt_long, excludeFromSemantics: true),
          const SizedBox(width: 12),
          const Text('Invoice #1024'),
          const Spacer(),
          const Text('\$450.00'),
        ],
      ),
    ),
  ),
);
```

## 9. Common Mistakes
- Relying entirely on visual colors (e.g., green vs red) to indicate state without an accompanying text or icon label.
- Trapping screen reader focus inside custom gesture detectors that lack semantic nodes.
- Using 24x24dp clickable icons with zero padding, making them impossible for users with motor impairments to tap reliably.

## 10. Testing and Verification
- Run widget tests using `tester.getSemantics(find.byType(...))` to assert semantic labels.
- Verify screen with `MaterialApp(showSemanticsDebugger: true, ...)`.

## 11. Completion Criteria
- All interactive controls have semantic labels.
- Tap targets comply with minimum dimensions.
- Text contrast passes WCAG AA criteria.

## 12. Related Skills
- `navigation-clarity`
- `ui-implementation`
- `design-system`
- `testing`
