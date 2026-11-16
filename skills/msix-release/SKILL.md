---
name: msix-release
description: Windows MSIX installer packaging, code signing, certificate generation, and Microsoft Store release preparation.
---

# msix-release

## 1. Skill Name
`msix-release`

## 2. Purpose
Provides production standards for packaging Flutter Windows desktop applications into modern, secure **MSIX** installer packages. Covers `msix` package configuration in `pubspec.yaml`, self-signed certificate generation for enterprise sideloading, capability declarations, code signing, and Microsoft Store submission readiness.

## 3. When to Use
- When preparing a Flutter Windows application for distribution to end users.
- When creating a signed `.msix` installer for enterprise deployment or sideloading.
- When generating an MSIX package for Microsoft Store submission.

## 4. When Not to Use
- During local debug testing where `flutter run -d windows` is sufficient.
- When building for non-Windows platforms.

## 5. Required Project Context
- `pubspec.yaml`
- Windows app icon assets (`.png`, `.ico`)
- Signing certificate or Microsoft Store publisher credentials

## 6. Step-by-Step Workflow
1. **Add MSIX Dependency**: Add `msix` under `dev_dependencies` in `pubspec.yaml`.
2. **Configure `msix_config`**: Define `display_name`, `publisher_display_name`, `identity_name`, `msix_version`, logo paths, and capabilities.
3. **Compile Release Windows Binary**: Run `flutter build windows --release`.
4. **Create Self-Signed Certificate (for Sideloading)**: If distributing outside the Microsoft Store, generate and install a trusted code-signing certificate using PowerShell.
5. **Generate MSIX Package**: Run `dart run msix:create`.
6. **Verify Installation**: Install the generated `.msix` on a clean Windows machine and verify startup, icons, and clean uninstallation.

## 7. Engineering Rules
- **Semantic Versioning Alignment**: Ensure `msix_version` in `pubspec.yaml` follows the 4-part Windows format: `Major.Minor.Build.Revision` (e.g., `1.0.0.0`).
- **Publisher Name Matching**: The `publisher_display_name` and certificate subject name **must match exactly**, or Windows App Installer will reject the package with error `0x800B0109`.
- **Capability Declarations**: Declare only required Windows capabilities (e.g., `internetClient`, `runFullTrust`).

## 8. Code Examples
### 1. `pubspec.yaml` Configuration
```yaml
dev_dependencies:
  msix: ^3.16.7

msix_config:
  display_name: Enterprise App
  publisher_display_name: Enterprise Corp LLC
  identity_name: com.enterprisecorp.app
  msix_version: 1.0.2.0
  logo_path: assets/icons/icon_512.png
  start_menu_icon_path: assets/icons/icon_44.png
  tile_icon_path: assets/icons/icon_150.png
  certificate_path: certificates/windows_cert.pfx
  certificate_password: Password123
  capabilities:
    - internetClient
    - runFullTrust
```

### 2. PowerShell Script to Generate Self-Signed Cert
```powershell
# Create self-signed certificate matching publisher
New-SelfSignedCertificate -Type Custom `
  -Subject "CN=Enterprise Corp LLC" `
  -KeyUsage DigitalSignature `
  -FriendlyName "Enterprise Windows Cert" `
  -CertStoreLocation "Cert:\CurrentUser\My"

# Export to PFX
$cert = Get-ChildItem -Path Cert:\CurrentUser\My | Where-Object { $_.Subject -match "Enterprise Corp LLC" } | Select-Object -First 1
Export-PfxCertificate -Cert $cert -FilePath "certificates/windows_cert.pfx" `
  -Password (ConvertTo-SecureString -String "Password123" -Force -AsPlainText)
```

### 3. Generate Package Command
```bash
flutter build windows --release
dart run msix:create
```

## 9. Common Mistakes
- Mismatch between `publisher_display_name` in `pubspec.yaml` and the `CN` in the code-signing certificate.
- Failing to install the self-signed certificate into the **Trusted People** or **Trusted Root Certification Authorities** certificate store on target test machines, preventing sideloading.
- Forgetting to update `msix_version` when building updates, causing Windows to treat the update as already installed.

## 10. Testing and Verification
- Verify that `dart run msix:create` outputs a signed `.msix` in `build/windows/runner/Release/`.
- Double-click the `.msix` file on Windows to verify the Windows App Installer dialog opens with verified publisher status and correct application icons.

## 11. Completion Criteria
- Signed `.msix` package successfully created.
- Installer installs, launches, updates, and uninstalls cleanly on Windows.

## 12. Related Skills
- `windows-development`
- `desktop-development`
- `packaging`
- `production-readiness`
