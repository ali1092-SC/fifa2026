<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>FIFA.com – Official Website</title>

  <!-- Google Fonts -->
  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
  <link
    href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Inter:wght@300;400;500;600;700;800&display=swap"
    rel="stylesheet"
  />

  <style>
    /* ──────────────────────────────────────────
       CSS CUSTOM PROPERTIES  (Design Tokens)
    ────────────────────────────────────────── */
    :root {
      --color-navy:        #0a1628;
      --color-navy-mid:    #0e1e38;
      --color-navy-light:  #162240;
      --color-red:         #c8102e;
      --color-red-hover:   #a50d26;
      --color-gold:        #f0b428;
      --color-gold-light:  #ffd166;
      --color-white:       #ffffff;
      --color-grey-100:    #f5f6f8;
      --color-grey-200:    #e2e5ea;
      --color-grey-400:    #8c94a4;
      --color-grey-700:    #3a4255;
      --color-text-primary:   #ffffff;
      --color-text-secondary: #a8b2c4;

      --font-heading: 'Bebas Neue', 'Arial Narrow', sans-serif;
      --font-body:    'Inter', 'Segoe UI', Arial, sans-serif;

      --radius-sm:  4px;
      --radius-md:  8px;
      --radius-lg:  16px;
      --radius-xl:  24px;

      --shadow-card: 0 8px 32px rgba(0,0,0,.45);
      --shadow-hover: 0 16px 48px rgba(0,0,0,.6);

      --transition-fast:   150ms ease;
      --transition-normal: 280ms ease;
      --transition-slow:   450ms ease;

      --max-width: 1440px;
      --gutter: clamp(16px, 4vw, 64px);
    }

    /* ──────────────────────────────────────────
       RESET & BASE
    ────────────────────────────────────────── */
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

    html { scroll-behavior: smooth; font-size: 16px; }

    body {
      background-color: var(--color-navy);
      color: var(--color-text-primary);
      font-family: var(--font-body);
      line-height: 1.6;
      overflow-x: hidden;
      background-image:
        radial-gradient(ellipse 80% 60% at 50% -10%, rgba(200,16,46,.18) 0%, transparent 60%),
        url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='4' height='4'%3E%3Crect width='4' height='4' fill='%230a1628'/%3E%3Ccircle cx='1' cy='1' r='.4' fill='%23ffffff08'/%3E%3Ccircle cx='3' cy='3' r='.4' fill='%23ffffff06'/%3E%3C/svg%3E");
    }

    a { color: inherit; text-decoration: none; }
    img { display: block; max-width: 100%; object-fit: cover; }
    button { cursor: pointer; border: none; background: none; font-family: var(--font-body); }
    ul, ol { list-style: none; }

    /* ──────────────────────────────────────────
       UTILITY CLASSES
    ────────────────────────────────────────── */
    .container {
      max-width: var(--max-width);
      margin-inline: auto;
      padding-inline: var(--gutter);
    }

    .section-label {
      display: inline-flex;
      align-items: center;
      gap: 8px;
      font-family: var(--font-body);
      font-size: .72rem;
      font-weight: 700;
      letter-spacing: .12em;
      text-transform: uppercase;
      color: var(--color-gold);
      margin-bottom: 12px;
    }
    .section-label::before {
      content: '';
      display: block;
      width: 24px;
      height: 3px;
      background: var(--color-gold);
      border-radius: 2px;
    }

    .section-title {
      font-family: var(--font-heading);
      font-size: clamp(2rem, 5vw, 3.6rem);
      letter-spacing: .04em;
      line-height: 1;
      text-transform: uppercase;
      color: var(--color-white);
    }

    .btn {
      display: inline-flex;
      align-items: center;
      gap: 8px;
      padding: 10px 24px;
      border-radius: var(--radius-sm);
      font-weight: 600;
      font-size: .875rem;
      letter-spacing: .04em;
      text-transform: uppercase;
      transition: background var(--transition-fast), transform var(--transition-fast), box-shadow var(--transition-fast);
    }
    .btn-primary {
      background: var(--color-red);
      color: var(--color-white);
    }
    .btn-primary:hover {
      background: var(--color-red-hover);
      transform: translateY(-1px);
      box-shadow: 0 6px 20px rgba(200,16,46,.5);
    }
    .btn-outline {
      background: transparent;
      color: var(--color-white);
      border: 2px solid rgba(255,255,255,.35);
    }
    .btn-outline:hover {
      border-color: var(--color-white);
      background: rgba(255,255,255,.08);
    }
    .btn-gold {
      background: var(--color-gold);
      color: var(--color-navy);
      font-weight: 800;
    }
    .btn-gold:hover {
      background: var(--color-gold-light);
      box-shadow: 0 6px 20px rgba(240,180,40,.4);
      transform: translateY(-1px);
    }

    /* ──────────────────────────────────────────
       TOP BAR
    ────────────────────────────────────────── */
    .top-bar {
      background: #06101e;
      border-bottom: 1px solid rgba(255,255,255,.06);
      padding: 6px 0;
      font-size: .75rem;
      color: var(--color-text-secondary);
    }
    .top-bar .container {
      display: flex;
      align-items: center;
      justify-content: space-between;
      gap: 16px;
    }
    .top-bar-left { display: flex; align-items: center; gap: 20px; }
    .top-bar-right { display: flex; align-items: center; gap: 16px; }
    .top-bar a:hover { color: var(--color-gold); }
    .top-bar .live-pill {
      display: inline-flex;
      align-items: center;
      gap: 5px;
      background: var(--color-red);
      color: #fff;
      font-weight: 700;
      font-size: .65rem;
      letter-spacing: .1em;
      padding: 2px 8px;
      border-radius: 20px;
    }
    .top-bar .live-pill::before {
      content: '';
      width: 6px;
      height: 6px;
      background: #fff;
      border-radius: 50%;
      animation: blink 1s infinite;
    }
    @keyframes blink { 0%,100%{opacity:1} 50%{opacity:.3} }

    /* ──────────────────────────────────────────
       HEADER / NAVIGATION
    ────────────────────────────────────────── */
    .site-header {
      position: sticky;
      top: 0;
      z-index: 1000;
      background: rgba(10,22,40,.92);
      backdrop-filter: blur(20px) saturate(180%);
      -webkit-backdrop-filter: blur(20px) saturate(180%);
      border-bottom: 1px solid rgba(255,255,255,.08);
    }

    .nav-inner {
      display: flex;
      align-items: center;
      height: 68px;
      gap: 0;
    }

    /* FIFA Logo */
    .site-logo {
      flex-shrink: 0;
      margin-right: 40px;
      display: flex;
      align-items: center;
      gap: 10px;
    }
    .site-logo .logo-emblem {
      width: 44px;
      height: 44px;
      background: var(--color-red);
      border-radius: 6px;
      display: flex;
      align-items: center;
      justify-content: center;
      font-family: var(--font-heading);
      font-size: 1.6rem;
      color: #fff;
      letter-spacing: .05em;
    }
    .site-logo .logo-text {
      font-family: var(--font-heading);
      font-size: 2rem;
      letter-spacing: .12em;
      color: var(--color-white);
      line-height: 1;
    }

    /* Primary Nav */
    .primary-nav { display: flex; align-items: stretch; height: 100%; flex: 1; }
    .primary-nav > li { position: relative; }
    .primary-nav > li > a {
      display: flex;
      align-items: center;
      height: 100%;
      padding: 0 18px;
      font-size: .82rem;
      font-weight: 600;
      letter-spacing: .06em;
      text-transform: uppercase;
      color: var(--color-text-secondary);
      transition: color var(--transition-fast);
      white-space: nowrap;
    }
    .primary-nav > li > a:hover,
    .primary-nav > li.active > a {
      color: var(--color-white);
    }
    .primary-nav > li.active > a::after {
      content: '';
      position: absolute;
      bottom: 0;
      left: 18px;
      right: 18px;
      height: 3px;
      background: var(--color-red);
      border-radius: 2px 2px 0 0;
    }

    /* Dropdown */
    .nav-dropdown {
      position: absolute;
      top: calc(100% + 1px);
      left: 0;
      min-width: 220px;
      background: var(--color-navy-mid);
      border: 1px solid rgba(255,255,255,.08);
      border-top: 3px solid var(--color-red);
      border-radius: 0 0 var(--radius-md) var(--radius-md);
      box-shadow: var(--shadow-card);
      opacity: 0;
      visibility: hidden;
      transform: translateY(-8px);
      transition: opacity var(--transition-fast), visibility var(--transition-fast), transform var(--transition-fast);
      z-index: 200;
    }
    .primary-nav > li:hover .nav-dropdown {
      opacity: 1;
      visibility: visible;
      transform: translateY(0);
    }
    .nav-dropdown li a {
      display: block;
      padding: 10px 20px;
      font-size: .82rem;
      font-weight: 500;
      color: var(--color-text-secondary);
      transition: color var(--transition-fast), background var(--transition-fast);
    }
    .nav-dropdown li a:hover {
      color: var(--color-white);
      background: rgba(255,255,255,.05);
    }

    /* Nav right actions */
    .nav-actions {
      display: flex;
      align-items: center;
      gap: 12px;
      margin-left: auto;
      padding-left: 24px;
    }
    .nav-search-btn {
      width: 36px;
      height: 36px;
      display: flex;
      align-items: center;
      justify-content: center;
      border-radius: 50%;
      color: var(--color-text-secondary);
      transition: color var(--transition-fast), background var(--transition-fast);
    }
    .nav-search-btn:hover { color: #fff; background: rgba(255,255,255,.08); }

    /* Hamburger */
    .hamburger {
      display: none;
      width: 36px;
      height: 36px;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      gap: 5px;
    }
    .hamburger span {
      display: block;
      width: 22px;
      height: 2px;
      background: var(--color-white);
      border-radius: 2px;
      transition: transform var(--transition-normal), opacity var(--transition-normal);
    }

    /* ──────────────────────────────────────────
       HERO – AUTO-PLAY VIDEO BANNER
    ────────────────────────────────────────── */
    .hero {
      position: relative;
      overflow: hidden;
      height: clamp(480px, 82vh, 900px);
      display: flex;
      align-items: flex-end;
    }

    .hero-video-wrap {
      position: absolute;
      inset: 0;
      z-index: 0;
      overflow: hidden;
    }
    .hero-video-wrap iframe,
    .hero-video-wrap video {
      position: absolute;
      inset: 0;
      width: 100%;
      height: 100%;
      object-fit: cover;
      pointer-events: none;
    }

    /* YouTube embed – scale trick */
    .hero-video-wrap .yt-cover {
      position: absolute;
      inset: -60px;
      width: calc(100% + 120px);
      height: calc(100% + 120px);
    }

    /* Gradient overlays */
    .hero::before {
      content: '';
      position: absolute;
      inset: 0;
      background:
        linear-gradient(to bottom, rgba(10,22,40,.5) 0%, transparent 30%, rgba(10,22,40,.85) 75%, var(--color-navy) 100%);
      z-index: 1;
    }
    .hero::after {
      content: '';
      position: absolute;
      inset: 0;
      background: linear-gradient(to right, rgba(10,22,40,.7) 0%, transparent 55%);
      z-index: 1;
    }

    .hero-content {
      position: relative;
      z-index: 2;
      padding-bottom: 80px;
    }
    .hero-content .section-label { color: var(--color-gold); }
    .hero-content h1 {
      font-family: var(--font-heading);
      font-size: clamp(2.8rem, 8vw, 7rem);
      line-height: .95;
      letter-spacing: .04em;
      text-transform: uppercase;
      color: var(--color-white);
      max-width: 700px;
      text-shadow: 0 4px 24px rgba(0,0,0,.6);
    }
    .hero-content h1 span { color: var(--color-red); }
    .hero-content p {
      max-width: 520px;
      color: rgba(255,255,255,.8);
      font-size: 1.05rem;
      margin: 16px 0 28px;
    }
    .hero-actions { display: flex; gap: 12px; flex-wrap: wrap; }

    /* Hero mute / play controls */
    .hero-video-controls {
      position: absolute;
      bottom: 28px;
      right: var(--gutter);
      z-index: 3;
      display: flex;
      gap: 10px;
    }
    .hero-ctrl-btn {
      width: 44px;
      height: 44px;
      border-radius: 50%;
      background: rgba(255,255,255,.15);
      backdrop-filter: blur(10px);
      border: 1px solid rgba(255,255,255,.25);
      display: flex;
      align-items: center;
      justify-content: center;
      color: #fff;
      font-size: 1rem;
      transition: background var(--transition-fast);
    }
    .hero-ctrl-btn:hover { background: rgba(255,255,255,.28); }

    /* Hero scroll indicator */
    .hero-scroll {
      position: absolute;
      bottom: 30px;
      left: 50%;
      transform: translateX(-50%);
      z-index: 3;
      display: flex;
      flex-direction: column;
      align-items: center;
      gap: 6px;
      color: rgba(255,255,255,.5);
      font-size: .7rem;
      letter-spacing: .1em;
      text-transform: uppercase;
      animation: float 2s ease-in-out infinite;
    }
    @keyframes float { 0%,100%{transform:translateX(-50%) translateY(0)} 50%{transform:translateX(-50%) translateY(6px)} }

    /* ──────────────────────────────────────────
       TICKER / BREAKING NEWS
    ────────────────────────────────────────── */
    .ticker {
      background: var(--color-red);
      padding: 10px 0;
      overflow: hidden;
      position: relative;
    }
    .ticker-track {
      display: flex;
      animation: ticker-scroll 35s linear infinite;
      width: max-content;
    }
    .ticker-track:hover { animation-play-state: paused; }
    @keyframes ticker-scroll { 0%{transform:translateX(0)} 100%{transform:translateX(-50%)} }
    .ticker-item {
      display: flex;
      align-items: center;
      gap: 10px;
      padding: 0 40px;
      font-size: .8rem;
      font-weight: 600;
      letter-spacing: .04em;
      white-space: nowrap;
      color: #fff;
    }
    .ticker-item::after {
      content: '\25C6';
      font-size: .5rem;
      opacity: .6;
      margin-left: 30px;
    }
    .ticker-label {
      background: rgba(0,0,0,.25);
      padding: 2px 8px;
      border-radius: 3px;
      font-size: .65rem;
      letter-spacing: .1em;
      text-transform: uppercase;
    }

    /* ──────────────────────────────────────────
       FEATURED NEWS GRID (with inline videos)
    ────────────────────────────────────────── */
    .news-section { padding: 80px 0 60px; }

    .news-header {
      display: flex;
      align-items: flex-end;
      justify-content: space-between;
      margin-bottom: 40px;
      flex-wrap: wrap;
      gap: 20px;
    }

    .news-grid {
      display: grid;
      grid-template-columns: repeat(12, 1fr);
      gap: 20px;
    }

    /* Card base */
    .news-card {
      position: relative;
      overflow: hidden;
      border-radius: var(--radius-md);
      background: var(--color-navy-mid);
      box-shadow: var(--shadow-card);
      transition: transform var(--transition-normal), box-shadow var(--transition-normal);
      cursor: pointer;
    }
    .news-card:hover {
      transform: translateY(-4px);
      box-shadow: var(--shadow-hover);
    }

    .news-card--hero    { grid-column: span 8; min-height: 480px; }
    .news-card--tall    { grid-column: span 4; min-height: 480px; display: flex; flex-direction: column; }
    .news-card--medium  { grid-column: span 4; min-height: 280px; }
    .news-card--small   { grid-column: span 3; min-height: 220px; }

    /* Card video/image layer */
    .card-media {
      position: relative;
      overflow: hidden;
      flex: 1;
    }
    .news-card--hero .card-media,
    .news-card--medium .card-media { height: 100%; }
    .news-card--tall .card-media { flex: 1; }

    .card-media img,
    .card-media video,
    .card-media .card-video-thumb {
      width: 100%;
      height: 100%;
      object-fit: cover;
      transition: transform var(--transition-slow);
    }
    .news-card:hover .card-media img,
    .news-card:hover .card-video-thumb { transform: scale(1.05); }

    .card-media-overlay {
      position: absolute;
      inset: 0;
      background: linear-gradient(to top, rgba(10,22,40,.9) 0%, rgba(10,22,40,.2) 50%, transparent 100%);
    }

    /* Play button overlay */
    .play-btn-overlay {
      position: absolute;
      inset: 0;
      display: flex;
      align-items: center;
      justify-content: center;
      z-index: 2;
      opacity: 0;
      transition: opacity var(--transition-normal);
    }
    .news-card:hover .play-btn-overlay { opacity: 1; }
    .play-circle {
      width: 64px;
      height: 64px;
      border-radius: 50%;
      background: rgba(200,16,46,.9);
      border: 3px solid rgba(255,255,255,.4);
      display: flex;
      align-items: center;
      justify-content: center;
      backdrop-filter: blur(6px);
      transition: transform var(--transition-fast), background var(--transition-fast);
    }
    .play-circle:hover { transform: scale(1.1); background: var(--color-red); }
    .play-circle svg { margin-left: 4px; }

    .video-badge {
      position: absolute;
      top: 14px;
      left: 14px;
      z-index: 3;
      display: inline-flex;
      align-items: center;
      gap: 5px;
      background: var(--color-red);
      color: #fff;
      font-size: .68rem;
      font-weight: 700;
      letter-spacing: .08em;
      text-transform: uppercase;
      padding: 4px 10px;
      border-radius: 3px;
    }
    .duration-badge {
      position: absolute;
      bottom: 14px;
      right: 14px;
      z-index: 3;
      background: rgba(0,0,0,.7);
      color: #fff;
      font-size: .72rem;
      font-weight: 600;
      padding: 3px 8px;
      border-radius: 4px;
      backdrop-filter: blur(4px);
    }

    .card-body {
      padding: 20px;
    }
    .card-tag {
      display: inline-block;
      font-size: .68rem;
      font-weight: 700;
      letter-spacing: .1em;
      text-transform: uppercase;
      color: var(--color-gold);
      margin-bottom: 8px;
    }
    .card-title {
      font-family: var(--font-heading);
      font-size: clamp(1rem, 2.2vw, 1.6rem);
      letter-spacing: .03em;
      line-height: 1.1;
      text-transform: uppercase;
      color: var(--color-white);
      margin-bottom: 10px;
    }
    .card-desc {
      font-size: .82rem;
      color: var(--color-text-secondary);
      line-height: 1.5;
      display: -webkit-box;
      -webkit-line-clamp: 2;
      -webkit-box-orient: vertical;
      overflow: hidden;
    }
    .card-meta {
      display: flex;
      align-items: center;
      gap: 12px;
      margin-top: 12px;
      font-size: .72rem;
      color: var(--color-text-secondary);
    }
    .card-meta span { display: flex; align-items: center; gap: 4px; }

    /* Absolute body overlay on hero card */
    .news-card--hero .card-body {
      position: absolute;
      bottom: 0;
      left: 0;
      right: 0;
      z-index: 3;
    }
    .news-card--hero .card-media { height: 100%; position: absolute; inset: 0; }

    /* Video modal overlay */
    .video-modal {
      position: fixed;
      inset: 0;
      z-index: 9999;
      background: rgba(5,10,20,.96);
      display: flex;
      align-items: center;
      justify-content: center;
      opacity: 0;
      visibility: hidden;
      transition: opacity var(--transition-normal), visibility var(--transition-normal);
    }
    .video-modal.active { opacity: 1; visibility: visible; }
    .modal-inner {
      position: relative;
      width: min(900px, 96vw);
    }
    .modal-video-wrap {
      position: relative;
      padding-top: 56.25%;
      background: #000;
      border-radius: var(--radius-lg);
      overflow: hidden;
      box-shadow: 0 32px 80px rgba(0,0,0,.8);
    }
    .modal-video-wrap iframe {
      position: absolute;
      inset: 0;
      width: 100%;
      height: 100%;
      border: none;
    }
    .modal-close {
      position: absolute;
      top: -48px;
      right: 0;
      width: 40px;
      height: 40px;
      display: flex;
      align-items: center;
      justify-content: center;
      border-radius: 50%;
      background: rgba(255,255,255,.12);
      color: #fff;
      font-size: 1.4rem;
      transition: background var(--transition-fast);
    }
    .modal-close:hover { background: var(--color-red); }

    /* ──────────────────────────────────────────
       LATEST VIDEOS SECTION
    ────────────────────────────────────────── */
    .videos-section {
      padding: 60px 0 80px;
      background: linear-gradient(to bottom, transparent, var(--color-navy-mid), transparent);
    }

    .videos-header {
      display: flex;
      align-items: flex-end;
      justify-content: space-between;
      margin-bottom: 36px;
      flex-wrap: wrap;
      gap: 16px;
    }

    .videos-grid {
      display: grid;
      grid-template-columns: repeat(4, 1fr);
      gap: 20px;
    }

    .video-card {
      border-radius: var(--radius-md);
      overflow: hidden;
      background: var(--color-navy-light);
      box-shadow: var(--shadow-card);
      transition: transform var(--transition-normal), box-shadow var(--transition-normal);
      cursor: pointer;
    }
    .video-card:hover {
      transform: translateY(-4px);
      box-shadow: var(--shadow-hover);
    }

    .video-thumb {
      position: relative;
      padding-top: 56.25%;
      overflow: hidden;
      background: var(--color-grey-700);
    }
    .video-thumb img {
      position: absolute;
      inset: 0;
      width: 100%;
      height: 100%;
      object-fit: cover;
      transition: transform var(--transition-slow);
    }
    .video-card:hover .video-thumb img { transform: scale(1.08); }
    .video-thumb .play-overlay {
      position: absolute;
      inset: 0;
      display: flex;
      align-items: center;
      justify-content: center;
      background: rgba(10,22,40,.45);
      opacity: 0;
      transition: opacity var(--transition-normal);
    }
    .video-card:hover .play-overlay { opacity: 1; }
    .video-thumb .duration {
      position: absolute;
      bottom: 8px;
      right: 8px;
      background: rgba(0,0,0,.75);
      color: #fff;
      font-size: .7rem;
      font-weight: 600;
      padding: 2px 7px;
      border-radius: 3px;
    }

    .video-info { padding: 14px; }
    .video-tag {
      font-size: .65rem;
      font-weight: 700;
      letter-spacing: .1em;
      text-transform: uppercase;
      color: var(--color-red);
      margin-bottom: 5px;
    }
    .video-title {
      font-family: var(--font-heading);
      font-size: 1rem;
      letter-spacing: .03em;
      text-transform: uppercase;
      color: var(--color-white);
      line-height: 1.2;
      margin-bottom: 6px;
    }
    .video-date {
      font-size: .7rem;
      color: var(--color-text-secondary);
    }

    /* ──────────────────────────────────────────
       COMPETITIONS STRIP
    ────────────────────────────────────────── */
    .competitions-section { padding: 60px 0; }
    .comp-grid {
      display: grid;
      grid-template-columns: repeat(6, 1fr);
      gap: 16px;
      margin-top: 36px;
    }
    .comp-card {
      background: var(--color-navy-light);
      border: 1px solid rgba(255,255,255,.07);
      border-radius: var(--radius-md);
      padding: 28px 16px 22px;
      text-align: center;
      transition: border-color var(--transition-fast), background var(--transition-fast), transform var(--transition-fast);
      cursor: pointer;
    }
    .comp-card:hover {
      border-color: var(--color-gold);
      background: rgba(240,180,40,.06);
      transform: translateY(-3px);
    }
    .comp-card .comp-emblem {
      width: 64px;
      height: 64px;
      margin: 0 auto 14px;
      border-radius: 50%;
      overflow: hidden;
      background: var(--color-navy-mid);
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 1.8rem;
    }
    .comp-card h3 {
      font-family: var(--font-heading);
      font-size: 1rem;
      letter-spacing: .06em;
      text-transform: uppercase;
      color: var(--color-white);
      margin-bottom: 4px;
    }
    .comp-card p {
      font-size: .72rem;
      color: var(--color-text-secondary);
    }

    /* ──────────────────────────────────────────
       STANDINGS / SCORES STRIP
    ────────────────────────────────────────── */
    .scores-section {
      padding: 50px 0;
      background: var(--color-navy-mid);
      border-top: 1px solid rgba(255,255,255,.05);
      border-bottom: 1px solid rgba(255,255,255,.05);
    }
    .scores-header {
      display: flex;
      align-items: center;
      justify-content: space-between;
      margin-bottom: 28px;
      flex-wrap: wrap;
      gap: 12px;
    }
    .matches-strip {
      display: flex;
      gap: 16px;
      overflow-x: auto;
      padding-bottom: 8px;
      scrollbar-width: none;
    }
    .matches-strip::-webkit-scrollbar { display: none; }
    .match-card {
      flex-shrink: 0;
      background: var(--color-navy-light);
      border: 1px solid rgba(255,255,255,.07);
      border-radius: var(--radius-md);
      padding: 18px 20px;
      min-width: 220px;
      text-align: center;
      transition: border-color var(--transition-fast), transform var(--transition-fast);
    }
    .match-card:hover { border-color: rgba(255,255,255,.2); transform: translateY(-2px); }
    .match-competition {
      font-size: .65rem;
      font-weight: 700;
      letter-spacing: .1em;
      text-transform: uppercase;
      color: var(--color-gold);
      margin-bottom: 12px;
    }
    .match-teams {
      display: flex;
      align-items: center;
      justify-content: space-between;
      gap: 10px;
    }
    .match-team {
      display: flex;
      flex-direction: column;
      align-items: center;
      gap: 6px;
      flex: 1;
    }
    .team-flag {
      width: 36px;
      height: 36px;
      border-radius: 50%;
      background: var(--color-grey-700);
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 1.4rem;
    }
    .team-abbr {
      font-family: var(--font-heading);
      font-size: 1rem;
      letter-spacing: .06em;
      color: var(--color-white);
    }
    .match-score {
      font-family: var(--font-heading);
      font-size: 1.8rem;
      letter-spacing: .08em;
      color: var(--color-white);
      line-height: 1;
    }
    .match-score .score-sep { color: var(--color-text-secondary); margin: 0 3px; }
    .match-status {
      font-size: .68rem;
      font-weight: 700;
      letter-spacing: .08em;
      text-transform: uppercase;
      margin-top: 10px;
    }
    .match-status.live { color: var(--color-red); }
    .match-status.upcoming { color: var(--color-text-secondary); }
    .match-status.finished { color: var(--color-grey-400); }

    /* ──────────────────────────────────────────
       FIFA WORLD CUP 2026 PROMO BANNER
    ────────────────────────────────────────── */
    .wc-banner {
      margin: 60px 0;
      border-radius: var(--radius-xl);
      overflow: hidden;
      position: relative;
      min-height: 420px;
      display: flex;
      align-items: center;
      background:
        linear-gradient(135deg, rgba(10,22,40,.98) 0%, rgba(10,22,40,.75) 50%, rgba(200,16,46,.25) 100%);
      border: 1px solid rgba(255,255,255,.06);
    }
    .wc-banner::before {
      content: '';
      position: absolute;
      inset: 0;
      background: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='60' height='60'%3E%3Ccircle cx='30' cy='30' r='25' stroke='rgba(240,180,40,0.06)' stroke-width='1' fill='none'/%3E%3C/svg%3E") 0 0 / 60px 60px;
    }
    .wc-content {
      position: relative;
      z-index: 1;
      padding: 60px var(--gutter);
      max-width: 620px;
    }
    .wc-badge {
      display: inline-flex;
      align-items: center;
      gap: 8px;
      background: var(--color-gold);
      color: var(--color-navy);
      font-family: var(--font-heading);
      font-size: 1.1rem;
      letter-spacing: .08em;
      padding: 6px 16px;
      border-radius: 4px;
      margin-bottom: 20px;
    }
    .wc-content h2 {
      font-family: var(--font-heading);
      font-size: clamp(2.5rem, 7vw, 5.5rem);
      line-height: .95;
      letter-spacing: .04em;
      text-transform: uppercase;
      color: var(--color-white);
      margin-bottom: 16px;
    }
    .wc-content h2 em {
      font-style: normal;
      color: var(--color-red);
    }
    .wc-content p {
      color: rgba(255,255,255,.75);
      font-size: 1rem;
      margin-bottom: 32px;
      max-width: 480px;
    }
    .wc-actions { display: flex; gap: 12px; flex-wrap: wrap; }
    .wc-visual {
      position: absolute;
      right: -40px;
      top: 0;
      bottom: 0;
      width: 55%;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 18vw;
      opacity: .08;
      pointer-events: none;
      user-select: none;
    }

    /* ──────────────────────────────────────────
       SOCIAL / LIVE FEED SECTION
    ────────────────────────────────────────── */
    .social-section { padding: 60px 0 80px; }
    .social-grid {
      display: grid;
      grid-template-columns: 1fr 1fr 1fr;
      gap: 20px;
      margin-top: 36px;
    }
    .social-card {
      background: var(--color-navy-light);
      border: 1px solid rgba(255,255,255,.06);
      border-radius: var(--radius-md);
      padding: 22px;
      transition: border-color var(--transition-fast);
    }
    .social-card:hover { border-color: rgba(255,255,255,.16); }
    .social-platform {
      display: flex;
      align-items: center;
      gap: 10px;
      margin-bottom: 14px;
    }
    .platform-icon {
      width: 36px;
      height: 36px;
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 1rem;
    }
    .platform-icon.twitter  { background: #1d9bf0; }
    .platform-icon.instagram{ background: linear-gradient(135deg,#f58529,#dd2a7b,#8134af,#515bd4); }
    .platform-icon.youtube  { background: #ff0000; }
    .social-handle {
      font-weight: 700;
      font-size: .88rem;
      color: var(--color-white);
    }
    .social-followers {
      font-size: .72rem;
      color: var(--color-text-secondary);
    }
    .social-text {
      font-size: .85rem;
      color: rgba(255,255,255,.8);
      line-height: 1.55;
      margin-bottom: 12px;
    }
    .social-date {
      font-size: .7rem;
      color: var(--color-text-secondary);
    }

    /* ──────────────────────────────────────────
       FOOTER
    ────────────────────────────────────────── */
    .site-footer {
      background: #060d18;
      border-top: 1px solid rgba(255,255,255,.06);
      padding-top: 60px;
    }
    .footer-top {
      display: grid;
      grid-template-columns: 2fr 1fr 1fr 1fr 1fr;
      gap: 40px;
      padding-bottom: 50px;
      border-bottom: 1px solid rgba(255,255,255,.06);
    }
    .footer-brand .logo-emblem {
      width: 50px;
      height: 50px;
      background: var(--color-red);
      border-radius: 8px;
      display: flex;
      align-items: center;
      justify-content: center;
      font-family: var(--font-heading);
      font-size: 1.8rem;
      color: #fff;
      margin-bottom: 16px;
    }
    .footer-brand p {
      font-size: .82rem;
      color: var(--color-text-secondary);
      line-height: 1.65;
      max-width: 280px;
      margin-bottom: 22px;
    }
    .social-links { display: flex; gap: 10px; }
    .social-links a {
      width: 36px;
      height: 36px;
      border-radius: 50%;
      background: rgba(255,255,255,.07);
      display: flex;
      align-items: center;
      justify-content: center;
      color: var(--color-text-secondary);
      font-size: .85rem;
      transition: background var(--transition-fast), color var(--transition-fast);
    }
    .social-links a:hover { background: var(--color-red); color: #fff; }
    .footer-col h4 {
      font-family: var(--font-heading);
      font-size: 1rem;
      letter-spacing: .08em;
      text-transform: uppercase;
      color: var(--color-white);
      margin-bottom: 18px;
    }
    .footer-col ul li { margin-bottom: 10px; }
    .footer-col ul li a {
      font-size: .8rem;
      color: var(--color-text-secondary);
      transition: color var(--transition-fast);
    }
    .footer-col ul li a:hover { color: var(--color-gold); }
    .footer-bottom {
      display: flex;
      align-items: center;
      justify-content: space-between;
      padding: 22px 0;
      font-size: .75rem;
      color: var(--color-text-secondary);
      flex-wrap: wrap;
      gap: 12px;
    }
    .footer-bottom-links { display: flex; gap: 20px; }
    .footer-bottom-links a:hover { color: var(--color-white); }

    /* ──────────────────────────────────────────
       SCROLL TO TOP
    ────────────────────────────────────────── */
    .scroll-top {
      position: fixed;
      bottom: 28px;
      right: 28px;
      z-index: 800;
      width: 44px;
      height: 44px;
      border-radius: 50%;
      background: var(--color-red);
      color: #fff;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 1rem;
      box-shadow: 0 4px 16px rgba(200,16,46,.5);
      opacity: 0;
      visibility: hidden;
      transform: translateY(10px);
      transition: opacity var(--transition-normal), visibility var(--transition-normal), transform var(--transition-normal);
    }
    .scroll-top.visible { opacity: 1; visibility: visible; transform: translateY(0); }
    .scroll-top:hover { background: var(--color-red-hover); }

    /* ──────────────────────────────────────────
       LOADING OVERLAY
    ────────────────────────────────────────── */
    .page-loader {
      position: fixed;
      inset: 0;
      z-index: 99999;
      background: var(--color-navy);
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      gap: 20px;
      transition: opacity .5s ease, visibility .5s ease;
    }
    .page-loader.hidden { opacity: 0; visibility: hidden; pointer-events: none; }
    .loader-logo {
      width: 70px;
      height: 70px;
      background: var(--color-red);
      border-radius: 10px;
      display: flex;
      align-items: center;
      justify-content: center;
      font-family: var(--font-heading);
      font-size: 2.6rem;
      color: #fff;
      animation: pulse-logo 1.2s ease infinite;
    }
    @keyframes pulse-logo { 0%,100%{transform:scale(1)} 50%{transform:scale(1.08)} }
    .loader-bar-wrap {
      width: 180px;
      height: 3px;
      background: rgba(255,255,255,.12);
      border-radius: 3px;
      overflow: hidden;
    }
    .loader-bar {
      height: 100%;
      background: linear-gradient(90deg, var(--color-red), var(--color-gold));
      border-radius: 3px;
      animation: loader-progress 1.4s ease forwards;
    }
    @keyframes loader-progress { 0%{width:0%} 100%{width:100%} }

    /* ──────────────────────────────────────────
       RESPONSIVE
    ────────────────────────────────────────── */
    @media (max-width: 1200px) {
      .videos-grid { grid-template-columns: repeat(3, 1fr); }
      .comp-grid   { grid-template-columns: repeat(4, 1fr); }
    }

    @media (max-width: 1024px) {
      .news-card--hero   { grid-column: span 12; min-height: 400px; }
      .news-card--tall   { grid-column: span 6; }
      .news-card--medium { grid-column: span 6; }
      .news-card--small  { grid-column: span 6; }
      .footer-top { grid-template-columns: 1fr 1fr; gap: 30px; }
      .footer-brand { grid-column: span 2; }
      .videos-grid { grid-template-columns: repeat(2, 1fr); }
      .comp-grid   { grid-template-columns: repeat(3, 1fr); }
      .social-grid { grid-template-columns: 1fr 1fr; }
    }

    @media (max-width: 768px) {
      .primary-nav { display: none; }
      .hamburger { display: flex; }
      .news-card--hero, .news-card--tall, .news-card--medium, .news-card--small {
        grid-column: span 12;
        min-height: 280px;
      }
      .top-bar-left { display: none; }
      .social-grid  { grid-template-columns: 1fr; }
      .comp-grid    { grid-template-columns: repeat(2, 1fr); }
      .footer-top   { grid-template-columns: 1fr; }
      .footer-brand { grid-column: span 1; }
      .wc-visual    { display: none; }
    }

    @media (max-width: 480px) {
      .videos-grid { grid-template-columns: 1fr; }
      .comp-grid   { grid-template-columns: repeat(2, 1fr); }
      .news-header, .videos-header, .scores-header { flex-direction: column; align-items: flex-start; }
    }

    /* ──────────────────────────────────────────
       MOBILE NAV DRAWER
    ────────────────────────────────────────── */
    .mobile-nav {
      position: fixed;
      top: 0;
      left: 0;
      bottom: 0;
      width: 300px;
      background: var(--color-navy-mid);
      z-index: 2000;
      transform: translateX(-100%);
      transition: transform var(--transition-slow);
      padding: 70px 24px 32px;
      overflow-y: auto;
    }
    .mobile-nav.open { transform: translateX(0); }
    .mobile-nav a {
      display: block;
      padding: 12px 0;
      font-size: .92rem;
      font-weight: 600;
      letter-spacing: .04em;
      text-transform: uppercase;
      color: var(--color-text-secondary);
      border-bottom: 1px solid rgba(255,255,255,.06);
      transition: color var(--transition-fast);
    }
    .mobile-nav a:hover { color: var(--color-white); }
    .mobile-nav-overlay {
      position: fixed;
      inset: 0;
      background: rgba(0,0,0,.6);
      z-index: 1999;
      opacity: 0;
      visibility: hidden;
      transition: opacity var(--transition-normal), visibility var(--transition-normal);
    }
    .mobile-nav-overlay.active { opacity: 1; visibility: visible; }
  </style>
</head>
<body>

<!-- ─── PAGE LOADER ─────────────────────────────── -->
<div class="page-loader" id="pageLoader" role="progressbar" aria-label="Loading FIFA.com">
  <div class="loader-logo">FIFA</div>
  <div class="loader-bar-wrap"><div class="loader-bar"></div></div>
</div>

<!-- ─── MOBILE NAV OVERLAY ─────────────────────── -->
<div class="mobile-nav-overlay" id="mobileOverlay" role="presentation" aria-hidden="true"></div>
<nav class="mobile-nav" id="mobileNav" aria-label="Mobile navigation">
  <a href="#">Home</a>
  <a href="#">FIFA World Cup 2026&#8482;</a>
  <a href="#">Competitions</a>
  <a href="#">Scores &amp; Fixtures</a>
  <a href="#">Ranking</a>
  <a href="#">News</a>
  <a href="#">Videos</a>
  <a href="#">FIFA+</a>
  <a href="#">Inside FIFA</a>
</nav>

<!-- ─── TOP BAR ──────────────────────────────────── -->
<div class="top-bar" role="complementary">
  <div class="container">
    <div class="top-bar-left">
      <span class="live-pill" aria-label="Live content">LIVE</span>
      <a href="#">Scores &amp; Fixtures</a>
      <a href="#">Ranking</a>
      <a href="#">Inside FIFA</a>
    </div>
    <div class="top-bar-right">
      <a href="#">&#127760; EN</a>
      <a href="#">Sign In</a>
      <a href="#" class="btn btn-primary" style="padding:4px 14px;font-size:.72rem;">Register</a>
    </div>
  </div>
</div>

<!-- ─── HEADER ────────────────────────────────────── -->
<header class="site-header" role="banner">
  <div class="container">
    <nav class="nav-inner" aria-label="Primary navigation">

      <!-- Logo -->
      <a href="#" class="site-logo" aria-label="FIFA Home">
        <div class="logo-emblem" aria-hidden="true">&#9917;</div>
        <span class="logo-text">FIFA</span>
      </a>

      <!-- Primary Nav -->
      <ul class="primary-nav" role="list">
        <li class="active">
          <a href="#" aria-current="page">Home</a>
        </li>
        <li>
          <a href="#">World Cup 2026&#8482;</a>
          <ul class="nav-dropdown" role="list">
            <li><a href="#">Overview</a></li>
            <li><a href="#">Host Cities</a></li>
            <li><a href="#">Teams</a></li>
            <li><a href="#">Schedule</a></li>
            <li><a href="#">Tickets</a></li>
          </ul>
        </li>
        <li>
          <a href="#">Competitions</a>
          <ul class="nav-dropdown" role="list">
            <li><a href="#">Men's Tournaments</a></li>
            <li><a href="#">Women's Tournaments</a></li>
            <li><a href="#">Youth Tournaments</a></li>
            <li><a href="#">Futsal &amp; Beach Soccer</a></li>
          </ul>
        </li>
        <li><a href="#">News</a></li>
        <li>
          <a href="#">Videos</a>
          <ul class="nav-dropdown" role="list">
            <li><a href="#">Latest Videos</a></li>
            <li><a href="#">Documentaries</a></li>
            <li><a href="#">Highlights</a></li>
            <li><a href="#">FIFA TV</a></li>
          </ul>
        </li>
        <li><a href="#">Ranking</a></li>
        <li><a href="#">FIFA+</a></li>
      </ul>

      <!-- Actions -->
      <div class="nav-actions">
        <button class="nav-search-btn" aria-label="Search">
          <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg>
        </button>
        <button class="hamburger" id="hamburgerBtn" aria-label="Open menu" aria-expanded="false">
          <span></span><span></span><span></span>
        </button>
      </div>

    </nav>
  </div>
</header>

<!-- ─── HERO ──────────────────────────────────────── -->
<!--
  Hero section with YouTube iframe that autoplays and is muted on page load.
  Uses autoplay=1 and mute=1 parameters as required.
-->
<section class="hero" aria-label="Hero feature">

  <!-- Auto-play YouTube video background: autoplay=1 mute=1 starts on page load -->
  <div class="hero-video-wrap" aria-hidden="true">
    <iframe
      id="heroYT"
      class="yt-cover"
      src="https://www.youtube.com/embed/videoseries?list=PLBdoK-3M34UwK5_Ybt2MNxIGHMT32EaS1&autoplay=1&mute=1&loop=1&controls=0&showinfo=0&rel=0&iv_load_policy=3&modestbranding=1&enablejsapi=1&playsinline=1"
      title="FIFA Latest News Highlights"
      allow="autoplay; fullscreen"
      frameborder="0"
    ></iframe>
  </div>

  <div class="container hero-content">
    <p class="section-label">Latest From FIFA</p>
    <h1>
      The World's <span>Greatest</span><br>Game Awaits
    </h1>
    <p>Follow every kick, every goal, every emotion. FIFA World Cup 2026&#8482; is coming to USA, Canada &amp; Mexico.</p>
    <div class="hero-actions">
      <a href="#" class="btn btn-primary">
        <svg width="14" height="14" viewBox="0 0 24 24" fill="currentColor"><path d="M8 5v14l11-7z"/></svg>
        Watch Highlights
      </a>
      <a href="#" class="btn btn-outline">Explore WC 2026</a>
    </div>
  </div>

  <!-- Video controls -->
  <div class="hero-video-controls" aria-label="Video controls">
    <button class="hero-ctrl-btn" id="muteBtn" aria-label="Toggle mute" title="Toggle Mute">
      <svg id="muteIcon" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polygon points="11 5 6 9 2 9 2 15 6 15 11 19 11 5"/><path d="M19.07 4.93a10 10 0 0 1 0 14.14"/><path d="M15.54 8.46a5 5 0 0 1 0 7.07"/></svg>
    </button>
    <button class="hero-ctrl-btn" id="pauseBtn" aria-label="Pause video" title="Pause/Play">
      <svg id="pauseIcon" width="18" height="18" viewBox="0 0 24 24" fill="currentColor"><path d="M6 19h4V5H6zm8-14v14h4V5z"/></svg>
    </button>
  </div>

  <!-- Scroll cue -->
  <div class="hero-scroll" aria-hidden="true">
    <svg width="16" height="24" viewBox="0 0 16 24" fill="none" stroke="currentColor" stroke-width="1.5"><rect x="1" y="1" width="14" height="22" rx="7"/><circle cx="8" cy="8" r="2" fill="currentColor" stroke="none"/></svg>
    Scroll
  </div>
</section>

<!-- ─── TICKER ─────────────────────────────────────── -->
<div class="ticker" aria-label="Breaking news ticker" role="marquee">
  <div class="ticker-track" id="tickerTrack">
    <!-- Items duplicated for seamless loop -->
    <span class="ticker-item"><span class="ticker-label">Breaking</span>FIFA World Cup 2026&#8482; Draw Ceremony date confirmed &ndash; June 2026</span>
    <span class="ticker-item"><span class="ticker-label">News</span>Messi scores hat-trick as Argentina top CONMEBOL qualifying</span>
    <span class="ticker-item"><span class="ticker-label">FIFA+</span>New documentary series "The Road to 2026" now streaming</span>
    <span class="ticker-item"><span class="ticker-label">Rankings</span>Brazil reclaim top spot in FIFA Men's World Ranking</span>
    <span class="ticker-item"><span class="ticker-label">Women's</span>Women's World Cup 2027 host cities announced</span>
    <span class="ticker-item"><span class="ticker-label">Club WC</span>FIFA Club World Cup 2025&#8482; &ndash; Group stage draw results</span>
    <span class="ticker-item"><span class="ticker-label">Breaking</span>FIFA World Cup 2026&#8482; Draw Ceremony date confirmed &ndash; June 2026</span>
    <span class="ticker-item"><span class="ticker-label">News</span>Messi scores hat-trick as Argentina top CONMEBOL qualifying</span>
    <span class="ticker-item"><span class="ticker-label">FIFA+</span>New documentary series "The Road to 2026" now streaming</span>
    <span class="ticker-item"><span class="ticker-label">Rankings</span>Brazil reclaim top spot in FIFA Men's World Ranking</span>
    <span class="ticker-item"><span class="ticker-label">Women's</span>Women's World Cup 2027 host cities announced</span>
    <span class="ticker-item"><span class="ticker-label">Club WC</span>FIFA Club World Cup 2025&#8482; &ndash; Group stage draw results</span>
  </div>
</div>

<!-- ─── FEATURED NEWS ──────────────────────────────── -->
<section class="news-section" aria-labelledby="newsHeading">
  <div class="container">
    <header class="news-header">
      <div>
        <p class="section-label">Top Stories</p>
        <h2 class="section-title" id="newsHeading">Latest News</h2>
      </div>
      <a href="#" class="btn btn-outline">All News &rarr;</a>
    </header>

    <div class="news-grid">

      <!-- Hero card – video -->
      <article class="news-card news-card--hero"
               role="article"
               tabindex="0"
               data-video-id="dSCmzMhPsEQ"
               aria-label="Play: FIFA World Cup 2026 Official Teaser"
               onclick="openModal('dSCmzMhPsEQ')">
        <div class="card-media">
          <img src="https://img.youtube.com/vi/dSCmzMhPsEQ/maxresdefault.jpg"
               alt="FIFA World Cup 2026 Official Teaser thumbnail"
               loading="eager" />
          <div class="card-media-overlay"></div>
          <span class="video-badge" aria-hidden="true">
            <svg width="8" height="8" viewBox="0 0 24 24" fill="currentColor"><path d="M8 5v14l11-7z"/></svg>
            Video
          </span>
          <span class="duration-badge" aria-hidden="true">3:47</span>
          <div class="play-btn-overlay" aria-hidden="true">
            <div class="play-circle">
              <svg width="22" height="22" viewBox="0 0 24 24" fill="white"><path d="M8 5v14l11-7z"/></svg>
            </div>
          </div>
        </div>
        <div class="card-body">
          <span class="card-tag">World Cup 2026</span>
          <h3 class="card-title">FIFA World Cup 2026&#8482; &mdash; The Biggest Tournament in History Begins</h3>
          <div class="card-meta">
            <span>&#128336; 2 hours ago</span>
            <span>&#128205; USA &middot; Canada &middot; Mexico</span>
          </div>
        </div>
      </article>

      <!-- Tall side card -->
      <article class="news-card news-card--tall"
               role="article"
               tabindex="0"
               data-video-id="BIGbRcboANA"
               aria-label="Play: FIFA Rankings Update"
               onclick="openModal('BIGbRcboANA')">
        <div class="card-media" style="min-height:220px;">
          <img src="https://img.youtube.com/vi/BIGbRcboANA/maxresdefault.jpg"
               alt="FIFA World Rankings thumbnail"
               loading="lazy" />
          <div class="card-media-overlay"></div>
          <span class="video-badge" aria-hidden="true">
            <svg width="8" height="8" viewBox="0 0 24 24" fill="currentColor"><path d="M8 5v14l11-7z"/></svg>
            Video
          </span>
          <span class="duration-badge" aria-hidden="true">2:15</span>
          <div class="play-btn-overlay" aria-hidden="true">
            <div class="play-circle">
              <svg width="22" height="22" viewBox="0 0 24 24" fill="white"><path d="M8 5v14l11-7z"/></svg>
            </div>
          </div>
        </div>
        <div class="card-body">
          <span class="card-tag">Rankings</span>
          <h3 class="card-title">Brazil Reclaim FIFA World Ranking No. 1 Spot</h3>
          <p class="card-desc">The Sele&ccedil;&atilde;o edge France to top the global standings after a dominant qualifying campaign.</p>
          <div class="card-meta"><span>&#128336; 5 hours ago</span></div>
        </div>
      </article>

      <!-- Medium cards row -->
      <article class="news-card news-card--medium"
               role="article"
               tabindex="0"
               data-video-id="jtFT6tJBr6M"
               aria-label="Play: Women's World Cup 2027 hosts"
               onclick="openModal('jtFT6tJBr6M')">
        <div class="card-media">
          <img src="https://img.youtube.com/vi/jtFT6tJBr6M/maxresdefault.jpg"
               alt="Women's World Cup 2027 thumbnail"
               loading="lazy" />
          <div class="card-media-overlay"></div>
          <span class="video-badge" aria-hidden="true">
            <svg width="8" height="8" viewBox="0 0 24 24" fill="currentColor"><path d="M8 5v14l11-7z"/></svg>
            Video
          </span>
          <span class="duration-badge" aria-hidden="true">4:02</span>
          <div class="play-btn-overlay" aria-hidden="true">
            <div class="play-circle">
              <svg width="22" height="22" viewBox="0 0 24 24" fill="white"><path d="M8 5v14l11-7z"/></svg>
            </div>
          </div>
        </div>
        <div class="card-body">
          <span class="card-tag">Women's Football</span>
          <h3 class="card-title">Women's World Cup 2027&#8482; Host Cities Revealed</h3>
          <div class="card-meta"><span>&#128336; 1 day ago</span></div>
        </div>
      </article>

      <article class="news-card news-card--medium"
               role="article"
               tabindex="0"
               data-video-id="5qap5aO4i9A"
               aria-label="Play: Club World Cup 2025"
               onclick="openModal('5qap5aO4i9A')">
        <div class="card-media">
          <img src="https://img.youtube.com/vi/5qap5aO4i9A/maxresdefault.jpg"
               alt="Club World Cup 2025 thumbnail"
               loading="lazy" />
          <div class="card-media-overlay"></div>
          <span class="video-badge" aria-hidden="true">
            <svg width="8" height="8" viewBox="0 0 24 24" fill="currentColor"><path d="M8 5v14l11-7z"/></svg>
            Video
          </span>
          <span class="duration-badge" aria-hidden="true">6:18</span>
          <div class="play-btn-overlay" aria-hidden="true">
            <div class="play-circle">
              <svg width="22" height="22" viewBox="0 0 24 24" fill="white"><path d="M8 5v14l11-7z"/></svg>
            </div>
          </div>
        </div>
        <div class="card-body">
          <span class="card-tag">Club World Cup</span>
          <h3 class="card-title">FIFA Club World Cup 2025&#8482; Group Stage Draw Held in Miami</h3>
          <div class="card-meta"><span>&#128336; 2 days ago</span></div>
        </div>
      </article>

      <article class="news-card news-card--medium"
               role="article"
               tabindex="0"
               data-video-id="jNQXAC9IVRw"
               aria-label="Play: CONMEBOL Qualifiers"
               onclick="openModal('jNQXAC9IVRw')">
        <div class="card-media">
          <img src="https://img.youtube.com/vi/jNQXAC9IVRw/maxresdefault.jpg"
               alt="CONMEBOL Qualifiers thumbnail"
               loading="lazy" />
          <div class="card-media-overlay"></div>
          <span class="video-badge" aria-hidden="true">
            <svg width="8" height="8" viewBox="0 0 24 24" fill="currentColor"><path d="M8 5v14l11-7z"/></svg>
            Video
          </span>
          <span class="duration-badge" aria-hidden="true">8:33</span>
          <div class="play-btn-overlay" aria-hidden="true">
            <div class="play-circle">
              <svg width="22" height="22" viewBox="0 0 24 24" fill="white"><path d="M8 5v14l11-7z"/></svg>
            </div>
          </div>
        </div>
        <div class="card-body">
          <span class="card-tag">Qualifiers</span>
          <h3 class="card-title">Messi Masterclass: Argentina Cruise to WC 2026 Qualifying Win</h3>
          <div class="card-meta"><span>&#128336; 3 days ago</span></div>
        </div>
      </article>

    </div>
  </div>
</section>

<!-- ─── LATEST VIDEOS ──────────────────────────────── -->
<section class="videos-section" aria-labelledby="videosHeading">
  <div class="container">
    <header class="videos-header">
      <div>
        <p class="section-label">FIFA TV</p>
        <h2 class="section-title" id="videosHeading">Latest Videos</h2>
      </div>
      <a href="#" class="btn btn-outline">All Videos &rarr;</a>
    </header>

    <div class="videos-grid" id="videosGrid">

      <article class="video-card"
               tabindex="0"
               aria-label="Play video: Road to 2026"
               onclick="openModal('FPmgJFq8QBk')">
        <div class="video-thumb">
          <img src="https://img.youtube.com/vi/FPmgJFq8QBk/hqdefault.jpg"
               alt="Road to 2026 documentary thumbnail" loading="lazy" />
          <div class="play-overlay" aria-hidden="true">
            <div class="play-circle">
              <svg width="20" height="20" viewBox="0 0 24 24" fill="white"><path d="M8 5v14l11-7z"/></svg>
            </div>
          </div>
          <span class="duration" aria-hidden="true">12:45</span>
        </div>
        <div class="video-info">
          <p class="video-tag">Documentary</p>
          <h3 class="video-title">Road to 2026: Episode 1 &mdash; The Dream</h3>
          <p class="video-date">June 12, 2025</p>
        </div>
      </article>

      <article class="video-card"
               tabindex="0"
               aria-label="Play video: Top 10 Goals WC 2022"
               onclick="openModal('Xu8MNKXHBOs')">
        <div class="video-thumb">
          <img src="https://img.youtube.com/vi/Xu8MNKXHBOs/hqdefault.jpg"
               alt="Top 10 Goals World Cup 2022 thumbnail" loading="lazy" />
          <div class="play-overlay" aria-hidden="true">
            <div class="play-circle">
              <svg width="20" height="20" viewBox="0 0 24 24" fill="white"><path d="M8 5v14l11-7z"/></svg>
            </div>
          </div>
          <span class="duration" aria-hidden="true">7:22</span>
        </div>
        <div class="video-info">
          <p class="video-tag">Highlights</p>
          <h3 class="video-title">Top 10 Goals &mdash; FIFA World Cup Qatar 2022&#8482;</h3>
          <p class="video-date">June 10, 2025</p>
        </div>
      </article>

      <article class="video-card"
               tabindex="0"
               aria-label="Play video: Qualifying Roundup"
               onclick="openModal('2Blmiu-LKVE')">
        <div class="video-thumb">
          <img src="https://img.youtube.com/vi/2Blmiu-LKVE/hqdefault.jpg"
               alt="Qualifying Roundup thumbnail" loading="lazy" />
          <div class="play-overlay" aria-hidden="true">
            <div class="play-circle">
              <svg width="20" height="20" viewBox="0 0 24 24" fill="white"><path d="M8 5v14l11-7z"/></svg>
            </div>
          </div>
          <span class="duration" aria-hidden="true">9:15</span>
        </div>
        <div class="video-info">
          <p class="video-tag">Qualifiers</p>
          <h3 class="video-title">WC 2026 Qualifying &mdash; Best Moments Round 14</h3>
          <p class="video-date">June 8, 2025</p>
        </div>
      </article>

      <article class="video-card"
               tabindex="0"
               aria-label="Play video: FIFA Women's Football"
               onclick="openModal('TKCGe2Ezris')">
        <div class="video-thumb">
          <img src="https://img.youtube.com/vi/TKCGe2Ezris/hqdefault.jpg"
               alt="Women's Football thumbnail" loading="lazy" />
          <div class="play-overlay" aria-hidden="true">
            <div class="play-circle">
              <svg width="20" height="20" viewBox="0 0 24 24" fill="white"><path d="M8 5v14l11-7z"/></svg>
            </div>
          </div>
          <span class="duration" aria-hidden="true">5:50</span>
        </div>
        <div class="video-info">
          <p class="video-tag">Women's Football</p>
          <h3 class="video-title">Inspiring the World &mdash; FIFA Women's Football Vision 2027</h3>
          <p class="video-date">June 7, 2025</p>
        </div>
      </article>

    </div>
  </div>
</section>

<!-- ─── COMPETITIONS STRIP ─────────────────────────── -->
<section class="competitions-section" aria-labelledby="compHeading">
  <div class="container">
    <p class="section-label">All Tournaments</p>
    <h2 class="section-title" id="compHeading">FIFA Competitions</h2>
    <div class="comp-grid">
      <div class="comp-card" tabindex="0" role="button" aria-label="FIFA World Cup 2026">
        <div class="comp-emblem" aria-hidden="true">&#127942;</div>
        <h3>World Cup 2026&#8482;</h3>
        <p>USA &middot; Canada &middot; Mexico</p>
      </div>
      <div class="comp-card" tabindex="0" role="button" aria-label="FIFA Club World Cup">
        <div class="comp-emblem" aria-hidden="true">&#129351;</div>
        <h3>Club WC 2025&#8482;</h3>
        <p>United States</p>
      </div>
      <div class="comp-card" tabindex="0" role="button" aria-label="Women's World Cup">
        <div class="comp-emblem" aria-hidden="true">&#9917;</div>
        <h3>Women's WC 2027&#8482;</h3>
        <p>Brazil</p>
      </div>
      <div class="comp-card" tabindex="0" role="button" aria-label="FIFA U-20 World Cup">
        <div class="comp-emblem" aria-hidden="true">&#11088;</div>
        <h3>U-20 World Cup&#8482;</h3>
        <p>Chile 2025</p>
      </div>
      <div class="comp-card" tabindex="0" role="button" aria-label="Futsal World Cup">
        <div class="comp-emblem" aria-hidden="true">&#127919;</div>
        <h3>Futsal WC&#8482;</h3>
        <p>Uzbekistan 2024</p>
      </div>
      <div class="comp-card" tabindex="0" role="button" aria-label="Beach Soccer World Cup">
        <div class="comp-emblem" aria-hidden="true">&#127958;</div>
        <h3>Beach Soccer WC&#8482;</h3>
        <p>Seychelles 2025</p>
      </div>
    </div>
  </div>
</section>

<!-- ─── SCORES / MATCHES ────────────────────────────── -->
<section class="scores-section" aria-labelledby="scoresHeading">
  <div class="container">
    <header class="scores-header">
      <div>
        <p class="section-label">Live &amp; Upcoming</p>
        <h2 class="section-title" id="scoresHeading">Scores &amp; Fixtures</h2>
      </div>
      <a href="#" class="btn btn-outline">Full Schedule &rarr;</a>
    </header>
    <div class="matches-strip" role="list">

      <div class="match-card" role="listitem">
        <p class="match-competition">CONMEBOL Qualifying</p>
        <div class="match-teams">
          <div class="match-team">
            <div class="team-flag" aria-hidden="true">&#127462;&#127479;</div>
            <span class="team-abbr">ARG</span>
          </div>
          <div>
            <div class="match-score">3 <span class="score-sep">&ndash;</span> 0</div>
          </div>
          <div class="match-team">
            <div class="team-flag" aria-hidden="true">&#127463;&#127476;</div>
            <span class="team-abbr">BOL</span>
          </div>
        </div>
        <p class="match-status finished">Full Time</p>
      </div>

      <div class="match-card" role="listitem">
        <p class="match-competition">UEFA Qualifying</p>
        <div class="match-teams">
          <div class="match-team">
            <div class="team-flag" aria-hidden="true">&#127465;&#127466;</div>
            <span class="team-abbr">GER</span>
          </div>
          <div>
            <div class="match-score" style="color:var(--color-red);">2 <span class="score-sep" style="color:#fff;">&ndash;</span> 1</div>
          </div>
          <div class="match-team">
            <div class="team-flag" aria-hidden="true">&#127477;&#127473;</div>
            <span class="team-abbr">POL</span>
          </div>
        </div>
        <p class="match-status live">&#9679; Live 67'</p>
      </div>

      <div class="match-card" role="listitem">
        <p class="match-competition">AFC Qualifying</p>
        <div class="match-teams">
          <div class="match-team">
            <div class="team-flag" aria-hidden="true">&#127471;&#127477;</div>
            <span class="team-abbr">JPN</span>
          </div>
          <div>
            <div class="match-score">4 <span class="score-sep">&ndash;</span> 0</div>
          </div>
          <div class="match-team">
            <div class="team-flag" aria-hidden="true">&#127480;&#127486;</div>
            <span class="team-abbr">SYR</span>
          </div>
        </div>
        <p class="match-status finished">Full Time</p>
      </div>

      <div class="match-card" role="listitem">
        <p class="match-competition">CAF Qualifying</p>
        <div class="match-teams">
          <div class="match-team">
            <div class="team-flag" aria-hidden="true">&#127474;&#127462;</div>
            <span class="team-abbr">MAR</span>
          </div>
          <div>
            <div class="match-score" style="color:var(--color-gold)">vs</div>
          </div>
          <div class="match-team">
            <div class="team-flag" aria-hidden="true">&#127480;&#127475;</div>
            <span class="team-abbr">SEN</span>
          </div>
        </div>
        <p class="match-status upcoming">Tomorrow 19:00</p>
      </div>

      <div class="match-card" role="listitem">
        <p class="match-competition">CONCACAF Qualifying</p>
        <div class="match-teams">
          <div class="match-team">
            <div class="team-flag" aria-hidden="true">&#127482;&#127480;</div>
            <span class="team-abbr">USA</span>
          </div>
          <div>
            <div class="match-score">2 <span class="score-sep">&ndash;</span> 2</div>
          </div>
          <div class="match-team">
            <div class="team-flag" aria-hidden="true">&#127474;&#127485;</div>
            <span class="team-abbr">MEX</span>
          </div>
        </div>
        <p class="match-status finished">Full Time</p>
      </div>

      <div class="match-card" role="listitem">
        <p class="match-competition">UEFA Qualifying</p>
        <div class="match-teams">
          <div class="match-team">
            <div class="team-flag" aria-hidden="true">&#127467;&#127479;</div>
            <span class="team-abbr">FRA</span>
          </div>
          <div>
            <div class="match-score" style="color:var(--color-gold)">vs</div>
          </div>
          <div class="match-team">
            <div class="team-flag" aria-hidden="true">&#127477;&#127481;</div>
            <span class="team-abbr">POR</span>
          </div>
        </div>
        <p class="match-status upcoming">Sat 20:45</p>
      </div>

    </div>
  </div>
</section>

<!-- ─── WC 2026 PROMO BANNER ───────────────────────── -->
<section class="container" aria-labelledby="wc2026Heading">
  <div class="wc-banner">
    <div class="wc-content">
      <div class="wc-badge" aria-label="FIFA Official">&#9917; FIFA Official</div>
      <h2 id="wc2026Heading">
        FIFA World<br>Cup <em>2026&#8482;</em>
      </h2>
      <p>
        48 teams. 3 host nations. 104 matches. The greatest sporting event in history is almost here.
        Be part of it.
      </p>
      <div class="wc-actions">
        <a href="#" class="btn btn-gold">Get Tickets</a>
        <a href="#" class="btn btn-outline">Learn More</a>
      </div>
    </div>
    <div class="wc-visual" aria-hidden="true">&#9917;</div>
  </div>
</section>

<!-- ─── SOCIAL FEED ────────────────────────────────── -->
<section class="social-section" aria-labelledby="socialHeading">
  <div class="container">
    <p class="section-label">Social Media</p>
    <h2 class="section-title" id="socialHeading">FIFA Online</h2>
    <div class="social-grid">

      <div class="social-card">
        <div class="social-platform">
          <div class="platform-icon twitter" aria-hidden="true">&#120143;</div>
          <div>
            <p class="social-handle">@FIFAcom</p>
            <p class="social-followers">12.8M Followers</p>
          </div>
        </div>
        <p class="social-text">
          &#127942; The wait is almost over! FIFA World Cup 2026&#8482; kicks off in less than 12 months.
          Are you ready? #WorldCup2026 #FIFA
        </p>
        <p class="social-date">2 hours ago</p>
      </div>

      <div class="social-card">
        <div class="social-platform">
          <div class="platform-icon instagram" aria-hidden="true">&#128247;</div>
          <div>
            <p class="social-handle">@fifa</p>
            <p class="social-followers">57.4M Followers</p>
          </div>
        </div>
        <p class="social-text">
          Iconic. Legendary. Unstoppable. &#11088;&#11088;&#11088; Relive the greatest moments in World Cup history
          &mdash; now on FIFA+. Link in bio. #FIFA #Football
        </p>
        <p class="social-date">5 hours ago</p>
      </div>

      <div class="social-card">
        <div class="social-platform">
          <div class="platform-icon youtube" aria-hidden="true">&#9654;</div>
          <div>
            <p class="social-handle">FIFA TV</p>
            <p class="social-followers">25.3M Subscribers</p>
          </div>
        </div>
        <p class="social-text">
          NEW: Full match highlights from Round 14 of WC 2026 Qualifiers are LIVE on our channel!
          Watch now &#128071; #WorldCup2026 #Qualifiers
        </p>
        <p class="social-date">1 day ago</p>
      </div>

    </div>
  </div>
</section>

<!-- ─── FOOTER ─────────────────────────────────────── -->
<footer class="site-footer" role="contentinfo">
  <div class="container">
    <div class="footer-top">

      <div class="footer-brand">
        <div class="logo-emblem" aria-label="FIFA logo">&#9917;</div>
        <p>
          FIFA is the governing body of world football, dedicated to developing the game, touching the world
          and building a better future through the power and reach of football.
        </p>
        <nav class="social-links" aria-label="FIFA social media links">
          <a href="#" aria-label="FIFA on Twitter">&#120143;</a>
          <a href="#" aria-label="FIFA on Facebook">f</a>
          <a href="#" aria-label="FIFA on Instagram">&#128247;</a>
          <a href="#" aria-label="FIFA on YouTube">&#9654;</a>
          <a href="#" aria-label="FIFA on TikTok">&#9836;</a>
        </nav>
      </div>

      <div class="footer-col">
        <h4>Competitions</h4>
        <ul>
          <li><a href="#">FIFA World Cup&#8482;</a></li>
          <li><a href="#">Women's World Cup&#8482;</a></li>
          <li><a href="#">Club World Cup&#8482;</a></li>
          <li><a href="#">U-20 World Cup&#8482;</a></li>
          <li><a href="#">Futsal World Cup&#8482;</a></li>
          <li><a href="#">Beach Soccer WC&#8482;</a></li>
        </ul>
      </div>

      <div class="footer-col">
        <h4>Organisation</h4>
        <ul>
          <li><a href="#">About FIFA</a></li>
          <li><a href="#">President's Office</a></li>
          <li><a href="#">FIFA Council</a></li>
          <li><a href="#">Confederations</a></li>
          <li><a href="#">Member Associations</a></li>
          <li><a href="#">Governance</a></li>
        </ul>
      </div>

      <div class="footer-col">
        <h4>Services</h4>
        <ul>
          <li><a href="#">FIFA+</a></li>
          <li><a href="#">FIFA.gg</a></li>
          <li><a href="#">Talent Coach</a></li>
          <li><a href="#">FIFA Connect</a></li>
          <li><a href="#">Transfer Matching</a></li>
          <li><a href="#">My FIFA Account</a></li>
        </ul>
      </div>

      <div class="footer-col">
        <h4>Legal &amp; Media</h4>
        <ul>
          <li><a href="#">Media Releases</a></li>
          <li><a href="#">Media Resources</a></li>
          <li><a href="#">Statutes</a></li>
          <li><a href="#">Privacy Policy</a></li>
          <li><a href="#">Terms of Service</a></li>
          <li><a href="#">Cookie Policy</a></li>
        </ul>
      </div>

    </div>

    <div class="footer-bottom">
      <p>&copy; 2025 FIFA. All rights reserved. FIFA is a registered trademark.</p>
      <nav class="footer-bottom-links" aria-label="Footer legal links">
        <a href="#">Privacy</a>
        <a href="#">Terms</a>
        <a href="#">Cookies</a>
        <a href="#">Accessibility</a>
        <a href="#">Sitemap</a>
      </nav>
    </div>
  </div>
</footer>

<!-- ─── SCROLL TO TOP ──────────────────────────────── -->
<button class="scroll-top" id="scrollTopBtn" aria-label="Scroll to top">
  <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="M18 15l-6-6-6 6"/></svg>
</button>

<!-- ─── VIDEO MODAL ────────────────────────────────── -->
<div class="video-modal" id="videoModal" role="dialog" aria-modal="true" aria-label="Video player">
  <div class="modal-inner">
    <button class="modal-close" id="modalCloseBtn" aria-label="Close video">&#215;</button>
    <div class="modal-video-wrap">
      <iframe
        id="modalIframe"
        src=""
        title="FIFA Video Player"
        allow="autoplay; fullscreen; encrypted-media"
        allowfullscreen
        frameborder="0"
      ></iframe>
    </div>
  </div>
</div>

<!-- ─── JAVASCRIPT ─────────────────────────────────── -->
<script>
(function () {
  'use strict';

  /* ─────────────────── Page Loader ─────────────────── */
  /**
   * Hides the page loader once the page is fully loaded.
   * @returns {void}
   */
  function initPageLoader() {
    var loader = document.getElementById('pageLoader');
    if (!loader) return;

    function hide() {
      loader.classList.add('hidden');
    }

    if (document.readyState === 'complete') {
      setTimeout(hide, 1500);
    } else {
      window.addEventListener('load', function () {
        setTimeout(hide, 1500);
      });
    }
  }

  /* ─────────────────── Video Modal ─────────────────── */
  var modalIframe = document.getElementById('modalIframe');
  var videoModal  = document.getElementById('videoModal');

  /**
   * Opens the video modal and loads the given YouTube video with autoplay.
   * @param {string} videoId - YouTube video ID.
   * @returns {void}
   */
  function openModal(videoId) {
    if (!videoId || typeof videoId !== 'string') {
      console.error('openModal: invalid videoId', videoId);
      return;
    }
    try {
      var src = 'https://www.youtube.com/embed/' + videoId + '?autoplay=1&rel=0&modestbranding=1';
      modalIframe.src = src;
      videoModal.classList.add('active');
      videoModal.setAttribute('aria-hidden', 'false');
      document.body.style.overflow = 'hidden';
    } catch (err) {
      console.error('openModal error:', err.message);
    }
  }

  /**
   * Closes the video modal and stops the video.
   * @returns {void}
   */
  function closeModal() {
    try {
      videoModal.classList.remove('active');
      videoModal.setAttribute('aria-hidden', 'true');
      modalIframe.src = '';
      document.body.style.overflow = '';
    } catch (err) {
      console.error('closeModal error:', err.message);
    }
  }

  // Expose openModal globally for inline onclick handlers
  window.openModal = openModal;

  var modalCloseBtn = document.getElementById('modalCloseBtn');
  if (modalCloseBtn) {
    modalCloseBtn.addEventListener('click', closeModal);
  }

  if (videoModal) {
    videoModal.addEventListener('click', function (e) {
      if (e.target === videoModal) closeModal();
    });
  }

  document.addEventListener('keydown', function (e) {
    if (e.key === 'Escape' && videoModal && videoModal.classList.contains('active')) {
      closeModal();
    }
  });

  /* ─────────────────── Hero Video Controls ─────────────────── */
  var heroIframe = document.getElementById('heroYT');
  var isMuted    = true;
  var isPlaying  = true;

  /**
   * Sends a postMessage command to the YouTube iframe API.
   * @param {string} func - YouTube player function name.
   * @param {Array}  args - Arguments array.
   * @returns {void}
   */
  function sendYTCommand(func, args) {
    if (!heroIframe || !heroIframe.contentWindow) return;
    try {
      heroIframe.contentWindow.postMessage(
        JSON.stringify({ event: 'command', func: func, args: args || [] }),
        '*'
      );
    } catch (err) {
      console.error('sendYTCommand error:', err.message);
    }
  }

  var muteBtn  = document.getElementById('muteBtn');
  var pauseBtn = document.getElementById('pauseBtn');

  if (muteBtn) {
    muteBtn.addEventListener('click', function () {
      isMuted = !isMuted;
      sendYTCommand(isMuted ? 'mute' : 'unMute', []);
      muteBtn.setAttribute('aria-label', isMuted ? 'Unmute video' : 'Mute video');
      muteBtn.setAttribute('title', isMuted ? 'Unmute' : 'Mute');
    });
  }

  if (pauseBtn) {
    pauseBtn.addEventListener('click', function () {
      isPlaying = !isPlaying;
      sendYTCommand(isPlaying ? 'playVideo' : 'pauseVideo', []);
      pauseBtn.setAttribute('aria-label', isPlaying ? 'Pause video' : 'Play video');
      pauseBtn.setAttribute('title', isPlaying ? 'Pause' : 'Play');
      var icon = document.getElementById('pauseIcon');
      if (icon) {
        icon.innerHTML = isPlaying
          ? '<path d="M6 19h4V5H6zm8-14v14h4V5z"/>'
          : '<path d="M8 5v14l11-7z"/>';
      }
    });
  }

  /* ─────────────────── Mobile Nav ─────────────────── */
  var hamburgerBtn  = document.getElementById('hamburgerBtn');
  var mobileNav     = document.getElementById('mobileNav');
  var mobileOverlay = document.getElementById('mobileOverlay');
  var navOpen       = false;

  /**
   * Toggles the mobile navigation drawer.
   * @param {boolean} [forceClose] - If true, forces the drawer closed.
   * @returns {void}
   */
  function toggleMobileNav(forceClose) {
    navOpen = forceClose === true ? false : !navOpen;
    if (mobileNav)     mobileNav.classList.toggle('open', navOpen);
    if (mobileOverlay) mobileOverlay.classList.toggle('active', navOpen);
    if (hamburgerBtn)  hamburgerBtn.setAttribute('aria-expanded', String(navOpen));
    document.body.style.overflow = navOpen ? 'hidden' : '';
  }

  if (hamburgerBtn) {
    hamburgerBtn.addEventListener('click', function () { toggleMobileNav(); });
  }
  if (mobileOverlay) {
    mobileOverlay.addEventListener('click', function () { toggleMobileNav(true); });
  }

  // Close mobile nav links on click
  if (mobileNav) {
    mobileNav.querySelectorAll('a').forEach(function(link) {
      link.addEventListener('click', function() { toggleMobileNav(true); });
    });
  }

  // Close on resize to desktop
  window.addEventListener('resize', function() {
    if (window.innerWidth > 768 && navOpen) toggleMobileNav(true);
  });

  /* ─────────────────── Scroll to Top ─────────────────── */
  var scrollTopBtn = document.getElementById('scrollTopBtn');

  /**
   * Shows/hides the scroll-to-top button based on scroll position.
   * @returns {void}
   */
  function handleScroll() {
    if (!scrollTopBtn) return;
    var isVisible = window.scrollY > 400;
    scrollTopBtn.classList.toggle('visible', isVisible);
    scrollTopBtn.setAttribute('aria-hidden', String(!isVisible));
  }

  window.addEventListener('scroll', handleScroll, { passive: true });

  if (scrollTopBtn) {
    scrollTopBtn.addEventListener('click', function () {
      window.scrollTo({ top: 0, behavior: 'smooth' });
    });
  }

  /* ─────────────────── Keyboard Accessibility ─────────────────── */
  /**
   * Allows news/video cards to be activated via Enter/Space keys.
   * @returns {void}
   */
  function initCardKeyboard() {
    var cards = document.querySelectorAll('[data-video-id], .video-card, .comp-card');
    cards.forEach(function (card) {
      card.addEventListener('keydown', function (e) {
        if (e.key === 'Enter' || e.key === ' ') {
          e.preventDefault();
          card.click();
        }
      });
    });
  }

  /* ─────────────────── Lazy Image Fallbacks ─────────────────── */
  /**
   * Adds error handlers to all thumbnail images, replacing broken ones with a placeholder.
   * @returns {void}
   */
  function initImageFallbacks() {
    var images = document.querySelectorAll('img[loading="lazy"]');
    images.forEach(function (img) {
      img.addEventListener('error', function () {
        var w = img.naturalWidth || 480;
        var h = img.naturalHeight || 270;
        img.src = 'data:image/svg+xml,%3Csvg xmlns="http://www.w3.org/2000/svg" width="' + w + '" height="' + h + '"%3E%3Crect width="100%25" height="100%25" fill="%230e1e38"/%3E%3Ctext x="50%25" y="50%25" dominant-baseline="middle" text-anchor="middle" fill="%23a8b2c4" font-family="Inter,sans-serif" font-size="16"%3E&#9917; FIFA Video%3C/text%3E%3C/svg%3E';
        img.alt = 'FIFA video thumbnail placeholder';
      });
    });
  }

  /* ─────────────────── Intersection Observer Animations ─────────────────── */
  /**
   * Adds fade-in animation to cards when they enter the viewport.
   * @returns {void}
   */
  function initScrollAnimations() {
    if (!('IntersectionObserver' in window)) return;

    var animatables = document.querySelectorAll('.news-card, .video-card, .comp-card, .match-card, .social-card');
    animatables.forEach(function (el) {
      el.style.opacity   = '0';
      el.style.transform = 'translateY(20px)';
      el.style.transition = 'opacity 0.5s ease, transform 0.5s ease';
    });

    var observer = new IntersectionObserver(function (entries) {
      entries.forEach(function (entry) {
        if (entry.isIntersecting) {
          entry.target.style.opacity   = '1';
          entry.target.style.transform = 'translateY(0)';
          observer.unobserve(entry.target);
        }
      });
    }, { threshold: 0.12, rootMargin: '0px 0px -40px 0px' });

    animatables.forEach(function (el) { observer.observe(el); });
  }

  /* ─────────────────── Ticker Duplicate Guard ─────────────────── */
  /**
   * Validates the ticker track has items — if not, logs a warning.
   * @returns {void}
   */
  function validateTicker() {
    var track = document.getElementById('tickerTrack');
    if (!track) return;
    var items = track.querySelectorAll('.ticker-item');
    if (items.length === 0) {
      console.warn('Ticker: no items found in ticker track.');
    }
  }

  /* ─────────────────── Init ─────────────────── */
  function init() {
    initPageLoader();
    initCardKeyboard();
    initImageFallbacks();
    initScrollAnimations();
    validateTicker();
    handleScroll();
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init);
  } else {
    init();
  }

}());
</script>
</body>
</html>
