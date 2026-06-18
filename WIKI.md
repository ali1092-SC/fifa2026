---
forge-wiki: true
generated-at: 2026-06-18T16:38:50.839Z
generator-version: "1.0"
repo: ali1092-SC/fifa2026
branch: main
section-count: 9
---

```forge-wiki-data
{"repoName":"ali1092-SC/fifa2026","repoNote":"A single-page web application for FIFA World Cup 2026 featuring official branding, interactive sections, and real-time tournament data visualization.","lastUpdatedAt":"2026-06-18T16:36:28Z","sections":[{"id":"overview","title":"Project Overview","parentId":null,"sourceFiles":[{"path":"README.md","lineStart":1,"lineEnd":15}],"content":[{"type":"paragraph","text":"FIFA World Cup 2026 is a single self-contained HTML file (no build tools, no npm, no frameworks) built with pure HTML, CSS, and vanilla JavaScript. It delivers an official-style single-page web application featuring the FIFA World Cup 2026 branding, animated football graphics, and interactive tournament information sections."},{"type":"paragraph","text":"The project implements a comprehensive design specification including the official 2026 logo (designed by Public Address, unveiled May 17, 2023), a color palette aligned with FIFA's visual identity, and dynamic canvas animations of footballs. The application displays tournament venues, groups, players, schedules, and a predictor tool."}]},{"id":"system-architecture","title":"System Architecture","parentId":null,"sourceFiles":[{"path":"README.md","lineStart":100,"lineEnd":250},{"path":"docs/FORGE_SESSION.md","lineStart":100,"lineEnd":250}],"content":[{"type":"heading","level":2,"text":"Frontend Architecture"},{"type":"paragraph","text":"The application is a single HTML file with embedded CSS and JavaScript. No external dependencies or build tools are required. The architecture consists of three main layers: HTML structure for semantic markup, CSS for styling and responsive design, and vanilla JavaScript for interactivity and canvas animations."},{"type":"heading","level":3,"text":"Key Components"},{"type":"unorderedList","items":["Fixed Navigation Bar (z-index: 100) with logo and section links","Hero Section with animated background and official logo","Canvas-based Animated Footballs (5 objects with physics simulation)","Live Scores Banner with real-time updates","Statistics Strip displaying tournament facts","Venues Section with stadium information","Groups Section with team groupings","Players Section featuring tournament stars","Schedule Section with match timings","Predictor Card for tournament predictions","Footer with branding and links"]},{"type":"diagram","title":"Page Structure & Data Flow","nodes":[{"id":"nav","label":"Navigation Bar","type":"neutral"},{"id":"hero","label":"Hero Section","type":"frontend"},{"id":"canvas","label":"Canvas Animation Layer","type":"neutral"},{"id":"scores","label":"Live Scores Banner","type":"frontend"},{"id":"stats","label":"Stats Strip","type":"frontend"},{"id":"venues","label":"Venues Section","type":"frontend"},{"id":"groups","label":"Groups Section","type":"frontend"},{"id":"players","label":"Players Section","type":"frontend"},{"id":"schedule","label":"Schedule Section","type":"frontend"},{"id":"predictor","label":"Predictor Card","type":"frontend"},{"id":"footer","label":"Footer","type":"neutral"}],"edges":[{"from":"nav","to":"hero","label":"navigation links"},{"from":"hero","to":"canvas","label":"background layer"},{"from":"hero","to":"scores","label":"scrolls to"},{"from":"scores","to":"stats","label":"continuous scroll"},{"from":"stats","to":"venues","label":"section nav"},{"from":"venues","to":"groups","label":"section nav"},{"from":"groups","to":"players","label":"section nav"},{"from":"players","to":"schedule","label":"section nav"},{"from":"schedule","to":"predictor","label":"section nav"},{"from":"predictor","to":"footer","label":"section nav"}]}]},{"id":"branding-identity","title":"Brand & Visual Identity","parentId":null,"sourceFiles":[{"path":"README.md","lineStart":20,"lineEnd":110},{"path":"docs/FORGE_SESSION.md","lineStart":20,"lineEnd":110}],"content":[{"type":"heading","level":2,"text":"FIFA World Cup 2026 Official Logo"},{"type":"paragraph","text":"The logo is built as a reusable inline SVG component featuring five distinct layers: stacked '2' and '6' numerals (representing 48 competing nations built from geometric units), a photorealistic FIFA World Cup Trophy, the 'FIFA' wordmark, and host nations text."},{"type":"heading","level":3,"text":"Logo Layers"},{"type":"orderedList","items":["Stacked '2' numeral (top): Bold block '2' from 6×8 grid of squares and quarter-circle arcs, height ≈55% of SVG, gold gradient fill (#f5d675→#c9a227→#a07a10)","Stacked '6' numeral (bottom): Geometric grid style, same proportions, same gold gradient fill","Trophy SVG path (centered): Pedestal with 3 tiers, tapered stem, symmetrical bowl, crown with two figures holding globe, radial gradient (#f5e88a center to #c9a227 edge), drop-shadow filter","'FIFA' wordmark: Bebas Neue font, 14% of SVG width, white fill, letter-spacing 4, diagonal-cut F styling","Host nations line: 'CANADA · MEXICO · USA', Inter 9px, #b0b8c8 fill, letter-spacing 2"]},{"type":"heading","level":3,"text":"Color Palette"},{"type":"table","headers":["CSS Variable","Hex Code","Usage"],"rows":[["--fifa-navy","#0a1628","Primary background color"],["--fifa-blue","#1a3a6e","Secondary background, accents"],["--fifa-gold","#c9a227","Primary accent, borders, highlights"],["--fifa-gold-light","#f5d675","Light accent, gradients"],["--fifa-red","#c1272d","Alert/warning color"],["--fifa-white","#f5f5f0","Text on dark backgrounds"],["--fifa-silver","#b0b8c8","Secondary text, muted UI"],["--glow-gold","0 0 40px rgba(201,162,39,0.4)","Shadow/glow effects"]]},{"type":"heading","level":3,"text":"Typography"},{"type":"table","headers":["Font Family","Usage","Google Fonts Weights"],"rows":[["Bebas Neue","Display/hero text","400"],["Inter","Body text, UI elements","300, 400, 500, 600, 700"],["Oswald","Names, labels, emphasis","400, 500, 600, 700"]]},{"type":"heading","level":3,"text":"Logo Sizing & Placement"},{"type":"table","headers":["CSS Class","Dimension","Placement"],"rows":[[".logo-hero","width: 220px","Hero section (centered, floating)"],[".logo-nav","height: 36px","Navigation bar (left side)"],[".logo-footer","width: 80px","Footer (centered)"],[".logo-stamp","width: 60px","Section cards, predictor card"],[".logo-section","height: 44px","Section headers (desktop only)"],[".logo-ticker","height: 28px","Live scores banner label"]]},{"type":"paragraph","text":"The FIFA logo is mandatory in all major sections: Navigation Bar, Hero Section, Live Scores Banner, Stats Strip, Venues Section header, Groups Section header, Players Section header, Schedule Section header, Predictor Card, and Footer."}]},{"id":"canvas-animation","title":"Canvas Animation System","parentId":null,"sourceFiles":[{"path":"README.md","lineStart":112,"lineEnd":180},{"path":"docs/FORGE_SESSION.md","lineStart":112,"lineEnd":180}],"content":[{"type":"heading","level":2,"text":"Animated Football Implementation"},{"type":"paragraph","text":"Five animated footballs render on an HTML5 Canvas element positioned as a fixed background layer. Each ball has independent physics simulation with velocity, rotation, and edge-wrapping behavior."},{"type":"heading","level":3,"text":"Canvas Configuration"},{"type":"unorderedList","items":["Element ID: canvas#ball-canvas","Position: fixed, top:0, left:0, width:100%, height:100%","Z-index: 1 (behind content, above background)","Pointer-events: none (non-interactive)","Opacity: 0.16 (subtle background effect)"]},{"type":"heading","level":3,"text":"Ball Physics Properties"},{"type":"table","headers":["Property","Range/Values","Description"],"rows":[["x, y","Random within viewport","Initial position"],["vx, vy","±0.4 to ±1.8 px/frame","Velocity vectors"],["r (radius)","16, 24, 32, 38, 44 px","5 different ball sizes"],["rotation","0","Initial rotation angle"],["rotSpeed","±0.015 to ±0.03 rad/frame","Angular velocity"]]},{"type":"heading","level":3,"text":"Ball Drawing Layers"},{"type":"orderedList","items":["Main circle: Arc with gold stroke (rgba(201,162,39,0.65)), lineWidth 1.5","5 pentagon patches: Center patch at [0, -r*0.52], 4 outer patches evenly distributed at radius r*0.52, vertex radius r*0.2, gold stroke (rgba(201,162,39,0.4)), lineWidth 1.0","Connecting lines: 5 lines from center pentagon to outer pentagons, gold stroke (rgba(201,162,39,0.2)), lineWidth 0.7","Shadow glow: ctx.shadowBlur=14, ctx.shadowColor=rgba(201,162,39,0.35)"]},{"type":"heading","level":3,"text":"Animation Loop"},{"type":"unorderedList","items":["Use requestAnimationFrame for 60 FPS rendering","Clear canvas each frame: ctx.clearRect(0,0,W,H)","Update each ball: x+=vx, y+=vy, rot+=rotSpeed","Edge wrapping: if x < -r set x = W+r (wrap all 4 edges)","Draw all balls with shadow effects","Update W,H on window resize","Cancel animation if document.hidden=true (tab not visible)","Respect prefers-reduced-motion: do not animate if matchMedia('(prefers-reduced-motion: reduce)').matches"]}]},{"id":"page-sections","title":"Page Sections","parentId":null,"sourceFiles":[{"path":"README.md","lineStart":182,"lineEnd":400},{"path":"docs/FORGE_SESSION.md","lineStart":182,"lineEnd":400}],"content":[{"type":"heading","level":2,"text":"Navigation Section"},{"type":"paragraph","text":"Fixed navigation bar spanning the top of the viewport at z-index 100. Contains the FIFA logo, navigation links, and interactive elements."},{"type":"unorderedList","items":["Position: fixed, top:0, left:0, right:0","Height: 64px with padding: 0 40px","Background: rgba(10,22,40,0.93) with backdrop-filter: blur(14px)","Border-bottom: 1px solid rgba(201,162,39,0.18), transitions on scroll","Left: Logo SVG with class='logo-nav'","Center: Navigation links (Venues | Groups | Stars | Schedule | Predictor)","Link styling: Inter 12px weight 600, uppercase, letter-spacing 0.6px, default --fifa-silver, hover/active --fifa-gold"]},{"type":"heading","level":2,"text":"Hero Section"},{"type":"paragraph","text":"Full-viewport hero section with animated background, headline text, and centered FIFA 2026 logo."},{"type":"heading","level":2,"text":"Live Scores Banner"},{"type":"paragraph","text":"Horizontal scrolling or carousel-style banner displaying real-time match scores and tournament status. Features the FIFA logo with class='logo-ticker' on the left anchor."},{"type":"heading","level":2,"text":"Statistics Strip"},{"type":"paragraph","text":"Centered display of tournament statistics (teams, venues, matches, etc.) with the FIFA logo class='logo-stamp' above the grid."},{"type":"heading","level":2,"text":"Venues Section"},{"type":"paragraph","text":"Displays host stadiums across Canada, Mexico, and USA. Section header follows brand pattern with logo (class='logo-section'), vertical gold divider, and section title. On mobile (<768px), logo is hidden."},{"type":"heading","level":2,"text":"Groups Section"},{"type":"paragraph","text":"Displays tournament group assignments with team information. Same section header branding pattern as Venues."},{"type":"heading","level":2,"text":"Players Section"},{"type":"paragraph","text":"Featured tournament stars and key players with profiles. Same section header branding pattern."},{"type":"heading","level":2,"text":"Schedule Section"},{"type":"paragraph","text":"Match schedules, dates, and tournament timeline. Same section header branding pattern."},{"type":"heading","level":2,"text":"Predictor Card"},{"type":"paragraph","text":"Interactive prediction tool with FIFA logo (class='logo-stamp') centered at top. Allows users to predict tournament outcomes."},{"type":"heading","level":2,"text":"Footer"},{"type":"paragraph","text":"Bottom section with centered FIFA logo (class='logo-footer'), copyright information, and links."},{"type":"heading","level":3,"text":"Section Brand Header Pattern"},{"type":"code","language":"html","content":"<div class=\"section-brand-row\">\n  <svg class=\"logo-section\" .../>\n  <div class=\"section-brand-divider\"></div>\n  <div class=\"section-brand-text\">\n    <span class=\"section-label\">HOST STADIUMS</span>\n    <h2 class=\"section-title\">ICONIC <em>VENUES</em></h2>\n  </div>\n</div>"},{"type":"unorderedList","items":[".section-brand-row: display flex, align-items center, gap 20px, margin-bottom 8px",".section-brand-divider: width 1px, height 44px, background --fifa-gold, opacity 0.5","On mobile (<768px): .logo-section display:none to avoid crowding"]}]},{"id":"responsive-design","title":"Responsive Design","parentId":null,"sourceFiles":[{"path":"README.md","lineStart":400,"lineEnd":500},{"path":"docs/FORGE_SESSION.md","lineStart":400,"lineEnd":500}],"content":[{"type":"heading","level":2,"text":"Mobile Breakpoints"},{"type":"unorderedList","items":["Desktop: ≥1024px - Full layout with all branding elements","Tablet: 768px - 1023px - Adjusted spacing and smaller fonts","Mobile: <768px - Compact layout, hidden section logos (.logo-section display:none), single-column content"]},{"type":"heading","level":2,"text":"Responsive Features"},{"type":"unorderedList","items":["Fixed navigation maintains consistent z-index across all screen sizes","Canvas animation scales with viewport (resize handler updates W,H)","Grid layouts adapt from multi-column (desktop) to single-column (mobile)","Logo sizes scale appropriately via CSS classes","Touch-friendly tap targets (minimum 44px height/width on mobile)","Font sizes scale with screen size using relative units"]}]},{"id":"accessibility","title":"Accessibility Features","parentId":null,"sourceFiles":[{"path":"README.md","lineStart":1,"lineEnd":400}],"content":[{"type":"heading","level":2,"text":"Motion Preferences"},{"type":"paragraph","text":"Respects user motion preferences using CSS media query prefers-reduced-motion. If user has enabled reduced motion, the canvas animation does not start and animating elements use instant transitions instead of animations."},{"type":"heading","level":2,"text":"Visibility Handling"},{"type":"paragraph","text":"Implements document visibility API to pause canvas animation when the tab is not visible (document.hidden=true) and resume when visible again. Managed via visibilitychange event listener."},{"type":"heading","level":2,"text":"Semantic HTML"},{"type":"paragraph","text":"Uses semantic HTML5 elements (<nav>, <header>, <section>, <article>, <footer>) for proper document structure and screen reader compatibility."}]},{"id":"deliverables","title":"Deliverables","parentId":null,"sourceFiles":[{"path":"README.md","lineStart":1,"lineEnd":20},{"path":"docs/FORGE_WIKI.md","lineStart":1,"lineEnd":40}],"content":[{"type":"heading","level":2,"text":"Generated Files"},{"type":"table","headers":["File","Status","Description"],"rows":[["index.html","Generated","Single self-contained HTML file with embedded CSS and JavaScript"],["README.md","Source","Project documentation and build specifications"],["docs/FORGE_SESSION.md","Generated","Forge session solution with full build prompt"],["docs/FORGE_WIKI.md","Generated","Wiki documentation of generated files"]]},{"type":"heading","level":2,"text":"Build Instructions"},{"type":"orderedList","items":["No build tools required - single HTML file","Open index.html directly in modern web browser","All CSS and JavaScript embedded within the HTML file","External resources: Google Fonts (Bebas Neue, Inter, Oswald) loaded via @import"]},{"type":"heading","level":2,"text":"Verification"},{"type":"unorderedList","items":["Review all generated code before deployment","Test canvas animation performance across browsers","Verify responsive layout on mobile, tablet, and desktop","Test accessibility features (motion preferences, keyboard navigation)","Validate semantic HTML structure","Check color contrast ratios for WCAG compliance"]}]},{"id":"technical-notes","title":"Technical Notes","parentId":null,"sourceFiles":[{"path":"docs/FORGE_WIKI.md","lineStart":1,"lineEnd":50}],"content":[{"type":"heading","level":2,"text":"Browser Compatibility"},{"type":"unorderedList","items":["Modern browsers with HTML5 Canvas support (Chrome, Firefox, Safari, Edge)","CSS Grid and Flexbox for layouts","CSS Custom Properties (CSS Variables) for theming","CSS backdrop-filter for navigation blur effect","SVG support for inline graphics and logos","requestAnimationFrame for smooth animation"]},{"type":"heading","level":2,"text":"Performance Considerations"},{"type":"unorderedList","items":["Canvas animation uses requestAnimationFrame for 60 FPS rendering","5 ball objects for balanced visual effect without performance impact","Edge wrapping prevents memory leaks from object accumulation","Fixed positioning for navigation and canvas avoids layout reflows","Opacity and blur effects optimized for GPU acceleration","Canvas animation pauses when tab is not visible"]},{"type":"heading","level":2,"text":"No External Dependencies"},{"type":"paragraph","text":"The project uses zero npm packages or build tools. All functionality is implemented with vanilla HTML, CSS, and JavaScript. Only external resource is Google Fonts loaded via @import in CSS."}]}]}
```

