# Ole!Ole! Kinderspielplanet — Website

Landing page for **Ole!Ole! Kinderspielplanet**, a family entertainment center in Mannheim with 3 000 m² of indoor attractions for children ages 0–14.

## Tech Stack

- **Pure HTML / CSS / vanilla JS** — no frameworks, no build step
- **Google Fonts** — Lilita One (headings) + Nunito (body)
- Single-file site: `oleole-retro-space.html`

## Design

Retro-space theme built around a bold color palette:

| Token | Hex | Usage |
|---|---|---|
| `--magenta` | `#E8256F` | Primary accent, CTA backgrounds |
| `--teal` | `#00D4AA` | Secondary accent |
| `--yellow` | `#FFD23F` | Highlights, badges, cards |
| `--orange` | `#FF8C42` | Shadow accents |
| `--space-dark` | `#0B0E1F` | Page background, card shadows |

Key visual elements: animated starfield, floating nebula blobs, orbit rings, 3D offset-shadow cards, zigzag section dividers.

## Sections

| Section | Description |
|---|---|
| **Navigation** | Fixed top bar with logo + links (mobile nav TBD) |
| **Hero** | Headline, CTA buttons, animated planet visual |
| **Stats Bar** | Key numbers (3 000+ m², 20+ attractions, etc.) |
| **Birthday** | Party package promo with feature list + pricing card |
| **Loyalty Card** | 10-visit stamp card offer |
| **Groups** | Group booking options |
| **Gallery** | CSS Grid image gallery with lazy-loaded images |
| **Hours & Prices** | Opening hours + admission pricing |
| **Footer** | Contact info, links, legal |

## Project Structure

```
.
├── oleole-retro-space.html   # Complete site (HTML + CSS + JS)
├── resize-images.sh          # macOS image resize utility (uses sips)
├── img/
│   ├── *.jpg / *.png         # Original images
│   └── resized/              # Optimized images used by the site
└── README.md
```

## Image Optimization

A helper script resizes source images for the web:

```bash
# Default: max 1600px on longest side
./resize-images.sh

# Custom max dimension
./resize-images.sh 1200
```

Requires `sips` (ships with macOS).

## Local Development

No install required — just open the HTML file:

```bash
open oleole-retro-space.html
```

Or serve it locally for a more realistic experience:

```bash
python3 -m http.server 8000
# then visit http://localhost:8000/oleole-retro-space.html
```

## Known Limitations

- Mobile navigation is hidden with no hamburger menu fallback yet
- Several CTA links are still placeholder (`href="#"`)
- Gallery is visual-only (no lightbox / click interaction)
