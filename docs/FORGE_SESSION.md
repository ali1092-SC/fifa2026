# Forge Session Solution

## Overview

The upgraded `index.html` implements all eight plan steps in a single self-contained file: a three-attempt `fetchWithFallback()` with sessionStorage caching, a `renderError()` helper with exponential backoff (15s→30s→60s), and five fully dynamic sections (Live Banner, Group Standings, Live Feed, Fixtures/Results tabs, Golden Boot) all wired into a single `refreshAll()` orchestrator that adapts its polling interval (30s live / 5min today / 30min idle) without memory leaks. Every section shows skeleton shimmer loaders while fetching and graceful error cards with retry buttons when the API is unreachable, and `countryCodeToFlag()` handles both 2- and 3-letter ISO codes including all common overrides.

## Task Description

> ## Project: FIFA World Cup 2026 — Live Data Integration
## Task: Replace all hardcoded/mock data with live API data

### Role
You are upgrading the existing index.html to pull real live data from
the World Cup 2026 free public API. Do not rewrite the page — only
replace mock data with live fetched data and add the new live feed
section. Surface a plan before changing anything. Do not start until
I type "approved".

---

## PRIMARY DATA SOURCE — Free, no API key required

Base URL: https://worldcup26.ir
All endpoints return JSON. No Authorization header needed.
Fetch with: fetch('https://worldcup26.ir/get/[endpoint]')

Available endpoints:
  GET /get/games       — all 104 matches (live status, scores, kickoff times)
  GET /get/groups      — all 12 groups with standings (pts, gd, w/d/l)
  GET /get/teams       — all 48 teams with flags and group info
  GET /get/stadiums    — all 16 stadiums with capacity and city

FALLBACK — if worldcup26.ir is unreachable (CORS or downtime):
  Base URL: https://api.wc2026api.com
  Requires free API key — store as const API_KEY = '[USER_FILLS_IN]'
  GET /matches    — all fixtures + live scores
  GET /standings  — group standings
  GET /teams      — team list

CORS note: If either API blocks browser fetch due to CORS, use a
  lightweight CORS proxy:
  fetch('https://corsproxy.io/?' + encodeURIComponent(url))
  Try direct fetch first; fall back to corsproxy.io on failure.

---

## SECTION 1 — LIVE SCORES ROTATION BANNER (existing — upgrade)

Currently: hardcoded match array in JavaScript
Replace with: data from GET /get/games filtered to status = 'live' or
  status = 'in_progress'. If no live matches: show next 3 upcoming
  matches with countdown to kickoff.

Fetch logic:
  async function fetchLiveMatches() {
    const data = await fetchWithFallback('/get/games')
    const live = data.filter(m => m.status === 'live' ||
                                   m.status === 'in_progress')
    const upcoming = data.filter(m => m.status === 'scheduled')
      .sort((a,b) => new Date(a.kickoff) - new Date(b.kickoff))
      .slice(0, 4)
    return live.length > 0 ? live : upcoming
  }

Match item rendering from API data:
  home team flag + name | score or 'vs' | away team flag + name
  status badge: LIVE [minute]' in red pulse / KO [time] in silver / FT in navy
  If score not yet available (scheduled): show '- vs -' with kickoff time

Refresh: re-fetch every 60 seconds during live matches, every 5 minutes
  otherwise. Use clearInterval / setInterval correctly — no memory leaks.

---

## SECTION 2 — GROUP STANDINGS (existing — upgrade)

Currently: hardcoded 6 group cards with static points
Replace with: data from GET /get/groups

Each group object from API has:
  group: "A" | "B" ... "L"
  teams: [{ name, flag, played, won, drawn, lost, gf, ga, gd, points }]

Render each team row:
  [position dot] [flag] [name] [played] [pts]
  Position 1-2: green left border accent (advancing)
  Position 3: amber border (may advance as best 3rd)
  Position 4: default (eliminated)

Show top 2 qualified teams with a subtle '✓ QUALIFIED' badge
  when played === 3 and position is confirmed

Expand button still works — all 12 groups fetched and rendered.

Loading state: show skeleton placeholder cards (grey shimmer CSS animation)
  while API is fetching. Never show empty content.

---

## SECTION 3 — NEW: LIVE MATCH FEED (new section, insert after groups)