# ali1092-SC/fifa2026

> A single-page web application for FIFA World Cup 2026 featuring official branding, interactive sections, and real-time tournament data visualization.

## Project Overview

FIFA World Cup 2026 is a single self-contained HTML file (no build tools, no npm, no frameworks) built with pure HTML, CSS, and vanilla JavaScript. It delivers an official-style single-page web application featuring the FIFA World Cup 2026 branding, animated football graphics, and interactive tournament information sections.

The project implements a comprehensive design specification including the official 2026 logo (designed by Public Address, unveiled May 17, 2023), a color palette aligned with FIFA's visual identity, and dynamic canvas animations of footballs. The application displays tournament venues, groups, players, schedules, and a predictor tool.

## System Architecture

### Frontend Architecture

The application is a single HTML file with embedded CSS and JavaScript. No external dependencies or build tools are required. The architecture consists of three main layers: HTML structure for semantic markup, CSS for styling and responsive design, and vanilla JavaScript for interactivity and canvas animations.

#### Key Components

- Fixed Navigation Bar (z-index: 100) with logo and section links
- Hero Section with animated background and official logo
- Canvas-based Animated Footballs (5 objects with physics simulation)
- Live Scores Banner with real-time updates
- Statistics Strip displaying tournament facts
- Venues Section with stadium information
- Groups Section with team groupings
- Players Section featuring tournament stars
- Schedule Section with match timings
- Predictor Card for tournament predictions
- Footer with branding and links

