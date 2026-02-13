# Ole!Ole! Website — TODO

## P0 — Bugs & Broken Things

- [x] **Logo loads from external domain** — ~~`https://www.spielplatz-mannheim.de/img/header.png` is used for the nav and footer logos.~~ Fixed: self-hosted as `img/header.png`.
- [ ] **`orbit-2` class exists in CSS but is `display: none`** — Dead code. Either remove the rule or add the element if it was intended.
- [ ] **`ring-rotate` keyframes are defined but never used** — The `@keyframes ring-rotate` isn't applied to anything. The planet ring comment says "no animation". Remove the dead keyframes.
- [ ] **Status banner has hardcoded `top: 73px`** — If the nav height changes (e.g. logo resize, responsive), the banner will overlap or leave a gap. Consider calculating this dynamically or using a stacking flow instead of fixed positioning.
- [x] **No `id` anchors on sections** — ~~Nav links all pointed to `href="#"`.~~ Fixed: nav links now point to dedicated pages (`angebote.html`, `preise.html`, `geburtstag.html`, `galerie.html`). Group section has `id="gruppen"` on `preise.html`.

## P1 — Mobile & Responsiveness

- [ ] **Build a mobile hamburger menu** — Navigation vanishes at `<=968px` with no replacement. This is the single biggest UX gap. Needs: a toggle button, a slide-out or dropdown menu, and `aria-expanded` / `aria-controls` attributes. **Applies to all 5 pages.**
- [ ] **Footer 4-column grid breaks awkwardly on tablet** — Goes from 4 to 2 columns at 968px, but the `1.5fr` brand column makes the split uneven. Consider `1fr 1fr` at tablet and stacking at mobile.
- [ ] **Floating CTA overlaps content on small screens** — The fixed `bottom: 2rem; right: 2rem` button can cover footer links or pricing. Consider hiding it when the user scrolls to the footer, or shifting it on very small viewports.
- [ ] **USP strip diamond icons overflow on narrow screens** — The rotated diamond icons (`transform: rotate(45deg)`) with absolute `::before` pseudo-elements can clip or overflow the strip container below ~400px. Test and fix.
- [ ] **`planet-container` has no `max-width` below 600px** — At 600px the planet is 280px, but on 320px screens it may still overflow.

## P2 — Accessibility (A11y)

- [ ] **Missing skip-to-content link** — No way for keyboard/screen reader users to bypass navigation and jump to main content. Add `<a href="#main" class="skip-link">Zum Inhalt springen</a>` before the nav, and `id="main"` on a `<main>` wrapper. **All 5 pages.**
- [ ] **No `<main>` landmark** — All section content sits directly in `<body>`. Wrap sections in a `<main>` element for proper landmark navigation. **All 5 pages.**
- [ ] **Nav links lack `aria-current="page"`** — The active page link uses `class="active"` but has no `aria-current="page"` for screen readers. **All 5 pages.**
- [ ] **"Aktuell geöffnet" status has no `aria-label`** — The pulsing green dot is purely visual. Add `aria-label="Aktuell geöffnet"` or `role="status"` to the container.
- [ ] **Floating CTA has no accessible label** — The `🎂` emoji link has no `aria-label`. Screen readers will just announce the emoji. Add `aria-label="Geburtstag reservieren"`. **All 5 pages.**
- [ ] **Social links are emoji-only** — `📘`, `📸`, `✉️` have no text alternatives. Add `aria-label="Facebook"`, `aria-label="Instagram"`, `aria-label="E-Mail"`. **All 5 pages.**
- [ ] **Color contrast on muted text** — Several places use `rgba(255,255,255,0.4)` to `0.6` on dark backgrounds. Check these pass WCAG AA (4.5:1 ratio). The footer-bottom text (`0.4` opacity) and `.feature-text` (`0.6`) are likely failing.
- [ ] **Birthday card button has no focus styles** — `.birthday-card-btn` transitions on hover but has no `:focus-visible` outline.
- [ ] **General lack of `:focus-visible` styles** — No custom focus indicators anywhere. Browsers provide defaults, but the dark theme may make them invisible. Add visible focus rings on all interactive elements.

## P2 — SEO & Meta

