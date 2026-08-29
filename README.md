# Custom SDDM Theme

Built on my hyprland and ghostty config for a consistent, minimal desktop experience.

## Changes

- Dark background (`#1f242d`) with cyan (`#33ccff`) accents.
- Centered `Column` layout with `Clock` (`TextConstants`), `TextBox` for username, `PasswordBox` for password.
- Font: JetBrains Mono Nerd Font.
- Removed session selector, layout box, and power buttons for a minimal look.
- Kept `angle-down.png` for dropdown arrow icon (commented out in `Main.qml`).

## Files

| File            | Purpose                                      |
|-----------------|----------------------------------------------|
| `Main.qml`      | Main QML theme logic                         |
| `theme.conf`    | Theme configuration                          |
| `metadata.desktop` | SDDM theme metadata                      |
| `angle-down.png`| Dropdown arrow icon (unused in current QML)  |

## Notes

- Session selector, layout box, and buttons are commented out in `Main.qml`.
- `angle-down.png` is present but not actively referenced (only in commented code).

## How to implement in SDDM

1. Ensure the theme directory exists at `/usr/share/sddm/themes/custom`.
2. Verify `metadata.desktop` contains `Theme-Id=maldives`.
3. Add the following to `/etc/sddm.conf` (or a file in `/etc/sddm.conf.d/`):
   ```
   [Greeter]
   Theme=custom
   ```
4. Restart the SDDM service:
   ```
   sudo systemctl restart sddm
   ```