id="live-feed", h2: "LIVE <em>ACTION</em>"
Insert between group stage and player spotlight sections.

This section shows the currently live or most recently completed matches
in a card-based feed format, updated every 30 seconds.

Match feed card (one per match, max 6 visible):
  Border-left: 3px solid
    --fifa-red if status=live
    --fifa-gold if status=completed (last 2 hours)
    rgba(255,255,255,0.1) if status=upcoming
  Padding: 16px 20px, border-radius 8px
  Background: rgba(255,255,255,0.04)

  Header row:
    Status badge left (LIVE pulse / FT / [kickoff time])
    Group / round label right (e.g. "GROUP A · MATCH 3")
    Stadium name below (Inter 11px --fifa-silver)

  Score row (centered, largest element):
    [home flag] [home name] [score] [away name] [away flag]
    Score: Bebas Neue 48px --fifa-gold (or '--' if not started)
    Team names: Oswald 15px weight 600

  Match events row (goals + cards, shown as icon pills):
    ⚽ [minute]' [player name]  — for each goal event
    🟨 [minute]' [player name]  — yellow card
    🟥 [minute]' [player name]  — red card
    If no events yet: "Kick-off at [time]"

  Match stats bar (for live/completed matches):
    Possession: [home]% ██████░░░░ [away]%
    Shots: [N] — [N]
    Rendered as two mini progress bars

  Data source: GET /get/games?status=live,completed
    Filter to matches in last 24 hours or currently live
    Sort: live first, then most recently completed

Auto-refresh every 30 seconds:
  const LIVE_REFRESH_MS = 30000
  Emit a subtle CSS "refresh pulse" on the section when new data arrives
  (opacity 0.7 → 1 over 400ms)

---

## SECTION 4 — MATCH SCHEDULE / FIXTURES (new tab system, in schedule section)

The existing timeline section shows key tournament dates.
ADD a tabbed interface below the timeline:

Tab 1: "KEY DATES" — existing timeline (unchanged)
Tab 2: "FIXTURES" — live fixture list from API
Tab 3: "RESULTS" — completed matches from API

FIXTURES tab:
  Filter buttons: ALL | TODAY | GROUP A–L | KNOCKOUT
  Each fixture row:
    Date + time | [flag] Home team vs Away team [flag] | Stadium
    Font: Inter 13px, padding 10px 0, border-bottom rgba(255,255,255,0.06)
    Upcoming: time in --fifa-silver
    Today: time in --fifa-gold, row background slightly highlighted
    Live: LIVE badge + current score instead of time

RESULTS tab:
  Same row format but shows final score
  Winner team name in --fifa-white, loser in --fifa-silver

Data source: GET /get/games
  Sort fixtures by kickoff_utc ascending
  Filter results to status = 'completed'

Tab switching: CSS only — no JavaScript needed for tab visibility
  Use radio inputs + label pattern or just classList toggle

---

## SECTION 5 — GOLDEN BOOT TRACKER (new, in player spotlight)

Add a "GOLDEN BOOT" subsection below the 6 player cards.
Show top 5 scorers from the live API.

Data source: GET /get/games — parse all completed match events
  Extract goal events, count per player across all matches
  Sort descending by goal count

  If API provides a dedicated scorers endpoint: use that instead.

Top scorer card (horizontal layout, compact):
  Rank number | Flag | Player name | Club/Nation | Goals count (Bebas Neue 28px gold)
  Border-left: 2px solid gold for rank #1, silver for #2–5
  Background: rgba(255,255,255,0.03), border-radius 6px, padding 12px 16px

Tie-breaking: show assists count as secondary stat

---

## TECHNICAL IMPLEMENTATION

Data service layer (in <script> block, top of JS):
  const API_BASE = 'https://worldcup26.ir'
  const CORS_PROXY = 'https://corsproxy.io/?'
  const FALLBACK_BASE = 'https://api.wc2026api.com'
  const FALLBACK_KEY = ''   // user fills in if needed

  async function fetchWithFallback(path) {
    // Attempt 1: direct fetch
    try {
      const r = await fetch(API_BASE + path)
      if (r.ok) return r.json()
    } catch(e) {}
    // Attempt 2: via CORS proxy
    try {
      const r = await fetch(CORS_PROXY + encodeURIComponent(API_BASE + path))
      if (r.ok) return r.json()
    } catch(e) {}
    // Attempt 3: fallback API (if key provided)
    if (FALLBACK_KEY) {
      const r = await fetch(FALLBACK_BASE + path,
        { headers: { Authorization: 'Bearer ' + FALLBACK_KEY } })
      if (r.ok) return r.json()
    }
    // Return null — caller shows graceful empty state
    return null
  }