- [ ] **Missing `<meta name="description">`** — No meta description for search engines on any page. Add one per page summarizing the content.
- [ ] **Missing Open Graph / social tags** — No `og:title`, `og:description`, `og:image` for link previews on WhatsApp, Facebook, etc. Important for a family business that relies on social sharing. **All 5 pages.**
- [ ] **Missing favicon** — No `<link rel="icon">` defined. Browsers will request `/favicon.ico` and get a 404. **All 5 pages.**
- [ ] **Title includes "Retro Space"** — `Ole!Ole! Kinderspielplanet - Retro Space` on the landing page exposes the internal design theme name. Consider a customer-facing title like `Ole!Ole! Kinderspielplanet Mannheim — Indoor-Spielplatz für Kinder`. (Subpages already have good titles.)
- [ ] **No structured data (Schema.org)** — Adding `LocalBusiness` or `AmusementPark` schema markup would help Google display rich results (hours, address, price range, reviews).

## P2 — Performance

- [ ] **Grain overlay SVG filter on `body::before` with `z-index: 9999`** — This renders over the entire page on every frame. On low-end devices this can cause jank. Consider: (a) using a static noise PNG instead, (b) lowering the z-index so it doesn't composite over everything, or (c) disabling it on mobile via `prefers-reduced-motion`.
- [ ] **120 star divs with individual animations on every page** — Each star has its own CSS animation with unique custom properties. On older phones this can cause paint/composite overhead. Now duplicated across 5 pages. Consider reducing count on mobile or using a single canvas-based starfield.
- [ ] **Three fixed-position nebula blobs with `filter: blur(80px)` on every page** — Large blurred elements that are `position: fixed` force the browser to repaint on scroll. Consider making them `position: absolute` within the hero only, or using a static background image instead.
- [ ] **Google Fonts loaded with 4 weights** — `Nunito:wght@400;600;700;800` loads multiple weights. Consider if all 4 are truly needed; dropping to 2-3 would reduce font file size.
- [x] **No `font-display: swap` control** — ~~The Google Fonts URL didn't include `&display=swap`.~~ Fixed: `&display=swap` is now in the URL on all pages.

## P3 — Code Quality & Maintainability

- [ ] **Inline `style` attributes on geburtstag.html sections** — Birthday package section and photo strip use inline `style` attributes for padding/positioning. Move to CSS classes.
- [ ] **Inline `style` attribute on the footnote paragraph** — `style="margin-top: 1rem; font-size: 0.85rem; color: rgba(255,255,255,0.4);"` on landing page and preise.html. Should be a utility class or part of `.hours-card` styles.
- [ ] **Repeated `nth-child` color cycling** — USP icons and feature cards both repeat color assignments per child. Consider a CSS custom property on the parent with `nth-child` setting only `--accent`, then using `var(--accent)` everywhere.
- [ ] **`!important` overrides in nav CTA** — `.nav-cta` and `.nav-cta:hover` use 7 `!important` declarations. Increase selector specificity instead (e.g. `.nav-links .nav-cta`).
- [ ] **Some CSS comments don't match sections** — Verify all `/* === SECTION === */` headers still correspond to the right blocks after the CSS extraction.
- [x] **Consider extracting CSS to a separate file** — ~~At ~1080 lines of CSS inline, an external `style.css` would enable browser caching.~~ Done: CSS extracted to `style.css` (~1335 lines including new page styles). All 5 pages reference it.
- [ ] **Duplicate nav/footer/starfield code across 5 pages** — Nav, footer, starfield JS, and nebula divs are copy-pasted in every HTML file. Any change requires updating 5 files. Consider a templating approach or JS-based component injection.

---

## Links, Pages & Functions

### Completed

All navigation, footer, hero CTAs, birthday CTAs, group inquiry buttons, and floating CTAs have been wired up across all 5 pages:

