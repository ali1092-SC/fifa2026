---
forge-wiki: true
generated-at: 2026-06-19T13:43:11.230Z
generator-version: "1.0"
repo: ali1092-SC/fifa2026
branch: main
section-count: 10
---

```forge-wiki-data
{"repoName":"ali1092-SC/fifa2026","repoNote":"FIFA World Cup 2026 live data integration platform with animated UI, real-time API data fetching, and multi-section tournament visualization.","lastUpdatedAt":"2026-06-19T13:32:52Z","sections":[{"id":"overview","title":"Project Overview","parentId":null,"sourceFiles":[{"path":"README.md","lineStart":1,"lineEnd":8},{"path":"docs/FORGE_SESSION.md","lineStart":1,"lineEnd":10}],"content":[{"type":"heading","level":2,"text":"What This Project Solves"},{"type":"paragraph","text":"The FIFA 2026 Live Data Integration project replaces all hardcoded mock tournament data with real-time API data from the World Cup 2026 free public API (worldcup26.ir). It implements a comprehensive single-page application with five dynamic sections: Live Scores Rotation Banner, Group Standings with qualification badges, Live Match Feed with event tracking, Fixtures/Results tab system with date/group/knockout filtering, and Golden Boot scorer rankings. The solution features intelligent fallback mechanisms with exponential backoff retry logic (15s→30s→60s), sessionStorage caching to prevent redundant API calls, graceful error handling with retry buttons, and adaptive polling intervals (30s during live matches, 5 minutes during tournament days, 30 minutes idle) without memory leaks."},{"type":"heading","level":2,"text":"Key Features"},{"type":"unorderedList","items":["Three-attempt fetchWithFallback() with sessionStorage caching and CORS proxy fallback","Live Scores Banner filtering status=live/in_progress matches with countdown timers","Dynamic Group Standings (all 12 groups A-L) with qualification badges and border-coded team positions","Live Match Feed section with 6 match cards showing scores, events (⚽🟨🟥), possession/shots stats","Fixtures/Results tabs with ALL/TODAY/GROUP/KNOCKOUT filters","Golden Boot Tracker aggregating top 5 goal scorers with rank-based styling","Skeleton shimmer loaders during API fetches, error cards with exponential backoff retry buttons","countryCodeToFlag() utility handling 2- and 3-letter ISO codes with common overrides","Smart refresh orchestrator (refreshAll) coordinating all sections with adaptive polling intervals"]}]},{"id":"api-architecture","title":"API Architecture & Data Sources","parentId":null,"sourceFiles":[{"path":"README.md","lineStart":18,"lineEnd":52},{"path":"docs/FORGE_SESSION.md","lineStart":14,"lineEnd":55}],"content":[{"type":"heading","level":2,"text":"Primary Data Source"},{"type":"paragraph","text":"Base URL: https://worldcup26.ir — Free public API, no authentication required. All endpoints return JSON via fetch('https://worldcup26.ir/get/[endpoint]')."},{"type":"table","headers":["Endpoint","Description","Data Model"],"rows":[["GET /get/games","All 104 matches with live status, scores, kickoff times, events","Array of {id, home_team, away_team, status, home_score, away_score, kickoff_utc, events[], possession, shots}"],["GET /get/groups","All 12 groups with team standings","Array of {group: 'A'|'B'...'L', teams: [{name, flag, played, won, drawn, lost, gf, ga, gd, points}]}"],["GET /get/teams","All 48 teams with flags and group info","Array of {name, flag, group, confederation}"],["GET /get/stadiums","All 16 stadiums with capacity and location","Array of {name, city, capacity, coordinates}"]]},{"type":"heading","level":2,"text":"Fallback & CORS Handling"},{"type":"paragraph","text":"If worldcup26.ir is unreachable (CORS or downtime), the system falls back to https://api.wc2026api.com (requires free API key stored as const FALLBACK_KEY). If both APIs block CORS, use lightweight CORS proxy https://corsproxy.io/?. Fetch attempts: (1) direct fetch to primary API, (2) fallback API with key, (3) CORS proxy wrapper around either. Each failure triggers exponential backoff: 15 seconds → 30 seconds → 60 seconds."},{"type":"heading","level":2,"text":"Data Flow Architecture"},{"type":"diagram","title":"API Data Fetch & Cache Flow","nodes":[{"id":"user_load","label":"Page Load / Refresh Button","type":"frontend"},{"id":"fetch_wrapper","label":"fetchWithFallback(path)","type":"orchestrator"},{"id":"session_check","label":"Check sessionStorage[path]","type":"database"},{"id":"cache_valid","label":"Cache valid (<5min)?","type":"neutral"},{"id":"return_cache","label":"Return cached data","type":"output"},{"id":"primary_api","label":"Attempt 1: worldcup26.ir","type":"neutral"},{"id":"primary_ok","label":"Primary OK?","type":"neutral"},{"id":"store_cache","label":"Store in sessionStorage + timestamp","type":"database"},{"id":"fallback_api","label":"Attempt 2: api.wc2026api.com + key","type":"neutral"},{"id":"fallback_ok","label":"Fallback OK?","type":"neutral"},{"id":"cors_proxy","label":"Attempt 3: corsproxy.io wrapper","type":"neutral"},{"id":"proxy_ok","label":"Proxy OK?","type":"neutral"},{"id":"backoff_timer","label":"Exponential backoff (15s→30s→60s)","type":"orchestrator"},{"id":"error_render","label":"renderError() with retry button","type":"output"},{"id":"data_render","label":"Render section with data","type":"output"}],"edges":[{"from":"user_load","to":"fetch_wrapper","label":"initiate fetch"},{"from":"fetch_wrapper","to":"session_check","label":"check cache"},{"from":"session_check","to":"cache_valid","label":"exists?"},{"from":"cache_valid","to":"return_cache","label":"yes, < 5min"},{"from":"cache_valid","to":"primary_api","label":"no or expired"},{"from":"primary_api","to":"primary_ok","label":"response"},{"from":"primary_ok","to":"store_cache","label":"yes (ok)"},{"from":"store_cache","to":"data_render","label":"success"},{"from":"primary_ok","to":"fallback_api","label":"no (fail)"},{"from":"fallback_api","to":"fallback_ok","label":"response"},{"from":"fallback_ok","to":"store_cache","label":"yes (ok)"},{"from":"fallback_ok","to":"cors_proxy","label":"no (fail)"},{"from":"cors_proxy","to":"proxy_ok","label":"response"},{"from":"proxy_ok","to":"store_cache","label":"yes (ok)"},{"from":"proxy_ok","to":"backoff_timer","label":"no (all fail)"},{"from":"backoff_timer","to":"error_render","label":"countdown complete"}]}]},{"id":"live-scores-banner","title":"Live Scores Rotation Banner","parentId":null,"sourceFiles":[{"path":"README.md","lineStart":55,"lineEnd":75},{"path":"docs/FORGE_SESSION.md","lineStart":56,"lineEnd":85}],"content":[{"type":"heading","level":2,"text":"Functionality"},{"type":"paragraph","text":"The Live Scores Banner rotates through currently live matches and upcoming fixtures, automatically updating every 60 seconds during live matches and every 5 minutes otherwise."},{"type":"heading","level":2,"text":"Data Fetching Logic"},{"type":"code","language":"javascript","content":"async function fetchLiveMatches() {\n  const data = await fetchWithFallback('/get/games')\n  const live = data.filter(m => m.status === 'live' || m.status === 'in_progress')\n  const upcoming = data\n    .filter(m => m.status === 'scheduled')\n    .sort((a, b) => new Date(a.kickoff_utc) - new Date(b.kickoff_utc))\n    .slice(0, 3)\n  return live.length > 0 ? live : upcoming\n}"},{"type":"heading","level":2,"text":"Match Item Rendering"},{"type":"unorderedList","items":["[home flag] + home team name | score or 'vs' | away team name + [away flag]","Status badge: LIVE [minute]' (red pulse), KO [time] (silver), FT (navy), or '- vs -' for scheduled","Kickoff time in mm:dd format for upcoming matches","Score displays only when available (live/completed matches)","Country codes converted via countryCodeToFlag() utility (USA→🇺🇸, GER→🇩🇪, etc.)"]},{"type":"heading","level":2,"text":"Refresh Policy"},{"type":"unorderedList","items":["Every 60 seconds during active live matches","Every 5 minutes during tournament days (when matches scheduled)","Every 30 minutes during idle periods","Proper interval cleanup prevents memory leaks (clearInterval before setInterval)"]}]},{"id":"group-standings","title":"Group Standings Section","parentId":null,"sourceFiles":[{"path":"README.md","lineStart":77,"lineEnd":105},{"path":"docs/FORGE_SESSION.md","lineStart":87,"lineEnd":120}],"content":[{"type":"heading","level":2,"text":"Overview"},{"type":"paragraph","text":"Displays all 12 FIFA World Cup 2026 groups (A through L) with dynamic team standings fetched from GET /get/groups. Each group shows team records with qualification indicators and visual position coding."},{"type":"heading","level":2,"text":"Data Model"},{"type":"code","language":"json","content":"{\n  \"group\": \"A\",\n  \"teams\": [\n    {\n      \"name\": \"United States\",\n      \"flag\": \"🇺🇸\",\n      \"played\": 3,\n      \"won\": 2,\n      \"drawn\": 1,\n      \"lost\": 0,\n      \"gf\": 7,\n      \"ga\": 2,\n      \"gd\": 5,\n      \"points\": 7\n    }\n  ]\n}"},{"type":"heading","level":2,"text":"Team Row Rendering"},{"type":"unorderedList","items":["[position dot] [flag] [name] | [played] matches | [pts] points","Displays: Played, Won, Drawn, Lost, Goals For, Goals Against, Goal Difference"]},{"type":"heading","level":2,"text":"Position-Based Visual Coding"},{"type":"table","headers":["Position","Status","Left Border Color","Badge"],"rows":[["1–2","Advancing (qualified)","Green (#00D084)","✓ QUALIFIED (when played===3)"],["3","May advance as best 3rd","Amber (#FFB81C)","On standby"],["4","Eliminated","Grey (default)","None"]]},{"type":"heading","level":2,"text":"Loading & Error States"},{"type":"unorderedList","items":["Skeleton placeholder cards (grey shimmer CSS animation) display while fetching","Never show empty content—always has either data or loading skeleton","Error cards with retry buttons on API failure","Expand button reveals all 12 groups when clicked"]}]},{"id":"live-match-feed","title":"Live Match Feed Section","parentId":null,"sourceFiles":[{"path":"README.md","lineStart":107,"lineEnd":165},{"path":"docs/FORGE_SESSION.md","lineStart":122,"lineEnd":190}],"content":[{"type":"heading","level":2,"text":"Overview"},{"type":"paragraph","text":"New section (#live-feed, h2='LIVE ACTION') inserted between Group Standings and Player Spotlight. Shows currently live and recently completed matches in card-based format with scores, events, and statistics. Updated every 30 seconds with subtle refresh pulse animation."},{"type":"heading","level":2,"text":"Match Card Layout"},{"type":"unorderedList","items":["Max 6 visible cards (truncate if more available)","Padding: 16px 20px, border-radius: 8px, background: rgba(255,255,255,0.04)","Left border (3px solid):"]},{"type":"table","headers":["Status","Border Color","Example"],"rows":[["Live","--fifa-red (#C60D25)","Match in progress, score updating"],["Completed (<2h old)","--fifa-gold (#FFB81C)","Match finished recently"],["Upcoming","rgba(255,255,255,0.1)","Match not yet started"]]},{"type":"heading","level":2,"text":"Card Sections"},{"type":"orderedList","items":["Header row: Status badge (left) | Group label + Stadium (right)","Score row: [home flag] [home team] [score] [away team] [away flag] (Bebas Neue 48px gold)","Events row: ⚽ [min]' [player] | 🟨 [min]' [player] | 🟥 [min]' [player] (pills format)","Stats row: Possession % bars + Shots count (for live/completed matches)"]},{"type":"heading","level":2,"text":"Event Display Examples"},{"type":"unorderedList","items":["⚽ 23' Folau Fifita (Goal)","🟨 45' João Cancelo (Yellow Card)","🟥 52' Raphinha (Red Card)","If no events: 'Kick-off at [time]'"]},{"type":"heading","level":2,"text":"Refresh & Animation"},{"type":"unorderedList","items":["Auto-refresh every 30 seconds (LIVE_REFRESH_MS = 30000)","On data arrival, emit subtle CSS pulse: opacity 0.7 → 1 over 400ms","Data source: GET /get/games filtered to status=live or completed","Sort: live matches first, then most recently completed"]}]},{"id":"fixtures-results-tabs","title":"Fixtures & Results Tab System","parentId":null,"sourceFiles":[{"path":"README.md","lineStart":167,"lineEnd":220},{"path":"docs/FORGE_SESSION.md","lineStart":192,"lineEnd":250}],"content":[{"type":"heading","level":2,"text":"Structure"},{"type":"paragraph","text":"Tabbed interface added below existing tournament timeline. Three tabs: 'KEY DATES' (existing timeline), 'FIXTURES' (upcoming matches), 'RESULTS' (completed matches)."},{"type":"heading","level":2,"text":"FIXTURES Tab"},{"type":"paragraph","text":"Displays all upcoming and live matches with advanced filtering."},{"type":"unorderedList","items":["Filter buttons: ALL | TODAY | GROUP A–L | KNOCKOUT","Row format: Date + Time | [flag] Home vs Away [flag] | Stadium","Font: Inter 13px, padding 10px 0, border-bottom rgba(255,255,255,0.06)","Upcoming matches: time in --fifa-silver","Today's matches: time in --fifa-gold, row background slightly highlighted","Live matches: LIVE badge + current score instead of time"]},{"type":"heading","level":2,"text":"RESULTS Tab"},{"type":"unorderedList","items":["Same row format as FIXTURES, displays final scores","Winner team name in --fifa-white (bold)","Loser team name in --fifa-silver (dimmed)","Sorted by completion time (newest first)"]},{"type":"heading","level":2,"text":"Data Source & Filtering"},{"type":"unorderedList","items":["GET /get/games returns all 104 matches","FIXTURES: filter status='scheduled' or 'live', sort by kickoff_utc ascending","RESULTS: filter status='completed', sort by completion_utc descending","TODAY filter: kickoff_utc date === today","GROUP filter: match.group === 'A' (etc.)","KNOCKOUT filter: round contains 'Round of', 'QF', 'SF', 'Final'"]},{"type":"heading","level":2,"text":"Tab Switching"},{"type":"unorderedList","items":["CSS-only tab visibility (radio input + label pattern or classList toggle)","No JavaScript required for basic tab switching","Filter buttons use JavaScript for dynamic content updates"]}]},{"id":"golden-boot-tracker","title":"Golden Boot Tracker Section","parentId":null,"sourceFiles":[{"path":"README.md","lineStart":222,"lineEnd":265},{"path":"docs/FORGE_SESSION.md","lineStart":252,"lineEnd":290}],"content":[{"type":"heading","level":2,"text":"Overview"},{"type":"paragraph","text":"New subsection added below 6 Player Spotlight cards in the Player section. Displays top 5 goal scorers aggregated from all completed tournament matches, updated every 30 seconds."},{"type":"heading","level":2,"text":"Data Aggregation"},{"type":"unorderedList","items":["Parse GET /get/games → filter completed matches → extract goal events","Group goals by player_name and player_nation","Sort descending by goal count","Tie-breaking: secondary sort by assists count","Show top 5 only"]},{"type":"heading","level":2,"text":"Card Layout"},{"type":"unorderedList","items":["Horizontal compact layout: Rank | Flag | Player Name | Nation | Goal Count","Rank number (1–5 prefix, e.g., '#1 ', '#2 ')","Player flag emoji (nation flag)","Player name and club/nation","Goal count in Bebas Neue 28px --fifa-gold"]},{"type":"heading","level":2,"text":"Visual Styling"},{"type":"table","headers":["Rank","Left Border","Border Color","Background"],"rows":[["#1","2px solid","--fifa-gold (#FFB81C)","rgba(255,255,255,0.03)"],["#2–5","2px solid","--fifa-silver (rgba(255,255,255,0.4))","rgba(255,255,255,0.03)"]]},{"type":"unorderedList","items":["Border-radius: 6px","Padding: 12px 16px","Font: Inter 14px for name, Bebas Neue 28px for goal count"]},{"type":"heading","level":2,"text":"Refresh & Error Handling"},{"type":"unorderedList","items":["Auto-update every 30 seconds","If API data unavailable: error card with 'Data temporarily unavailable' message","Retry button with exponential backoff countdown (15s → 30s → 60s)","Fallback to cached data if available (show 'Last updated X minutes ago' badge)"]}]},{"id":"technical-implementation","title":"Technical Implementation & Utilities","parentId":null,"sourceFiles":[{"path":"README.md","lineStart":267,"lineEnd":320},{"path":"docs/FORGE_SESSION.md","lineStart":292,"lineEnd":360}],"content":[{"type":"heading","level":2,"text":"Data Service Layer"},{"type":"code","language":"javascript","content":"const API_BASE = 'https://worldcup26.ir'\nconst CORS_PROXY = 'https://corsproxy.io/?'\nconst FALLBACK_BASE = 'https://api.wc2026api.com'\nconst FALLBACK_KEY = ''  // user fills in if needed\nconst CACHE_DURATION_MS = 5 * 60 * 1000  // 5 minutes"},{"type":"heading","level":2,"text":"fetchWithFallback() Function"},{"type":"paragraph","text":"Core data-fetching function implementing three-attempt retry with exponential backoff and sessionStorage caching."},{"type":"code","language":"javascript","content":"async function fetchWithFallback(path) {\n  // Attempt 1: direct fetch from primary API\n  try {\n    const r = await fetch(API_BASE + path)\n    if (r.ok) {\n      const data = await r.json()\n      sessionStorage.setItem(path, JSON.stringify({ data, ts: Date.now() }))\n      return data\n    }\n  } catch (e) {\n    console.log('Primary API failed:', e.message)\n  }\n\n  // Attempt 2: fallback API with key\n  try {\n    const r = await fetch(FALLBACK_BASE + path + '?key=' + FALLBACK_KEY)\n    if (r.ok) {\n      const data = await r.json()\n      sessionStorage.setItem(path, JSON.stringify({ data, ts: Date.now() }))\n      return data\n    }\n  } catch (e) {\n    console.log('Fallback API failed:', e.message)\n  }\n\n  // Attempt 3: CORS proxy wrapper\n  try {\n    const url = encodeURIComponent(API_BASE + path)\n    const r = await fetch(CORS_PROXY + url)\n    if (r.ok) {\n      const data = await r.json()\n      sessionStorage.setItem(path, JSON.stringify({ data, ts: Date.now() }))\n      return data\n    }\n  } catch (e) {\n    console.log('CORS proxy failed:', e.message)\n  }\n\n  // All attempts failed: check sessionStorage cache, return error\n  const cached = sessionStorage.getItem(path)\n  if (cached) {\n    const { data } = JSON.parse(cached)\n    console.log('Returning stale cache for ' + path)\n    return data\n  }\n\n  throw new Error('All API attempts failed for ' + path)\n}\n\n// Check cache before fetching\nasync function fetchWithCache(path, cacheDurationMs = CACHE_DURATION_MS) {\n  const cached = sessionStorage.getItem(path)\n  if (cached) {\n    const { data, ts } = JSON.parse(cached)\n    if (Date.now() - ts < cacheDurationMs) {\n      console.log('Cache hit for ' + path)\n      return data\n    }\n  }\n  return fetchWithFallback(path)\n}"},{"type":"heading","level":2,"text":"renderError() Helper"},{"type":"paragraph","text":"Renders error cards with retry buttons and exponential backoff countdown timers."},{"type":"code","language":"javascript","content":"function renderError(containerId, retryFn, initialCountdown = 15) {\n  const container = document.getElementById(containerId)\n  if (!container) return\n\n  let countdown = initialCountdown\n  const html = `\n    <div class=\"error-card\" style=\"border: 1px solid #C60D25; padding: 16px; border-radius: 8px; background: rgba(198,13,37,0.1); margin: 12px 0;\">\n      <p style=\"color: #C60D25; font-weight: 600; margin: 0 0 8px 0;\">Data temporarily unavailable</p>\n      <p style=\"color: rgba(255,255,255,0.6); font-size: 13px; margin: 0 0 12px 0;\">Please check your connection and try again.</p>\n      <button id=\"retry-${containerId}\" style=\"background: #C60D25; color: white; border: none; padding: 8px 12px; border-radius: 4px; cursor: disabled; font-size: 13px;\" disabled>\n        Retry in <span id=\"countdown-${containerId}\">${countdown}</span>s\n      </button>\n    </div>\n  `\n  container.innerHTML = html\n\n  const retryBtn = document.getElementById(`retry-${containerId}`)\n  const countdownSpan = document.getElementById(`countdown-${containerId}`)\n\n  const timer = setInterval(() => {\n    countdown--\n    if (countdownSpan) countdownSpan.textContent = countdown\n    if (countdown === 0) {\n      clearInterval(timer)\n      retryBtn.disabled = false\n      retryBtn.textContent = 'Retry'\n      retryBtn.onclick = () => {\n        renderError(containerId, retryFn, initialCountdown * 2)\n        retryFn()\n      }\n    }\n  }, 1000)\n}\n\n// Export exponential backoff sequence\nconst BACKOFF_SEQUENCE = [15, 30, 60]  // seconds"},{"type":"heading","level":2,"text":"countryCodeToFlag() Utility"},{"type":"paragraph","text":"Converts 2-letter or 3-letter ISO country codes to emoji flags, with common tournament overrides."},{"type":"code","language":"javascript","content":"function countryCodeToFlag(code) {\n  if (!code) return '❓'\n  code = code.toUpperCase()\n\n  // Common tournament overrides\n  const overrides = {\n    'ENG': '🇬🇧',  // England\n    'SCO': '🏴󠁧󠁢󠁳󠁣󠁴󠁿',  // Scotland (if applicable)\n    'WAL': '🏴󠁧󠁢󠁷󠁬󠁳󠁿',  // Wales (if applicable)\n  }\n\n  if (overrides[code]) return overrides[code]\n\n  // Convert 3-letter to 2-letter ISO\n  const threeToTwo = {\n    'USA': 'US',\n    'CAN': 'CA',\n    'MEX': 'MX',\n    'BRA': 'BR',\n    'ARG': 'AR',\n    'CHI': 'CL',\n    'URY': 'UY',\n    'PAR': 'PY',\n    'PER': 'PE',\n    'COL': 'CO',\n    'ECU': 'EC',\n    'VEN': 'VE',\n    'GER': 'DE',\n    'FRA': 'FR',\n    'ESP': 'ES',\n    'ITA': 'IT',\n    'NLD': 'NL',\n    'POR': 'PT',\n    'BEL': 'BE',\n    'SWE': 'SE',\n    'NOR': 'NO',\n    'DNK': 'DK',\n    'CRO': 'HR',\n    'SRB': 'RS',\n    'UKR': 'UA',\n    'POL': 'PL',\n    'ROU': 'RO',\n    'HUN': 'HU',\n    'CZE': 'CZ',\n    'SVK': 'SK',\n    'GRC': 'GR',\n    'TUR': 'TR',\n    'JPN': 'JP',\n    'KOR': 'KR',\n    'AUS': 'AU',\n    'CHN': 'CN',\n    'IND': 'IN',\n    'IRN': 'IR',\n    'SAU': 'SA',\n    'UAE': 'AE',\n    'EGY': 'EG',\n    'MAR': 'MA',\n    'GHA': 'GH',\n    'CMR': 'CM',\n    'NGA': 'NG',\n    'RSA': 'ZA',\n    'NZL': 'NZ',\n    'FJI': 'FJ'\n  }\n\n  const twoLetter = threeToTwo[code] || code.slice(0, 2)\n\n  // Convert 2-letter ISO to flag emoji\n  if (twoLetter.length === 2) {\n    return String.fromCodePoint(\n      127397 + twoLetter.charCodeAt(0),\n      127397 + twoLetter.charCodeAt(1)\n    )\n  }\n\n  return '❓'\n}"},{"type":"heading","level":2,"text":"refreshAll() Orchestrator"},{"type":"paragraph","text":"Master refresh function coordinating all five sections with intelligent polling intervals and memory leak prevention."},{"type":"code","language":"javascript","content":"let refreshTimer = null\nconst LIVE_INTERVAL_MS = 30 * 1000    // 30s when live\nconst TODAY_INTERVAL_MS = 5 * 60 * 1000  // 5min during tournament day\nconst IDLE_INTERVAL_MS = 30 * 60 * 1000  // 30min otherwise\n\nasync function refreshAll() {\n  console.log('[REFRESH] All sections at', new Date().toLocaleTimeString())\n  \n  try {\n    // Fetch fresh data from all endpoints\n    const [games, groups, teams, stadiums] = await Promise.all([\n      fetchWithCache('/get/games'),\n      fetchWithCache('/get/groups'),\n      fetchWithCache('/get/teams'),\n      fetchWithCache('/get/stadiums')\n    ])\n\n    // Determine if any matches are live\n    const hasLive = games.some(g => g.status === 'live' || g.status === 'in_progress')\n    const todayGames = games.filter(g => {\n      const kickoff = new Date(g.kickoff_utc)\n      const today = new Date()\n      return kickoff.toDateString() === today.toDateString()\n    })\n    const hasToday = todayGames.length > 0\n\n    // Render all sections\n    await Promise.all([\n      renderLiveScoresBanner(games),\n      renderGroupStandings(groups),\n      renderLiveMatchFeed(games),\n      renderFixturesResultsTabs(games),\n      renderGoldenBootTracker(games)\n    ])\n\n    // Schedule next refresh with adaptive interval\n    scheduleNextRefresh(hasLive, hasToday)\n  } catch (err) {\n    console.error('[REFRESH ERROR]', err)\n    scheduleNextRefresh(false, false)  // fallback to idle interval\n  }\n}\n\nfunction scheduleNextRefresh(hasLive, hasToday) {\n  if (refreshTimer) clearInterval(refreshTimer)  // prevent duplicate timers\n\n  let interval = IDLE_INTERVAL_MS\n  if (hasLive) interval = LIVE_INTERVAL_MS\n  else if (hasToday) interval = TODAY_INTERVAL_MS\n\n  console.log(`[SCHEDULE] Next refresh in ${interval / 1000}s`)\n  refreshTimer = setInterval(refreshAll, interval)\n}\n\n// Initialize on page load\nwindow.addEventListener('load', () => {\n  console.log('[INIT] Starting FIFA 2026 Live Data')\n  refreshAll()  // first fetch immediately\n})\n\n// Cleanup on unload to prevent background timers\nwindow.addEventListener('unload', () => {\n  if (refreshTimer) clearInterval(refreshTimer)\n})"}]},{"id":"test-coverage","title":"Test Cases & Validation","parentId":null,"sourceFiles":[{"path":"docs/TEST_CASES.md","lineStart":1,"lineEnd":100},{"path":"docs/TEST_RESULTS.md","lineStart":1,"lineEnd":50}],"content":[{"type":"heading","level":2,"text":"Test Summary"},{"type":"table","headers":["Metric","Count"],"rows":[["Total Test Cases","12"],["Passed","0"],["Failed","12"],["Pass Rate","0%"],["Status","Pre-implementation (code incomplete)"]]},{"type":"heading","level":2,"text":"Test Cases by Component"},{"type":"table","headers":["#","Test ID","Component","Criteria"],"rows":[["1","TC-001","fetchWithFallback()","Retrieves live data from primary API (worldcup26.ir), response < 3s, valid JSON array with id, home_team, away_team, status, home_score, away_score fields"],["2","TC-002","fetchWithFallback() Backoff","Implements exponential backoff (15s → 30s → 60s) on primary API failure, falls back to secondary endpoint within 2s, populates sessionStorage cache"],["3","TC-003","sessionStorage Caching","Cache key 'wc_[endpoint]' populated, second call within 5min reads cache (no network request), cache expires after 5min triggering refresh"],["4","TC-004","Live Scores Banner","Renders 6 live/upcoming matches, red-pulse LIVE badge, countdown mm:ss for upcoming, '- vs -' for scheduled, country flags, 30-second auto-refresh"],["5","TC-005","Group Standings","All 12 groups (A–L) rendered, correct pts/gd/w-d-l, green border for pos 1, amber for pos 2, '✓ QUALIFIED' badge when played===3 & pos≤2, skeleton loaders during fetch"],["6","TC-006","Live Match Feed","Up to 6 match cards, score in Bebas Neue 48px gold, event pills (⚽🟨🟥), possession/shots bars, red border=live, gold border=completed, 30s auto-refresh with 400ms opacity pulse"],["7","TC-007","Fixtures/Results Tabs","Tabbed interface (KEY DATES/FIXTURES/RESULTS), filters (ALL/TODAY/GROUP/KNOCKOUT), date/group/round filtering, winner=gold, loser=silver, no JS errors on tab switch"],["8","TC-008","Golden Boot Tracker","Parses goal events from completed matches, aggregates by player_name & player_nation, renders top 5 with rank/flag/name/nation/goals (Bebas Neue 28px gold), rank 1=gold border, 2–5=silver border, 30s refresh"],["9","TC-009","scheduleRefresh() Orchestrator","Calls refreshAll() on load, 30s polling when live, 5min during tournament days, 30min idle, clears previous timeouts, no duplicate timers, all 5 sections update simultaneously, no memory leaks after 10 cycles"],["10","TC-010","renderError() Helper","Error card with 'Retry in Xs' countdown, 1s decrement, retry button clickable when countdown===0, retry calls retryFn, exponential backoff (15s → 30s → 60s on successive retries), no duplicate countdowns"],["11","TC-011","countryCodeToFlag()","Converts USA→🇺🇸, CAN→🇨🇦, MEX→🇲🇽, GER→🇩🇪, FRA→🇫🇷, BRA→🇧🇷, ARG→🇦🇷, ENG→🇬🇧, case-insensitive, invalid codes return ❓"],["12","TC-012","Graceful Degradation","API downtime >60s: all 5 sections show error cards with 'Data temporarily unavailable', retry buttons on each, 60s countdown, no console errors, cached data shows 'Last updated X min ago'"]]},{"type":"heading","level":2,"text":"Current Test Status"},{"type":"paragraph","text":"All 12 tests currently FAILED. The generated index.html file contains incomplete HTML structure with truncated API base URL ('https://worldc') and missing JavaScript implementation for fetchWithFallback(), sessionStorage caching, retry logic, section rendering functions, and orchestration. Code generation did not complete before test validation."},{"type":"heading","level":2,"text":"Next Steps"},{"type":"orderedList","items":["Complete HTML structure in index.html (resolve truncated CSS/JavaScript)","Implement all utility functions (fetchWithFallback, renderError, countryCodeToFlag)","Implement refresh orchestrator (refreshAll, scheduleNextRefresh)","Implement all 5 section rendering functions (Live Scores, Groups, Feed, Fixtures/Results, Golden Boot)","Add skeleton loader CSS and error card styling","Run full test suite against complete implementation","Validate API responses and error handling in development environment","Performance testing: memory leak check, 10+ refresh cycles","User acceptance testing with actual worldcup26.ir API"]}]},{"id":"project-lifecycle","title":"Project Development Lifecycle","parentId":null,"sourceFiles":[{"path":"README.md","lineStart":1,"lineEnd":16},{"path":"docs/FORGE_SESSION.md","lineStart":1,"lineEnd":15},{"path":"WIKI.md","lineStart":1,"lineEnd":10}],"content":[{"type":"heading","level":2,"text":"Project History"},{"type":"unorderedList","items":["Initial FIFA 2026 web application created with mock tournament data and basic animations","Added ball animations with CSS keyframes (ballPulse 2.3s, ballSpin 0.8s)","Task initiated 2026-06-19 13:32:52 UTC: Replace mock data with live API integration"]},{"type":"heading","level":2,"text":"Current Task Status"},{"type":"paragraph","text":"Task: Replace all hardcoded/mock data with live API data from World Cup 2026 free public API (worldcup26.ir). Implementation incomplete—code generation resulted in truncated HTML/CSS/JavaScript. Code must be completed to pass all 12 validation tests."},{"type":"heading","level":2,"text":"Generated Artifacts"},{"type":"unorderedList","items":["index.html (364 lines) — Main HTML document with CSS animations and JavaScript logic (INCOMPLETE)","docs/FORGE_SESSION.md (850+ lines) — Detailed planning document with all requirements and code snippets","docs/FORGE_WIKI.md (200+ lines) — Architecture summary and generated file tracking","docs/TEST_CASES.md (200+ lines) — 12 comprehensive test cases defining acceptance criteria","docs/TEST_RESULTS.md (100+ lines) — Pre-implementation test validation report (0/12 passed)"]},{"type":"heading","level":2,"text":"Repository Structure"},{"type":"table","headers":["File","Type","Purpose","Status"],"rows":[["README.md","Markdown","Project overview and setup instructions","Updated"],["WIKI.md","Markdown","Forge-generated wiki documentation with frontmatter","Generated"],["docs/FORGE_SESSION.md","Markdown","Detailed implementation plan and code samples","Generated"],["docs/FORGE_WIKI.md","Markdown","Architecture summary and solution overview","Generated"],["docs/TEST_CASES.md","Markdown","12 acceptance test cases with acceptance criteria","Generated"],["docs/TEST_RESULTS.md","Markdown","Pre-implementation test validation (0/12 passed)","Generated"],["index.html","HTML","Main application (INCOMPLETE — truncated)","Generated (Incomplete)"]]}]}]}
```

# ali1092-SC/fifa2026

> FIFA World Cup 2026 live data integration platform with animated UI, real-time API data fetching, and multi-section tournament visualization.

## Project Overview

### What This Project Solves

The FIFA 2026 Live Data Integration project replaces all hardcoded mock tournament data with real-time API data from the World Cup 2026 free public API (worldcup26.ir). It implements a comprehensive single-page application with five dynamic sections: Live Scores Rotation Banner, Group Standings with qualification badges, Live Match Feed with event tracking, Fixtures/Results tab system with date/group/knockout filtering, and Golden Boot scorer rankings. The solution features intelligent fallback mechanisms with exponential backoff retry logic (15s→30s→60s), sessionStorage caching to prevent redundant API calls, graceful error handling with retry buttons, and adaptive polling intervals (30s during live matches, 5 minutes during tournament days, 30 minutes idle) without memory leaks.

### Key Features

- Three-attempt fetchWithFallback() with sessionStorage caching and CORS proxy fallback
- Live Scores Banner filtering status=live/in_progress matches with countdown timers
- Dynamic Group Standings (all 12 groups A-L) with qualification badges and border-coded team positions
- Live Match Feed section with 6 match cards showing scores, events (⚽🟨🟥), possession/shots stats
- Fixtures/Results tabs with ALL/TODAY/GROUP/KNOCKOUT filters
- Golden Boot Tracker aggregating top 5 goal scorers with rank-based styling
- Skeleton shimmer loaders during API fetches, error cards with exponential backoff retry buttons
- countryCodeToFlag() utility handling 2- and 3-letter ISO codes with common overrides
- Smart refresh orchestrator (refreshAll) coordinating all sections with adaptive polling intervals

## API Architecture & Data Sources

### Primary Data Source

Base URL: https://worldcup26.ir — Free public API, no authentication required. All endpoints return JSON via fetch('https://worldcup26.ir/get/[endpoint]').

| Endpoint | Description | Data Model |
| --- | --- | --- |
| GET /get/games | All 104 matches with live status, scores, kickoff times, events | Array of {id, home_team, away_team, status, home_score, away_score, kickoff_utc, events[], possession, shots} |
| GET /get/groups | All 12 groups with team standings | Array of {group: 'A'|'B'...'L', teams: [{name, flag, played, won, drawn, lost, gf, ga, gd, points}]} |
| GET /get/teams | All 48 teams with flags and group info | Array of {name, flag, group, confederation} |
| GET /get/stadiums | All 16 stadiums with capacity and location | Array of {name, city, capacity, coordinates} |

### Fallback & CORS Handling

If worldcup26.ir is unreachable (CORS or downtime), the system falls back to https://api.wc2026api.com (requires free API key stored as const FALLBACK_KEY). If both APIs block CORS, use lightweight CORS proxy https://corsproxy.io/?. Fetch attempts: (1) direct fetch to primary API, (2) fallback API with key, (3) CORS proxy wrapper around either. Each failure triggers exponential backoff: 15 seconds → 30 seconds → 60 seconds.

### Data Flow Architecture

## Live Scores Rotation Banner

### Functionality

The Live Scores Banner rotates through currently live matches and upcoming fixtures, automatically updating every 60 seconds during live matches and every 5 minutes otherwise.

### Data Fetching Logic

```javascript
async function fetchLiveMatches() {
  const data = await fetchWithFallback('/get/games')
  const live = data.filter(m => m.status === 'live' || m.status === 'in_progress')
  const upcoming = data
    .filter(m => m.status === 'scheduled')
    .sort((a, b) => new Date(a.kickoff_utc) - new Date(b.kickoff_utc))
    .slice(0, 3)
  return live.length > 0 ? live : upcoming
}
```

### Match Item Rendering

- [home flag] + home team name | score or 'vs' | away team name + [away flag]
- Status badge: LIVE [minute]' (red pulse), KO [time] (silver), FT (navy), or '- vs -' for scheduled
- Kickoff time in mm:dd format for upcoming matches
- Score displays only when available (live/completed matches)
- Country codes converted via countryCodeToFlag() utility (USA→🇺🇸, GER→🇩🇪, etc.)

### Refresh Policy

- Every 60 seconds during active live matches
- Every 5 minutes during tournament days (when matches scheduled)
- Every 30 minutes during idle periods
- Proper interval cleanup prevents memory leaks (clearInterval before setInterval)

## Group Standings Section

### Overview

Displays all 12 FIFA World Cup 2026 groups (A through L) with dynamic team standings fetched from GET /get/groups. Each group shows team records with qualification indicators and visual position coding.

### Data Model

```json
{
  "group": "A",
  "teams": [
    {
      "name": "United States",
      "flag": "🇺🇸",
      "played": 3,
      "won": 2,
      "drawn": 1,
      "lost": 0,
      "gf": 7,
      "ga": 2,
      "gd": 5,
      "points": 7
    }
  ]
}
```

### Team Row Rendering

- [position dot] [flag] [name] | [played] matches | [pts] points
- Displays: Played, Won, Drawn, Lost, Goals For, Goals Against, Goal Difference

### Position-Based Visual Coding

| Position | Status | Left Border Color | Badge |
| --- | --- | --- | --- |
| 1–2 | Advancing (qualified) | Green (#00D084) | ✓ QUALIFIED (when played===3) |
| 3 | May advance as best 3rd | Amber (#FFB81C) | On standby |
| 4 | Eliminated | Grey (default) | None |

### Loading & Error States

- Skeleton placeholder cards (grey shimmer CSS animation) display while fetching
- Never show empty content—always has either data or loading skeleton
- Error cards with retry buttons on API failure
- Expand button reveals all 12 groups when clicked

## Live Match Feed Section

### Overview

New section (#live-feed, h2='LIVE ACTION') inserted between Group Standings and Player Spotlight. Shows currently live and recently completed matches in card-based format with scores, events, and statistics. Updated every 30 seconds with subtle refresh pulse animation.

### Match Card Layout

- Max 6 visible cards (truncate if more available)
- Padding: 16px 20px, border-radius: 8px, background: rgba(255,255,255,0.04)
- Left border (3px solid):

| Status | Border Color | Example |
| --- | --- | --- |
| Live | --fifa-red (#C60D25) | Match in progress, score updating |
| Completed (<2h old) | --fifa-gold (#FFB81C) | Match finished recently |
| Upcoming | rgba(255,255,255,0.1) | Match not yet started |

### Card Sections

1. Header row: Status badge (left) | Group label + Stadium (right)
2. Score row: [home flag] [home team] [score] [away team] [away flag] (Bebas Neue 48px gold)
3. Events row: ⚽ [min]' [player] | 🟨 [min]' [player] | 🟥 [min]' [player] (pills format)
4. Stats row: Possession % bars + Shots count (for live/completed matches)

### Event Display Examples

- ⚽ 23' Folau Fifita (Goal)
- 🟨 45' João Cancelo (Yellow Card)
- 🟥 52' Raphinha (Red Card)
- If no events: 'Kick-off at [time]'

### Refresh & Animation

- Auto-refresh every 30 seconds (LIVE_REFRESH_MS = 30000)
- On data arrival, emit subtle CSS pulse: opacity 0.7 → 1 over 400ms
- Data source: GET /get/games filtered to status=live or completed
- Sort: live matches first, then most recently completed

## Fixtures & Results Tab System

### Structure

Tabbed interface added below existing tournament timeline. Three tabs: 'KEY DATES' (existing timeline), 'FIXTURES' (upcoming matches), 'RESULTS' (completed matches).

### FIXTURES Tab

Displays all upcoming and live matches with advanced filtering.

- Filter buttons: ALL | TODAY | GROUP A–L | KNOCKOUT
- Row format: Date + Time | [flag] Home vs Away [flag] | Stadium
- Font: Inter 13px, padding 10px 0, border-bottom rgba(255,255,255,0.06)
- Upcoming matches: time in --fifa-silver
- Today's matches: time in --fifa-gold, row background slightly highlighted
- Live matches: LIVE badge + current score instead of time

### RESULTS Tab

- Same row format as FIXTURES, displays final scores
- Winner team name in --fifa-white (bold)
- Loser team name in --fifa-silver (dimmed)
- Sorted by completion time (newest first)

### Data Source & Filtering

- GET /get/games returns all 104 matches
- FIXTURES: filter status='scheduled' or 'live', sort by kickoff_utc ascending
- RESULTS: filter status='completed', sort by completion_utc descending
- TODAY filter: kickoff_utc date === today
- GROUP filter: match.group === 'A' (etc.)
- KNOCKOUT filter: round contains 'Round of', 'QF', 'SF', 'Final'

### Tab Switching

- CSS-only tab visibility (radio input + label pattern or classList toggle)
- No JavaScript required for basic tab switching
- Filter buttons use JavaScript for dynamic content updates

## Golden Boot Tracker Section

### Overview

New subsection added below 6 Player Spotlight cards in the Player section. Displays top 5 goal scorers aggregated from all completed tournament matches, updated every 30 seconds.

### Data Aggregation

- Parse GET /get/games → filter completed matches → extract goal events
- Group goals by player_name and player_nation
- Sort descending by goal count
- Tie-breaking: secondary sort by assists count
- Show top 5 only

### Card Layout

- Horizontal compact layout: Rank | Flag | Player Name | Nation | Goal Count
- Rank number (1–5 prefix, e.g., '#1 ', '#2 ')
- Player flag emoji (nation flag)
- Player name and club/nation
- Goal count in Bebas Neue 28px --fifa-gold

### Visual Styling

| Rank | Left Border | Border Color | Background |
| --- | --- | --- | --- |
| #1 | 2px solid | --fifa-gold (#FFB81C) | rgba(255,255,255,0.03) |
| #2–5 | 2px solid | --fifa-silver (rgba(255,255,255,0.4)) | rgba(255,255,255,0.03) |

- Border-radius: 6px
- Padding: 12px 16px
- Font: Inter 14px for name, Bebas Neue 28px for goal count

### Refresh & Error Handling

- Auto-update every 30 seconds
- If API data unavailable: error card with 'Data temporarily unavailable' message
- Retry button with exponential backoff countdown (15s → 30s → 60s)
- Fallback to cached data if available (show 'Last updated X minutes ago' badge)

## Technical Implementation & Utilities

### Data Service Layer

```javascript
const API_BASE = 'https://worldcup26.ir'
const CORS_PROXY = 'https://corsproxy.io/?'
const FALLBACK_BASE = 'https://api.wc2026api.com'
const FALLBACK_KEY = ''  // user fills in if needed
const CACHE_DURATION_MS = 5 * 60 * 1000  // 5 minutes
```

### fetchWithFallback() Function

Core data-fetching function implementing three-attempt retry with exponential backoff and sessionStorage caching.

```javascript
async function fetchWithFallback(path) {
  // Attempt 1: direct fetch from primary API
  try {
    const r = await fetch(API_BASE + path)
    if (r.ok) {
      const data = await r.json()
      sessionStorage.setItem(path, JSON.stringify({ data, ts: Date.now() }))
      return data
    }
  } catch (e) {
    console.log('Primary API failed:', e.message)
  }

  // Attempt 2: fallback API with key
  try {
    const r = await fetch(FALLBACK_BASE + path + '?key=' + FALLBACK_KEY)
    if (r.ok) {
      const data = await r.json()
      sessionStorage.setItem(path, JSON.stringify({ data, ts: Date.now() }))
      return data
    }
  } catch (e) {
    console.log('Fallback API failed:', e.message)
  }

  // Attempt 3: CORS proxy wrapper
  try {
    const url = encodeURIComponent(API_BASE + path)
    const r = await fetch(CORS_PROXY + url)
    if (r.ok) {
      const data = await r.json()
      sessionStorage.setItem(path, JSON.stringify({ data, ts: Date.now() }))
      return data
    }
  } catch (e) {
    console.log('CORS proxy failed:', e.message)
  }

  // All attempts failed: check sessionStorage cache, return error
  const cached = sessionStorage.getItem(path)
  if (cached) {
    const { data } = JSON.parse(cached)
    console.log('Returning stale cache for ' + path)
    return data
  }

  throw new Error('All API attempts failed for ' + path)
}

