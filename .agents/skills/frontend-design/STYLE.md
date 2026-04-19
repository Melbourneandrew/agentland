# Project Frontend Design Identity

The user has explicitly defined the following aesthetic guidelines for the frontend design. **These must be strictly adhered to** whenever building or reviewing UI components, pages, or layouts.

## 1. Aesthetic Tone: Brutalist / Industrial
- **Vibe:** Raw, harsh lines, visible grids, system fonts, unstyled feeling.
- **Approach:** Do not hide the mechanics of the interface. Let it look like a tool or a raw system terminal.
- **Shape:** Low border radius (e.g., 2px - 4px). Avoid completely sharp corners, but strictly avoid large or pill-shaped rounded corners to maintain the industrial feel.

## 2. Theme & Color: Soft / Natural Palette (Light & Dark Mode)
- **Palette:** Soft, desaturated colors, natural/earth tones, low contrast.
- **Modes:** Must fully support both **Light Mode** and **Dark Mode**. Adapt the natural/earth tones accordingly (e.g., soft beige/sand/sage in light mode, muted olive/dark slate/charcoal in dark mode).
- **Application:** Instead of typical brutalist high-contrast (black/white), use a muted, softer, organic color palette. Combine raw shapes with soft natural colors.

## 3. Layout & Typography: Technical & Magazine-style
- **Typography:** Use the **IBM Plex** font family (e.g., IBM Plex Mono for technical/data elements, IBM Plex Sans for body text). 
- **Layout:** Heavy use of solid borders, visible grid lines separating content, and UI components placed inside obvious, distinct boxes. Think of a technical manual or an engineering schematic.

## 4. Motion & Details: Zero Motion / Raw
- **Animation:** None. Instant snaps, zero transitions.
- **Interactions:** Hover states should instantly snap (e.g., background color change, border inversion) without any `transition` duration. Raw functionality is prioritized over smooth micro-interactions.

---
**CRITICAL:** When generating frontend code, strictly ignore generic AI styles (like floating cards, heavy drop shadows, large rounded corners, or purple gradients) and instead fully commit to this specific brutalist, earth-toned, technical, zero-motion aesthetic.