- [x] **Navigation links** — All 6 nav links (`Startseite`, `Attraktionen`, `Preise`, `Geburtstag`, `Galerie`, `Reservieren!`) point to real pages with correct `class="active"` per page.
- [x] **Hero CTAs** — `Geburtstag feiern!` -> `geburtstag.html`, `Attraktionen entdecken` -> `attraktionen.html`.
- [x] **Birthday CTAs** — `Jetzt Geburtstag planen!` -> `geburtstag.html`, `Jetzt reservieren!` card button -> `geburtstag.html`.
- [x] **Groups CTAs** — Both `Anfrage senden` and `Jetzt anfragen` use `mailto:info@spielplatz-mannheim.de` with pre-filled subjects.
- [x] **Footer links** — Entdecken column -> `attraktionen.html`, `galerie.html`, `preise.html`. Feiern column -> `geburtstag.html`, `preise.html#gruppen`.
- [x] **Footer contact** — Phone wrapped in `<a href="tel:+4962186258963">`, email in `<a href="mailto:...">`.
- [x] **Footer email social link** — `✉️` links to `mailto:info@spielplatz-mannheim.de`.
- [x] **Floating CTA** — `🎂` links to `geburtstag.html` on all 5 pages.

### Still Needed

| Item | Status | Notes |
|---|---|---|
| **Datenschutz page** | Not started | Legally required (DSGVO/GDPR). Create `datenschutz.html` and link from all 5 footers. |
| **Impressum page** | Not started | Legally required (§5 TMG). Must contain: company name, address, contact, Geschäftsfuhrer, Handelsregister, USt-IdNr. Create `impressum.html` and link from all 5 footers. |
| **Facebook URL** | URL known | 📘 social link is `href="#"` on all 5 pages. URL: `https://www.facebook.com/Kinderspielplanet` — needs to be set on all 5 pages. |
| **Instagram URL** | Waiting for input | 📸 social link is `href="#"` on all 5 pages. Need real Instagram profile URL. |

---

## Feature Ideas & Additions

### High Impact
- [ ] **"Aktuell geöffnet" dynamic logic** — The green badge always says "Aktuell geöffnet" even outside business hours. Add simple JS to compare current time against opening hours and toggle between "Geöffnet" / "Geschlossen". **All 5 pages.**
- [ ] **WhatsApp contact button** — For a family business in Germany, a WhatsApp CTA (floating or in footer) is high-conversion. More accessible than phone for many parents.
- [ ] **Cookie/privacy banner** — Any German commercial site needs GDPR compliance. Currently there's no consent mechanism. **All 5 pages.**

### Medium Impact
- [ ] **Gallery lightbox** — Clicking a gallery image on `galerie.html` should open a fullscreen overlay with swipe navigation. Pure CSS is possible, or a tiny library like GLightbox (~3KB).
- [ ] **Video thumbnails in gallery** — Add 1-2 YouTube video thumbnails with a play button overlay in the gallery grid.
- [ ] **Scroll-triggered animations** — Sections currently appear instantly. Adding fade-in or slide-up on scroll (via `IntersectionObserver`) would add polish. Respect `prefers-reduced-motion`.
- [ ] **Google Maps embed** — The address is in the footer but there's no visual map. A small embed (or static map image linking to Google Maps) in the hours/prices section would help parents find the location.
- [ ] **Testimonials / Reviews section** — Social proof from Google Reviews or similar. A few parent quotes would build trust.

### Lower Priority
- [ ] **Print stylesheet** — Parents may want to print hours/prices. Currently the space theme with dark backgrounds would waste ink and be unreadable. Add `@media print` styles.
- [ ] **Language toggle** — Mannheim has a diverse population. Even a basic EN version could broaden reach.
- [ ] **Preloader / skeleton screen** — The starfield JS runs after page load; there's a brief flash. A simple CSS preloader could smooth the initial render.

---

## Abgleich mit Live-Website (spielplatz-mannheim.de)

Verglichen am 13.02.2026. Fehlende oder abweichende Infos gegenüber der Live-Website.

### Fehlende Infos — Preise & Konditionen

