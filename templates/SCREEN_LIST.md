# Screen List & Route Inventory: [Project Name]

## 1. Screen Registry
All application screens, routes, and modal surfaces are cataloged below.

| Screen ID | Screen Name | Route Path | Parent / Container | Description | Auth Required |
| :--- | :--- | :--- | :--- | :--- | :---: |
| **SCR-001** | Splash / Loader | `/splash` | Root | Session verification & initialization | No |
| **SCR-002** | Login / Welcome | `/auth/login` | AuthShell | User login and credentials input | No |
| **SCR-003** | Register | `/auth/register` | AuthShell | New user registration | No |
| **SCR-004** | Dashboard Home | `/dashboard` | AppShell (Nav 1) | Primary landing screen & metrics summary | Yes |
| **SCR-005** | Item List / Explorer | `/items` | AppShell (Nav 2) | Paginated list of resources with filters | Yes |
| **SCR-006** | Item Detail | `/items/:id` | Root Stack | Full detail view of specific resource | Yes |
| **SCR-007** | Item Create / Edit | `/items/edit` | Modal Sheet | Form interface for resource creation/edit | Yes |
| **SCR-008** | Analytics / Reports | `/analytics` | AppShell (Nav 3) | Charts, metrics, and data summaries | Yes |
| **SCR-009** | User Profile & Settings | `/settings` | AppShell (Nav 4) | User preferences, theme, and security | Yes |

---

## 2. Dialogs & Bottom Sheet Modals

| Modal ID | Modal Name | Trigger Screen | Purpose | Dismissible |
| :--- | :--- | :--- | :--- | :---: |
| **MOD-001** | Confirmation Dialog | `/items/:id` | Confirm destructive delete action | Yes |
| **MOD-002** | Filter Sheet | `/items` | Multi-select filters and sorting options | Yes |
| **MOD-003** | Offline Warning Banner | Global | Informs user of offline mode | Auto-dismiss |

---

## 3. Responsive Breakpoints & Shell Layouts
- **Compact Viewport (< 600dp)**: Bottom Navigation Bar with 3–5 destinations.
- **Medium Viewport (600dp – 1024dp)**: Navigation Rail (left side) with persistent shell.
- **Expanded Viewport (> 1024dp)**: Permanent Sidebar Navigation with multi-pane split layout.
