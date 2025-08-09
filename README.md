# SalesTools (Retail 11.2 Compatible)

**Author / Maintainer:** Updated for patch 11.2 by **Osiris the Kiwi 🥝** (Discord: `osirisnz`)  
**Original Authors & Contributors:** Adalyia-Illidan, Volthemar-Dalaran, Honorax-Illidan

SalesTools is a World of Warcraft addon designed to streamline gold trading, sales tracking, and communication for collectors, traders, and boosters.  
This repository is a **continuation and maintenance fork** of the original [SalesTools by Adalyia](https://github.com/Adalyia/SalesTools), updated for Retail patch 11.2 with fixes, quality-of-life improvements, and UI enhancements.

---

## ✨ Features

- **Collector Menu**  
  Centralized hub for addon features, including quick access to Trade Log, Balance List, Gold Info, and more.

- **Trade Log Improvements**  
  - Simplified whisper confirmations — only the concise "Received Xg from Player" message is sent.  
  - Eliminates duplicate trade messages.  
  - Fully compatible with modern Retail trade events.

- **UI & Layout Updates**  
  - Stable button anchors for all menu actions.  
  - Logical reordering of buttons for improved usability.  
  - Gold Info heading matches Collector Menu in font, size, and color.

- **Version Information**  
  - `/sales version` command now shows maintainer and contributor credits.
  - In-menu **Version Information** button toggles the version panel.
  - Startup banner:  
    ```
    [SalesTools] Version 1.2.0 updated for patch 11.2 by Osiris the Kiwi
    ```
  - Closing the Collector Menu prints:  
    ```
    [SalesTools] To open Collector Menu type /sales collect
    ```

- **Copy Helper Enhancements**  
  Unified popup for copying player names or gold amounts, with auto-focus and one-click selection.

- **Miscellaneous Fixes**  
  - Updated to Retail 11.x popup API changes.  
  - Removed deprecated trade events.  
  - Silent, safe module loading for better compatibility.

---

## 📦 Installation

1. **Download** the latest release from [Releases](../../releases).
2. **Extract** the archive so that the folder structure is:  
   ```
   World of Warcraft/_retail_/Interface/AddOns/SalesTools/
   ```
3. **Restart** WoW or run `/reload` in-game.

---

## 💻 Commands

| Command             | Description                                 |
| ------------------- | ------------------------------------------- |
| `/sales collect`    | Toggle the Collector Menu                   |
| `/sales version`    | Show version information panel              |
| `/sales help`       | Display the Info Plate                      |

---

## 📜 Changelog

See [CHANGELOG.md](./CHANGELOG.md) for the complete update history.

---

## 🛠 Development Notes

- This is a **maintenance fork** of the original addon, updated for Retail 11.2.
- All modifications are noted in file headers where applicable.
- The addon remains licensed under **GNU General Public License v3.0**.

---

## 📄 License

This project is licensed under the [GNU GPL v3.0](./LICENSE).  
You are free to use, modify, and distribute it, provided that:
- The same GPL-3.0 license applies to your changes.
- Original author credits are preserved.
- Modifications are clearly documented.

---

## 🙏 Credits

- **Original Authors:** Adalyia-Illidan, Volthemar-Dalaran, Honorax-Illidan
- **Retail 11.2 Maintenance:** Osiris the Kiwi 🥝
- Thanks to the WoW addon community for continued feedback and testing.