## Brand & Visual Identity

### FIFA World Cup 2026 Official Logo

The logo is built as a reusable inline SVG component featuring five distinct layers: stacked '2' and '6' numerals (representing 48 competing nations built from geometric units), a photorealistic FIFA World Cup Trophy, the 'FIFA' wordmark, and host nations text.

#### Logo Layers

1. Stacked '2' numeral (top): Bold block '2' from 6×8 grid of squares and quarter-circle arcs, height ≈55% of SVG, gold gradient fill (#f5d675→#c9a227→#a07a10)
2. Stacked '6' numeral (bottom): Geometric grid style, same proportions, same gold gradient fill
3. Trophy SVG path (centered): Pedestal with 3 tiers, tapered stem, symmetrical bowl, crown with two figures holding globe, radial gradient (#f5e88a center to #c9a227 edge), drop-shadow filter
4. 'FIFA' wordmark: Bebas Neue font, 14% of SVG width, white fill, letter-spacing 4, diagonal-cut F styling
5. Host nations line: 'CANADA · MEXICO · USA', Inter 9px, #b0b8c8 fill, letter-spacing 2

#### Color Palette

| CSS Variable | Hex Code | Usage |
| --- | --- | --- |
| --fifa-navy | #0a1628 | Primary background color |
| --fifa-blue | #1a3a6e | Secondary background, accents |
| --fifa-gold | #c9a227 | Primary accent, borders, highlights |
| --fifa-gold-light | #f5d675 | Light accent, gradients |
| --fifa-red | #c1272d | Alert/warning color |
| --fifa-white | #f5f5f0 | Text on dark backgrounds |
| --fifa-silver | #b0b8c8 | Secondary text, muted UI |
| --glow-gold | 0 0 40px rgba(201,162,39,0.4) | Shadow/glow effects |

#### Typography

| Font Family | Usage | Google Fonts Weights |
| --- | --- | --- |
| Bebas Neue | Display/hero text | 400 |
| Inter | Body text, UI elements | 300, 400, 500, 600, 700 |
| Oswald | Names, labels, emphasis | 400, 500, 600, 700 |

#### Logo Sizing & Placement

| CSS Class | Dimension | Placement |
| --- | --- | --- |
| .logo-hero | width: 220px | Hero section (centered, floating) |
| .logo-nav | height: 36px | Navigation bar (left side) |
| .logo-footer | width: 80px | Footer (centered) |
| .logo-stamp | width: 60px | Section cards, predictor card |
| .logo-section | height: 44px | Section headers (desktop only) |
| .logo-ticker | height: 28px | Live scores banner label |

The FIFA logo is mandatory in all major sections: Navigation Bar, Hero Section, Live Scores Banner, Stats Strip, Venues Section header, Groups Section header, Players Section header, Schedule Section header, Predictor Card, and Footer.

## Canvas Animation System

### Animated Football Implementation

Five animated footballs render on an HTML5 Canvas element positioned as a fixed background layer. Each ball has independent physics simulation with velocity, rotation, and edge-wrapping behavior.

#### Canvas Configuration

- Element ID: canvas#ball-canvas
- Position: fixed, top:0, left:0, width:100%, height:100%
- Z-index: 1 (behind content, above background)
- Pointer-events: none (non-interactive)
- Opacity: 0.16 (subtle background effect)

#### Ball Physics Properties

| Property | Range/Values | Description |
| --- | --- | --- |
| x, y | Random within viewport | Initial position |
| vx, vy | ±0.4 to ±1.8 px/frame | Velocity vectors |
| r (radius) | 16, 24, 32, 38, 44 px | 5 different ball sizes |
| rotation | 0 | Initial rotation angle |
| rotSpeed | ±0.015 to ±0.03 rad/frame | Angular velocity |

#### Ball Drawing Layers

1. Main circle: Arc with gold stroke (rgba(201,162,39,0.65)), lineWidth 1.5
2. 5 pentagon patches: Center patch at [0, -r*0.52], 4 outer patches evenly distributed at radius r*0.52, vertex radius r*0.2, gold stroke (rgba(201,162,39,0.4)), lineWidth 1.0
3. Connecting lines: 5 lines from center pentagon to outer pentagons, gold stroke (rgba(201,162,39,0.2)), lineWidth 0.7
4. Shadow glow: ctx.shadowBlur=14, ctx.shadowColor=rgba(201,162,39,0.35)

#### Animation Loop

- Use requestAnimationFrame for 60 FPS rendering
- Clear canvas each frame: ctx.clearRect(0,0,W,H)
- Update each ball: x+=vx, y+=vy, rot+=rotSpeed
- Edge wrapping: if x < -r set x = W+r (wrap all 4 edges)
- Draw all balls with shadow effects
- Update W,H on window resize
- Cancel animation if document.hidden=true (tab not visible)
- Respect prefers-reduced-motion: do not animate if matchMedia('(prefers-reduced-motion: reduce)').matches

## Page Sections

### Navigation Section

Fixed navigation bar spanning the top of the viewport at z-index 100. Contains the FIFA logo, navigation links, and interactive elements.

- Position: fixed, top:0, left:0, right:0
- Height: 64px with padding: 0 40px
- Background: rgba(10,22,40,0.93) with backdrop-filter: blur(14px)
- Border-bottom: 1px solid rgba(201,162,39,0.18), transitions on scroll
- Left: Logo SVG with class='logo-nav'
- Center: Navigation links (Venues | Groups | Stars | Schedule | Predictor)
- Link styling: Inter 12px weight 600, uppercase, letter-spacing 0.6px, default --fifa-silver, hover/active --fifa-gold

### Hero Section

Full-viewport hero section with animated background, headline text, and centered FIFA 2026 logo.

### Live Scores Banner

Horizontal scrolling or carousel-style banner displaying real-time match scores and tournament status. Features the FIFA logo with class='logo-ticker' on the left anchor.

### Statistics Strip

Centered display of tournament statistics (teams, venues, matches, etc.) with the FIFA logo class='logo-stamp' above the grid.

### Venues Section

Displays host stadiums across Canada, Mexico, and USA. Section header follows brand pattern with logo (class='logo-section'), vertical gold divider, and section title. On mobile (<768px), logo is hidden.

### Groups Section

Displays tournament group assignments with team information. Same section header branding pattern as Venues.

### Players Section

Featured tournament stars and key players with profiles. Same section header branding pattern.

### Schedule Section

Match schedules, dates, and tournament timeline. Same section header branding pattern.

### Predictor Card

Interactive prediction tool with FIFA logo (class='logo-stamp') centered at top. Allows users to predict tournament outcomes.

### Footer

Bottom section with centered FIFA logo (class='logo-footer'), copyright information, and links.

#### Section Brand Header Pattern

```html
<div class="section-brand-row">
  <svg class="logo-section" .../>
  <div class="section-brand-divider"></div>
  <div class="section-brand-text">
    <span class="section-label">HOST STADIUMS</span>
    <h2 class="section-title">ICONIC <em>VENUES</em></h2>
  </div>
</div>
```

- .section-brand-row: display flex, align-items center, gap 20px, margin-bottom 8px
- .section-brand-divider: width 1px, height 44px, background --fifa-gold, opacity 0.5
- On mobile (<768px): .logo-section display:none to avoid crowding

## Responsive Design

### Mobile Breakpoints

- Desktop: ≥1024px - Full layout with all branding elements
- Tablet: 768px - 1023px - Adjusted spacing and smaller fonts
- Mobile: <768px - Compact layout, hidden section logos (.logo-section display:none), single-column content

### Responsive Features

- Fixed navigation maintains consistent z-index across all screen sizes
- Canvas animation scales with viewport (resize handler updates W,H)
- Grid layouts adapt from multi-column (desktop) to single-column (mobile)
- Logo sizes scale appropriately via CSS classes
- Touch-friendly tap targets (minimum 44px height/width on mobile)
- Font sizes scale with screen size using relative units

## Accessibility Features

### Motion Preferences

Respects user motion preferences using CSS media query prefers-reduced-motion. If user has enabled reduced motion, the canvas animation does not start and animating elements use instant transitions instead of animations.

### Visibility Handling

Implements document visibility API to pause canvas animation when the tab is not visible (document.hidden=true) and resume when visible again. Managed via visibilitychange event listener.

### Semantic HTML

Uses semantic HTML5 elements (<nav>, <header>, <section>, <article>, <footer>) for proper document structure and screen reader compatibility.

## Deliverables

### Generated Files

| File | Status | Description |
| --- | --- | --- |
| index.html | Generated | Single self-contained HTML file with embedded CSS and JavaScript |
| README.md | Source | Project documentation and build specifications |
| docs/FORGE_SESSION.md | Generated | Forge session solution with full build prompt |
| docs/FORGE_WIKI.md | Generated | Wiki documentation of generated files |

### Build Instructions

1. No build tools required - single HTML file
2. Open index.html directly in modern web browser
3. All CSS and JavaScript embedded within the HTML file
4. External resources: Google Fonts (Bebas Neue, Inter, Oswald) loaded via @import

### Verification

- Review all generated code before deployment
- Test canvas animation performance across browsers
- Verify responsive layout on mobile, tablet, and desktop
- Test accessibility features (motion preferences, keyboard navigation)
- Validate semantic HTML structure
- Check color contrast ratios for WCAG compliance

## Technical Notes

### Browser Compatibility

- Modern browsers with HTML5 Canvas support (Chrome, Firefox, Safari, Edge)
- CSS Grid and Flexbox for layouts
- CSS Custom Properties (CSS Variables) for theming
- CSS backdrop-filter for navigation blur effect
- SVG support for inline graphics and logos
- requestAnimationFrame for smooth animation

### Performance Considerations

- Canvas animation uses requestAnimationFrame for 60 FPS rendering
- 5 ball objects for balanced visual effect without performance impact
- Edge wrapping prevents memory leaks from object accumulation
- Fixed positioning for navigation and canvas avoids layout reflows
- Opacity and blur effects optimized for GPU acceleration
- Canvas animation pauses when tab is not visible

### No External Dependencies

The project uses zero npm packages or build tools. All functionality is implemented with vanilla HTML, CSS, and JavaScript. Only external resource is Google Fonts loaded via @import in CSS.

---
*Generated by Forge on 2026-06-18*