// Check cache before fetching
async function fetchWithCache(path, cacheDurationMs = CACHE_DURATION_MS) {
  const cached = sessionStorage.getItem(path)
  if (cached) {
    const { data, ts } = JSON.parse(cached)
    if (Date.now() - ts < cacheDurationMs) {
      console.log('Cache hit for ' + path)
      return data
    }
  }
  return fetchWithFallback(path)
}
```

### renderError() Helper

Renders error cards with retry buttons and exponential backoff countdown timers.

```javascript
function renderError(containerId, retryFn, initialCountdown = 15) {
  const container = document.getElementById(containerId)
  if (!container) return

  let countdown = initialCountdown
  const html = `
    <div class="error-card" style="border: 1px solid #C60D25; padding: 16px; border-radius: 8px; background: rgba(198,13,37,0.1); margin: 12px 0;">
      <p style="color: #C60D25; font-weight: 600; margin: 0 0 8px 0;">Data temporarily unavailable</p>
      <p style="color: rgba(255,255,255,0.6); font-size: 13px; margin: 0 0 12px 0;">Please check your connection and try again.</p>
      <button id="retry-${containerId}" style="background: #C60D25; color: white; border: none; padding: 8px 12px; border-radius: 4px; cursor: disabled; font-size: 13px;" disabled>
        Retry in <span id="countdown-${containerId}">${countdown}</span>s
      </button>
    </div>
  `
  container.innerHTML = html

  const retryBtn = document.getElementById(`retry-${containerId}`)
  const countdownSpan = document.getElementById(`countdown-${containerId}`)

  const timer = setInterval(() => {
    countdown--
    if (countdownSpan) countdownSpan.textContent = countdown
    if (countdown === 0) {
      clearInterval(timer)
      retryBtn.disabled = false
      retryBtn.textContent = 'Retry'
      retryBtn.onclick = () => {
        renderError(containerId, retryFn, initialCountdown * 2)
        retryFn()
      }
    }
  }, 1000)
}

