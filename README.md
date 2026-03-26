
  <h1>🛡️ QBCore Dynamic Admin Tag (qb-tag)</h1>
  <p><i>A hyper-optimized, lightweight, and incredibly smart 3D Admin Tag script for the QBCore Framework.</i></p>

  [![QBCore](https://img.shields.io/badge/QBCore-Framework-blue)](https://github.com/qbcore-framework)
  [![FiveM](https://img.shields.io/badge/FiveM-Resource-orange)](https://fivem.net/)
  [![Optimization](https://img.shields.io/badge/Optimization-0.00ms-brightgreen)](#)
</div>

<br>

<p align="center">
  <strong>qb-tag</strong> introduces a clean, dynamic, and fully customizable 3D text tag floating above staff members' heads, accompanied by a sleek floor marker. It uses native FiveM State Bags for zero-latency network synchronization and 0.00ms performance impact.
</p>

<hr>

## ✨ Key Features & Advantages

- 🚀 **Extreme Optimization (0.00ms idle):** Fully synchronized using modern **State Bags**. Say goodbye to heavy Client-Server callbacks! The rendering thread enters deep Sleep Mode when no active admins are nearby.
- 🇮🇱 **Native RTL / Hebrew Support (Standalone):** Includes a built-in Custom Font (`out.gfx`) within the `stream` directory. **No external font resources required!** Display perfect top-tier typography out of the box.
- 🎨 **Premium Aesthetic Design:** The 3D text is enhanced with deep Drop Shadows and refined outlines, making it perfectly legible against the bright Los Santos sun or dark nights.
- ⚙️ **Dynamic Multi-Rank System:** Add unlimited staff ranks in the Config. Assign unique texts, distinctive colors, and custom marker properties for each rank (`god`, `admin`, `mod`, etc.).
- 🛡️ **Smart Ace-Permission Backup:** A robust backend! If your QBCore permissions database fails or is misconfigured, the script flawlessly falls back to native FiveM Ace Permissions (`command`), automatically assigning tags based on server root grants.

---

## 📥 Installation

1. Download the repository and extract the folder.
2. Rename the extracted folder exactly to `qb-tag` (Recommendation: place it inside your `[qb]` directory).
3. Add the resource to your `server.cfg`:
   ```bash
   ensure qb-tag
   ```

---

## 🎮 Usage & Commands

Staff members can simply toggle their tag on and off using the in-game chat:
```text
/tag
```

> **Developer Testing:** Use `/testtag [rank_name]` (e.g., `/testtag admin`) to instantly preview physical tags on yourself without modifying database permissions!

---

## 🛠️ Configuration (`config.lua`)

Easily customize every rank, text, and color directly in `config.lua`:

```lua
Config.Tags = {
    ['god'] = {
        Text = "~r~[ Management ]~w~\nAdmin Sit - Do Not Interfere",
        MarkerColor = { r = 255, g = 0, b = 0, a = 120 }
    },
    ['admin'] = {
        Text = "~b~[ Admin ]~w~\nAdmin Sit - Do Not Interfere",
        MarkerColor = { r = 0, g = 150, b = 255, a = 120 }
    }
}
```

> 💡 **Important Tip for Hebrew/RTL Text:**
> Because the custom FiveM font engine renders text from Left-to-Right, any Hebrew text inside the `Text` variable must be written completely **backwards** to display correctly in-game. 
> Example: To display `הנהלה`, you must write `הלנהה`.

---

# 📸 Preview

![Preview 1](https://cdn.discordapp.com/attachments/1486049430443528192/1486852670462492762/image.png?ex=69c702f5&is=69c5b175&hm=1cb799323d922c1036239d5293defadd92180ef84f459873d6afc8fcba867402&)
![Preview 2](https://cdn.discordapp.com/attachments/1486049430443528192/1486852671200694313/image.png?ex=69c702f5&is=69c5b175&hm=11dce3d857a1155c26425008cbd9e5b9ba7b48a5eae33ea82ee8b5cf35cd43de&)
![Preview 3](https://cdn.discordapp.com/attachments/1486049430443528192/1486852672047939769/image.png?ex=69c702f5&is=69c5b175&hm=ab141875719fe433e966d67ca1bf77cf699639516202896e0fb7a7eadc780520&)

---

## 💻 Technical Details
- **Framework:** QBCore
- **Sync Method:** Player State Bags (`Player(src).state.adminTag`)
- **Performance Guidelines:** 0.00ms (Idle) | ~0.02ms (Active rendering within draw distance)

<hr>
<p align="center"><i>Developed with ❤️ for the FiveM Community. make sure to join my discord : https://discord.gg/PY9Vj8CrPf .</i></p>
