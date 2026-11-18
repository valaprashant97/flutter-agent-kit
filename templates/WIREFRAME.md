# Low-Fidelity Wireframes & Layout Hierarchy: [Project Name]

## 1. Overview
This document specifies the structural wireframes, spatial organization, content hierarchy, and scanning patterns for **[Project Name]** prior to UI implementation.

---

## 2. Global Shell Wireframe (Desktop & Expanded Viewport)

```text
+------------------------------------------------------------------------------------+
|  [Logo] App Title                      [Search Bar]                 [Bell] [Avatar]|
+-------------------+----------------------------------------------------------------+
|                   | Breadcrumb: Home > Items > Details                             |
|  [Icon] Dashboard |----------------------------------------------------------------+
|  [Icon] Explorer  | Screen Title Header                       [+ Primary Action]   |
|  [Icon] Reports   |----------------------------------------------------------------+
|  [Icon] Settings  | [ Filter Tabs: All | Active | Archived ]      [Sort Dropdown v]    |
|                   |----------------------------------------------------------------+
|                   | +------------------------------------------------------------+ |
|                   | | Card 1: Title                                              | |
|                   | | Subtitle / description metadata                            | |
|                   | | [Badge] [Tag]                         [More Actions (•••)] | |
|                   | +------------------------------------------------------------+ |
|                   | | Card 2: Title                                              | |
|                   | | Subtitle / description metadata                            | |
|                   | | [Badge] [Tag]                         [More Actions (•••)] | |
|                   | +------------------------------------------------------------+ |
|                   |                                                                |
|  [Status: Online] | [<< Prev]                       Page 1 of 5           [Next >>]|
+-------------------+----------------------------------------------------------------+
```

---

## 3. Mobile Shell Wireframe (Compact Viewport)

```text
+-----------------------------------+
| [=] App Title         [Search] [.]|
+-----------------------------------+
| Tab Bar: [Active (12)] [History]  |
+-----------------------------------+
| +-------------------------------+ |
| | Item Card 1                   | |
| | Status: Active      $120.00   | |
| +-------------------------------+ |
| +-------------------------------+ |
| | Item Card 2                   | |
| | Status: Pending      $45.00   | |
| +-------------------------------+ |
|                                   |
|                              (+)  | <-- Floating Action Button
+-----------------------------------+
| [Home]  [Explorer] [Reports] [Set]| <-- Bottom Nav (4 Destinations)
+-----------------------------------+
```

---

## 4. Form Layout Wireframe (Input Sequencing)

```text
+-------------------------------------------------------------+
| Header: Create New Item                     [ X (Close) ]   |
+-------------------------------------------------------------+
| 1. Item Name *                                              |
|    [ Enter clear item name...                             ] |
|    Hint: Must be between 3 and 50 characters                |
|                                                             |
| 2. Category & Status                                        |
|    [ Select Category v ]      [ Status: Default Active v ]  |
|                                                             |
| 3. Description                                              |
|    [ Detailed description of the item...                  ] |
|    [                                                      ] |
|                                                             |
| 4. Pricing / Numerical Input                                |
|    [$ Currency ] [ 0.00                                   ] |
+-------------------------------------------------------------+
| [ Cancel (Outlined) ]             [ Submit Item (Primary) ] |
+-------------------------------------------------------------+
```

---

## 5. Accessibility & Tap Target Rules
- **Minimum Tap Target**: All interactive touch surfaces must measure $\ge 48 \times 48\text{ pt}$.
- **Focus Rings**: Desktop navigation must display a 2pt visible focus ring on keyboard tab navigation.
- **Form Error Positioning**: Error messages render immediately below the offending input field with `Icon(Icons.error_outline)`.