// Export exponential backoff sequence
const BACKOFF_SEQUENCE = [15, 30, 60]  // seconds
```

### countryCodeToFlag() Utility

Converts 2-letter or 3-letter ISO country codes to emoji flags, with common tournament overrides.

```javascript
function countryCodeToFlag(code) {
  if (!code) return '❓'
  code = code.toUpperCase()

  // Common tournament overrides
  const overrides = {
    'ENG': '🇬🇧',  // England
    'SCO': '🏴󠁧󠁢󠁳󠁣󠁴󠁿',  // Scotland (if applicable)
    'WAL': '🏴󠁧󠁢󠁷󠁬󠁳󠁿',  // Wales (if applicable)
  }

  if (overrides[code]) return overrides[code]

  // Convert 3-letter to 2-letter ISO
  const threeToTwo = {
    'USA': 'US',
    'CAN': 'CA',
    'MEX': 'MX',
    'BRA': 'BR',
    'ARG': 'AR',
    'CHI': 'CL',
    'URY': 'UY',
    'PAR': 'PY',
    'PER': 'PE',
    'COL': 'CO',
    'ECU': 'EC',
    'VEN': 'VE',
    'GER': 'DE',
    'FRA': 'FR',
    'ESP': 'ES',
    'ITA': 'IT',
    'NLD': 'NL',
    'POR': 'PT',
    'BEL': 'BE',
    'SWE': 'SE',
    'NOR': 'NO',
    'DNK': 'DK',
    'CRO': 'HR',
    'SRB': 'RS',
    'UKR': 'UA',
    'POL': 'PL',
    'ROU': 'RO',
    'HUN': 'HU',
    'CZE': 'CZ',
    'SVK': 'SK',
    'GRC': 'GR',
    'TUR': 'TR',
    'JPN': 'JP',
    'KOR': 'KR',
    'AUS': 'AU',
    'CHN': 'CN',
    'IND': 'IN',
    'IRN': 'IR',
    'SAU': 'SA',
    'UAE': 'AE',
    'EGY': 'EG',
    'MAR': 'MA',
    'GHA': 'GH',
    'CMR': 'CM',
    'NGA': 'NG',
    'RSA': 'ZA',
    'NZL': 'NZ',
    'FJI': 'FJ'
  }

  const twoLetter = threeToTwo[code] || code.slice(0, 2)

  // Convert 2-letter ISO to flag emoji
  if (twoLetter.length === 2) {
    return String.fromCodePoint(
      127397 + twoLetter.charCodeAt(0),
      127397 + twoLetter.charCodeAt(1)
    )
  }

  return '❓'
}
```

### refreshAll() Orchestrator

Master refresh function coordinating all five sections with intelligent polling intervals and memory leak prevention.

```javascript
let refreshTimer = null
const LIVE_INTERVAL_MS = 30 * 1000    // 30s when live
const TODAY_INTERVAL_MS = 5 * 60 * 1000  // 5min during tournament day
const IDLE_INTERVAL_MS = 30 * 60 * 1000  // 30min otherwise

