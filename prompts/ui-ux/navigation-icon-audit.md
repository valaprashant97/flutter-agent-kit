# Navigation Usability & Icon Clarity Audit Prompt

You are acting as a Principal Flutter UI/UX Architect and Accessibility Engineer guided by the **Flutter Agent Kit**.

---

## 1. PROJECT CONTEXT
- **Target Application**: [APP NAME & DIRECTORY]
- **Target Platforms**: [Mobile (Android/iOS), Desktop (Windows/macOS/Linux), Web]
- **Standards & Specifications**: `docs/NAVIGATION_AND_ICON_STANDARDS.md`, `skills/navigation-clarity/`, `workflows/navigation-usability-audit/`

---

## 2. OBJECTIVE
Conduct a comprehensive navigation usability and icon clarity audit across all application screens to identify and eliminate ambiguous icon-only buttons, overcrowded navigation bars, buried daily workflows, missing screen-reader labels, and unconfirmed destructive actions—ensuring every interaction is immediately understandable and discoverable.

---

## 3. EXISTING BEHAVIOR
- [DESCRIBE CURRENT NAVIGATION SCAFFOLD, AMBIGUOUS ICONS, OVERCROWDED BARS, OR USER CONFUSION PAIN POINTS]

---

## 4. REQUIRED INVESTIGATION
1. Inspect the primary navigation scaffold (`NavigationBar`, `NavigationRail`, `NavigationDrawer`):
   - Count bottom navigation destinations on mobile (flag if $<3$ or $>5$).
   - Check if visible labels are enabled or hidden.
2. Scan all presentation widgets in `lib/` for `IconButton` or icon-only gesture controls:
   - Identify domain-specific or ambiguous icons that lack visible text labels.
   - Check if tooltips are missing or merely repeat the icon graphic name (e.g. `"icon delete"` vs `"Delete draft invoice"`).
   - Verify touch target dimensions (minimum 48x48dp mobile, 32x32dp desktop).
3. Review action prioritization:
   - Verify primary daily workflows are prominently visible on the screen.
   - Verify secondary actions are organized into logical menus (`MenuAnchor`, `PopupMenuButton`).
   - Check if destructive actions have explicit confirmation dialogs.

---

## 5. CONSTRAINTS
- Non-destructive proposal first: generate the complete proposed change list and audit table before modifying code on existing projects.
- Mobile bottom navigation must strictly maintain 3–5 essential destinations with visible labels.
- Ambiguous or domain-specific actions must use visible text labels (`FilledButton.icon`, `OutlinedButton.icon`) or labeled menu items.
- Never rely on tooltips as the only cognitive explanation on touch devices.
- Every interactive icon must have an action-descriptive semantic label for screen readers.
- Destructive operations must require confirmation modals and use red warning visual cues.
- Do not break existing route history or deep linking configurations.

---

## 6. ACCEPTANCE CRITERIA
- [ ] Complete Navigation Usability Audit Report authored with all columns populated.
- [ ] Mobile bottom navigation consolidated to 3–5 essential destinations.
- [ ] Ambiguous icon-only controls replaced with labeled buttons or menu items.
- [ ] 100% of interactive icons have action-descriptive tooltips and semantic labels.
- [ ] Interactive touch targets meet 48x48dp mobile / 32x32dp desktop bounds.
- [ ] Destructive actions protected by confirmation dialogs.
- [ ] Mandatory 10-point Navigation & Icon checklist verified.
- [ ] `flutter analyze` passes cleanly with 0 warnings.

---

## 7. EDGE CASES
- Long localized labels inside bottom navigation (must fit without truncation or excessive wrapping).
- Responsive breakpoint transitions (smoothly switching between `NavigationBar` on mobile and `NavigationRail` or sidebar on tablet/desktop).
- Screen reader focus order when navigating through menus and modal dialogs.
- Keyboard navigation on desktop (`Tab` key order, `Enter`/`Space` activation, hover tooltips).

---

## 8. TESTING REQUIREMENTS
- Automated widget tests asserting semantic labels on all interactive icon buttons.
- Widget tests asserting navigation destination taps trigger expected route transitions.
- Verification that destructive actions cannot execute without dismissing the confirmation dialog.

---

## 9. EXPECTED OUTPUT
1. **Navigation Usability Audit Report**: Markdown table detailing screen name, control type, visual icon, actual action, recognizability, and recommendation.
2. **Proposed Action Plan**: Prioritized remediation steps presented for review prior to code modification.
3. **Surgical Remediation Code**: Focused widget edits applying approved navigation and icon clarity improvements.
4. **Verification Evidence**: Completed 10-point checklist and automated test results (`flutter test`, `flutter analyze`).