- [ ] **Senioren 65+ gratis** — Nicht in unserem Projekt erwähnt. Ergänzen auf `preise.html` (Reguläre Preise Karte).
- [ ] **Rollstuhlfahrer + Begleitung gratis** — Nicht erwähnt. Ergänzen auf `preise.html`.
- [ ] **Jugendliche 15–17 kein Eintritt** — Live-Website sagt explizit kein Zutritt für 15–17-Jährige. Hinweis auf `preise.html` ergänzen.
- [ ] **Geburtstagskind feiert gratis** — Freier Eintritt mit Nachweis. Ergänzen auf `geburtstag.html` (als Feature oder FAQ).
- [ ] **Gruppenpreise ab 20 Kindern** — Unser Projekt sagt nur "Werktags vormittags", aber die Mindestanzahl (20 Kinder) fehlt. Ergänzen auf `preise.html` und Startseite.
- [ ] **Nur EC-Karte** — Keine Mastercard/Visa akzeptiert. Wichtiger Hinweis für `preise.html`.

### Fehlende Infos — Krabbelstunde

- [ ] **Krabbelstunde: Dienstags 10:00–12:30** — Der konkrete Tag und die Uhrzeit fehlen. Ergänzen auf `preise.html` (Krabbelstunden-Karte).
- [ ] **Babys unter 12 Monate gratis** bei Krabbelstunde — Nicht separat erwähnt. Ergänzen.

### Fehlende Infos — Geburtstag

- [ ] **Menüauswahl konkretisieren** — Unser Projekt sagt nur "Pizza, Pommes, Nuggets und mehr". Die Live-Website listet 5 Optionen: Nuggets+Pommes, Geflügelwürstchen+Pommes, Salamipizza (Geflügel), Margherita, Kartoffelpuffer mit Apfelmus (jeweils 1 pro Kind). Auf `geburtstag.html` und Startseite aktualisieren.
- [ ] **Keine Deko von außen** — Keine Luftballons, Piñatas, Streamer, Konfetti erlaubt. Als FAQ auf `geburtstag.html` ergänzen.
- [ ] **Keine externen Entertainer** — Professionelle Künstler/Entertainer nicht erlaubt. Als FAQ ergänzen.

### Fehlende Infos — Hausregeln

- [ ] **Kein Essen/Trinken von außen** — Keine eigenen Speisen oder Getränke erlaubt (Ausnahme: medizinischer Bedarf, kalte Getränke in Plastikflaschen). Hinweis auf `preise.html` oder eigene Hausordnungs-Seite.
- [ ] **Keine Thermoskannen** — Explizit verboten. Zusammen mit obigem Punkt erwähnen.
- [ ] **Taschenkontrollen** — Personal darf Taschen kontrollieren. Optional erwähnen.

### Fehlende Infos — Kontakt & Social Media

- [ ] **Facebook URL einpflegen** — `https://www.facebook.com/Kinderspielplanet` → Alle 5 Footer (aktuell `href="#"`).
- [ ] **Fax-Nummer** — 0621 86258965. Optional im Footer oder Impressum ergänzen.
- [ ] **YouTube-Kanal** — Existiert laut Live-Website. URL herausfinden und ggf. Social-Links ergänzen.

### Abweichungen / Korrekturen

- [ ] **"365 Tage im Jahr" Hero-Badge** — Startseite zeigt `🚀 365 Tage im Jahr!` und Stats-Bar `365 Tage offen`. Montag ist aber geschlossen (außer Ferien). Formulierung anpassen oder entfernen.
- [ ] **Eigener Kuchen — mit Einschränkung** — Unser FAQ sagt "Ja, natürlich!" ohne Einschränkung. Die Live-Website erlaubt Kuchen, aber kein sonstiges Essen von außen. FAQ-Antwort präzisieren.

---

## Project Structure

```
.
├── oleole-retro-space.html   # Landing page (Startseite)
├── attraktionen.html          # Attractions detail page (12 cards)
├── preise.html               # Prices, hours, loyalty card, groups
├── geburtstag.html           # Birthday packages, FAQ, booking CTA
├── galerie.html              # Full photo gallery (24 images)
├── style.css                 # Shared CSS (~1335 lines)
├── resize-images.sh          # macOS image resize utility (uses sips)
├── img/
│   ├── header.png            # Logo (122x100, transparent)
│   ├── logo.png              # Alternate logo
│   ├── resized/              # 10 optimized images (landing page gallery)
│   └── gallery/
│       ├── *.jpg             # 15 original full-size images
│       └── resized/          # 15 optimized gallery images
├── README.md
└── TODO.md
```