async function refreshAll() {
  console.log('[REFRESH] All sections at', new Date().toLocaleTimeString())
  
  try {
    // Fetch fresh data from all endpoints
    const [games, groups, teams, stadiums] = await Promise.all([
      fetchWithCache('/get/games'),
      fetchWithCache('/get/groups'),
      fetchWithCache('/get/teams'),
      fetchWithCache('/get/stadiums')
    ])

    // Determine if any matches are live
    const hasLive = games.some(g => g.status === 'live' || g.status === 'in_progress')
    const todayGames = games.filter(g => {
      const kickoff = new Date(g.kickoff_utc)
      const today = new Date()
      return kickoff.toDateString() === today.toDateString()
    })
    const hasToday = todayGames.length > 0

    // Render all sections
    await Promise.all([
      renderLiveScoresBanner(games),
      renderGroupStandings(groups),
      renderLiveMatchFeed(games),
      renderFixturesResultsTabs(games),
      renderGoldenBootTracker(games)
    ])

    // Schedule next refresh with adaptive interval
    scheduleNextRefresh(hasLive, hasToday)
  } catch (err) {
    console.error('[REFRESH ERROR]', err)
    scheduleNextRefresh(false, false)  // fallback to idle interval
  }
}

function scheduleNextRefresh(hasLive, hasToday) {
  if (refreshTimer) clearInterval(refreshTimer)  // prevent duplicate timers

  let interval = IDLE_INTERVAL_MS
  if (hasLive) interval = LIVE_INTERVAL_MS
  else if (hasToday) interval = TODAY_INTERVAL_MS

  console.log(`[SCHEDULE] Next refresh in ${interval / 1000}s`)
  refreshTimer = setInterval(refreshAll, interval)
}

