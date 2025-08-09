# Changelog

## [1.2.0] — 2025‑08‑10
**Maintainer:** Osiris the Kiwi (Discord: osirisnz)  
**Previous contributors:** Adalyia‑Illidan, Volthemar‑Dalaran, Honorax‑Illidan

### Added
- **Version Information** toggle button in Collector Menu (replaces “Mass Whisper”) to open/close `/sales version`.
- A reliable startup message:
  ```
  [SalesTools] Version 1.2.0 updated for patch 11.2 by Osiris the Kiwi
  ```
- Collector Menu reload tip when pressing “Close Collector Menu”:
  ```
  [SalesTools] to open Collector Menu type /sales collect
  ```
- `/sales version` panel formatting updated with maintainer & contributor credits.
- Updated button labels and repositioned functionality:
  - “Mass Invite” → **Toggle Info Plate** (`/sales help`)
  - “Request Inv” → **Close Collector Menu** (`/sales collect`)
- Full swapping of:
  - **Close Collector Menu** ↔ **Trade Log**
  - **Close Collector Menu** ↔ **Toggle Info Plate**
  - **Toggle Info Plate** ↔ **Trade Log**
  (Includes names, functions, and anchor preservation.)

### Changed
- Whisper behavior now only shows:
  ```
  Received Xg from <player> in a trade.
  ```
  Removed duplicate “I received Xg Ys Zc” messages.
- UI improvements:
  - Standardized copy popup with `StaticPopupDialogs["SalesToolsPopup"]`.
  - Button layout preserved with correct anchors for two-column alignment.
  - Consistent button naming and callback handlers.
- Startup message now fires reliably on login and reload.

### Fixed
- Various bug fixes and API updates:
  - Resolved `editBox` nil issues in Retail 11.x.
  - Fixed popup registration errors.
  - Removed deprecated trade event registrations.
  - Syntax cleanup in `SalesTools.lua`.
  - Made module loading safer with silent `GetModule()`.
- Corrected layout drift after swapping buttons by anchoring correctly.
- Legacy trade whisper code removed in favor of the clean, single confirmation from TradeLog.

### Removed
- Pre-trade whisper: “trading you X gold”.
- Duplicate “I received Xg Ys Zc” messages.

### Maintenance
- Centralized copy helper functions.
- UI refinements to `/sales version` panel.
- Consistent naming convention for Collector Menu buttons.

---

## [1.0.6] — 2024‑07‑28
- Updated for *The War Within* (Dragonflight 11.0).
- Dependency updates.
- Quick fix for minimap menu.

## [1.0.5] — 2024‑05‑25
- TOC/version bump for Dragonflight 10.1.
- Updated dependencies.

## [1.0.4] — 2023‑12‑13
- Added `/st gnames` to list Name‑Realm in your party or raid.
- Patched Dragonflight-era bug in LibGuildBankComm.

## [1.0.3] — 2023‑11‑28
- TOC bump for 10.0.2.
- Updated dependencies.

## [1.0.2] — 2023‑10‑28
- Dragonflight (WoW 10.0.0) compatibility.

## [1.0.1] — 2023‑06‑13
- Retail 9.2.5 version bump.

## [1.0.0] — 2023‑05‑06
**Initial release.** Continuation of Honorax’s GallywixAdTools with new modules:
- AutoInvite, BalanceList, CollectorMenu UI, HelperDisplay, MailGrabber, MailLog, MailSender, MassInvite, MassWhisper, TradeLog, Language support (enUS, ptBR, esMX, esES).