Loading states (REQUIRED for every data-dependent section):
  Show a skeleton card (CSS shimmer animation) while fetching
  .skeleton { background: linear-gradient(90deg,
    rgba(255,255,255,0.05) 25%, rgba(255,255,255,0.1) 50%,
    rgba(255,255,255,0.05) 75%) }
  @keyframes shimmer { 0%{background-position:-200%} 100%{background-position:200%} }
  Replace skeleton with real content when data resolves

Error states (REQUIRED when API returns null):
  Show a styled error card:
  "Live data temporarily unavailable. Retrying in [N]s…"
  Auto-retry after 15 seconds (exponential backoff: 15s, 30s, 60s)
  Never show a raw JS error or blank section to the user

Data caching (sessionStorage):
  Cache each API response with a timestamp key:
    sessionStorage.setItem('wc_games', JSON.stringify({data, ts: Date.now()}))
  On next fetch: if cached and age < 30s, use cache (avoids hammering API)
  Live matches: always re-fetch (bypass cache when any match is live)

Refresh intervals:
  Live matches present:    every 30 seconds
  No live matches, today: every 5 minutes
  No matches today:       every 30 minutes
  Use a single orchestrator: function scheduleRefresh(hasLive)
    clearInterval(refreshTimer)
    refreshTimer = setInterval(refreshAll, hasLive ? 30000 : 300000)

---

## FLAG RENDERING

The API returns ISO country codes (e.g. "FR", "BR", "US").
Convert to flag emoji:
  function countryCodeToFlag(code) {
    return code.toUpperCase().split('').map(c =>
      String.fromCodePoint(0x1F1E0 + c.charCodeAt(0) - 65)
    ).join('')
  }
  e.g. countryCodeToFlag('FR') → '🇫🇷'

---

## SUCCESS CRITERIA

[ ] Live scores rotation banner fetches real data from worldcup26.ir
[ ] Banner falls back gracefully if API is unreachable (shows last cached data)
[ ] Group standings fetched from API — all 12 groups, real points
[ ] Group cards show qualified/may-advance/eliminated visual indicators
[ ] NEW live match feed section renders current/recent matches
[ ] Match feed shows score, events (goals, cards), and possession bar
[ ] Match feed auto-refreshes every 30 seconds
[ ] NEW fixtures/results tabs in schedule section
[ ] Fixtures filterable by TODAY / GROUP / KNOCKOUT
[ ] Golden Boot tracker shows top 5 scorers from live data
[ ] ALL sections show skeleton loading state before data arrives
[ ] ALL sections show error + retry UI when API fails
[ ] No section ever shows empty or broken UI — always handled
[ ] sessionStorage caching prevents hammering the API
[ ] Single refresh orchestrator manages all polling intervals correctly
[ ] countryCodeToFlag() converts ISO codes to flag emoji correctly
[ ] pnpm lint and build pass (or if single HTML: no JS console errors)

---

## CONSTRAINTS
- Single index.html file — no build step, no npm
- Never hardcode match data that the API can provide
- Always show loading state — never a blank section
- Always show error + retry — never a raw JS error
- Cache API responses in sessionStorage to reduce requests
- Live match refresh: 30s · Today no live: 5min · No matches today: 30min
- CORS proxy (corsproxy.io) used only as fallback, not primary
- Do not proceed past planning without my "approved"

## Changes Made

| File | Type | Size |
|------|------|------|
| `index.html` | .html | 2263 lines |

## Setup & Usage

1. Pull the latest changes from the feature branch
2. Install dependencies: `npm install` or `pnpm install`
3. Run the development server: `npm run dev` or `pnpm dev`
4. Run tests: `npm test` or `pnpm test`
5. Build for production: `npm run build` or `pnpm build`

## Architecture Notes

- Total files generated: **1**
- Solution type: General

## Changelog

| Date | Change |
|------|--------|
| 2026-06-19 13:32:52 UTC | Initial solution generated by Forge |

---

*Generated by Forge on 2026-06-19 13:32:52 UTC*