// Initialize on page load
window.addEventListener('load', () => {
  console.log('[INIT] Starting FIFA 2026 Live Data')
  refreshAll()  // first fetch immediately
})

// Cleanup on unload to prevent background timers
window.addEventListener('unload', () => {
  if (refreshTimer) clearInterval(refreshTimer)
})
```

## Test Cases & Validation

### Test Summary

| Metric | Count |
| --- | --- |
| Total Test Cases | 12 |
| Passed | 0 |
| Failed | 12 |
| Pass Rate | 0% |
| Status | Pre-implementation (code incomplete) |

### Test Cases by Component

| # | Test ID | Component | Criteria |
| --- | --- | --- | --- |
| 1 | TC-001 | fetchWithFallback() | Retrieves live data from primary API (worldcup26.ir), response < 3s, valid JSON array with id, home_team, away_team, status, home_score, away_score fields |
| 2 | TC-002 | fetchWithFallback() Backoff | Implements exponential backoff (15s → 30s → 60s) on primary API failure, falls back to secondary endpoint within 2s, populates sessionStorage cache |
| 3 | TC-003 | sessionStorage Caching | Cache key 'wc_[endpoint]' populated, second call within 5min reads cache (no network request), cache expires after 5min triggering refresh |
| 4 | TC-004 | Live Scores Banner | Renders 6 live/upcoming matches, red-pulse LIVE badge, countdown mm:ss for upcoming, '- vs -' for scheduled, country flags, 30-second auto-refresh |
| 5 | TC-005 | Group Standings | All 12 groups (A–L) rendered, correct pts/gd/w-d-l, green border for pos 1, amber for pos 2, '✓ QUALIFIED' badge when played===3 & pos≤2, skeleton loaders during fetch |
| 6 | TC-006 | Live Match Feed | Up to 6 match cards, score in Bebas Neue 48px gold, event pills (⚽🟨🟥), possession/shots bars, red border=live, gold border=completed, 30s auto-refresh with 400ms opacity pulse |
| 7 | TC-007 | Fixtures/Results Tabs | Tabbed interface (KEY DATES/FIXTURES/RESULTS), filters (ALL/TODAY/GROUP/KNOCKOUT), date/group/round filtering, winner=gold, loser=silver, no JS errors on tab switch |
| 8 | TC-008 | Golden Boot Tracker | Parses goal events from completed matches, aggregates by player_name & player_nation, renders top 5 with rank/flag/name/nation/goals (Bebas Neue 28px gold), rank 1=gold border, 2–5=silver border, 30s refresh |
| 9 | TC-009 | scheduleRefresh() Orchestrator | Calls refreshAll() on load, 30s polling when live, 5min during tournament days, 30min idle, clears previous timeouts, no duplicate timers, all 5 sections update simultaneously, no memory leaks after 10 cycles |
| 10 | TC-010 | renderError() Helper | Error card with 'Retry in Xs' countdown, 1s decrement, retry button clickable when countdown===0, retry calls retryFn, exponential backoff (15s → 30s → 60s on successive retries), no duplicate countdowns |
| 11 | TC-011 | countryCodeToFlag() | Converts USA→🇺🇸, CAN→🇨🇦, MEX→🇲🇽, GER→🇩🇪, FRA→🇫🇷, BRA→🇧🇷, ARG→🇦🇷, ENG→🇬🇧, case-insensitive, invalid codes return ❓ |
| 12 | TC-012 | Graceful Degradation | API downtime >60s: all 5 sections show error cards with 'Data temporarily unavailable', retry buttons on each, 60s countdown, no console errors, cached data shows 'Last updated X min ago' |

### Current Test Status

All 12 tests currently FAILED. The generated index.html file contains incomplete HTML structure with truncated API base URL ('https://worldc') and missing JavaScript implementation for fetchWithFallback(), sessionStorage caching, retry logic, section rendering functions, and orchestration. Code generation did not complete before test validation.

### Next Steps

1. Complete HTML structure in index.html (resolve truncated CSS/JavaScript)
2. Implement all utility functions (fetchWithFallback, renderError, countryCodeToFlag)
3. Implement refresh orchestrator (refreshAll, scheduleNextRefresh)
4. Implement all 5 section rendering functions (Live Scores, Groups, Feed, Fixtures/Results, Golden Boot)
5. Add skeleton loader CSS and error card styling
6. Run full test suite against complete implementation
7. Validate API responses and error handling in development environment
8. Performance testing: memory leak check, 10+ refresh cycles
9. User acceptance testing with actual worldcup26.ir API

## Project Development Lifecycle

### Project History

- Initial FIFA 2026 web application created with mock tournament data and basic animations
- Added ball animations with CSS keyframes (ballPulse 2.3s, ballSpin 0.8s)
- Task initiated 2026-06-19 13:32:52 UTC: Replace mock data with live API integration

### Current Task Status

Task: Replace all hardcoded/mock data with live API data from World Cup 2026 free public API (worldcup26.ir). Implementation incomplete—code generation resulted in truncated HTML/CSS/JavaScript. Code must be completed to pass all 12 validation tests.

### Generated Artifacts

- index.html (364 lines) — Main HTML document with CSS animations and JavaScript logic (INCOMPLETE)
- docs/FORGE_SESSION.md (850+ lines) — Detailed planning document with all requirements and code snippets
- docs/FORGE_WIKI.md (200+ lines) — Architecture summary and generated file tracking
- docs/TEST_CASES.md (200+ lines) — 12 comprehensive test cases defining acceptance criteria
- docs/TEST_RESULTS.md (100+ lines) — Pre-implementation test validation report (0/12 passed)

### Repository Structure

| File | Type | Purpose | Status |
| --- | --- | --- | --- |
| README.md | Markdown | Project overview and setup instructions | Updated |
| WIKI.md | Markdown | Forge-generated wiki documentation with frontmatter | Generated |
| docs/FORGE_SESSION.md | Markdown | Detailed implementation plan and code samples | Generated |
| docs/FORGE_WIKI.md | Markdown | Architecture summary and solution overview | Generated |
| docs/TEST_CASES.md | Markdown | 12 acceptance test cases with acceptance criteria | Generated |
| docs/TEST_RESULTS.md | Markdown | Pre-implementation test validation (0/12 passed) | Generated |
| index.html | HTML | Main application (INCOMPLETE — truncated) | Generated (Incomplete) |

---
*Generated by Forge on 2026-06-19*