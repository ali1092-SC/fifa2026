<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>FIFA 2026 – Latest News</title>

  <!-- Google Fonts: Bebas Neue for headings, Inter for body -->
  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
  <link
    href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Inter:wght@400;500;600;700&display=swap"
    rel="stylesheet"
  />

  <style>
    /* ─── CSS Custom Properties ─────────────────────────────────────────── */
    :root {
      --fifa-red:        #cc0000;
      --fifa-red-dark:   #990000;
      --fifa-gold:       #c9a84c;
      --fifa-navy:       #001f5b;
      --fifa-navy-light: #0a2a6e;
      --bg-dark:         #0d0d0d;
      --bg-card:         #161616;
      --bg-card-hover:   #1e1e1e;
      --text-primary:    #ffffff;
      --text-secondary:  #b0b0b0;
      --text-muted:      #6b6b6b;
      --border-subtle:   rgba(255,255,255,0.08);
      --radius-sm:       4px;
      --radius-md:       8px;
      --radius-lg:       12px;
      --transition:      0.25s ease;
      --shadow-card:     0 4px 24px rgba(0,0,0,0.6);
      --shadow-hover:    0 8px 40px rgba(0,0,0,0.8);
    }

    /* ─── Reset & Base ──────────────────────────────────────────────────── */
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

    html { scroll-behavior: smooth; font-size: 16px; }

    body {
      font-family: 'Inter', sans-serif;
      background-color: var(--bg-dark);
      color: var(--text-primary);
      line-height: 1.5;
      overflow-x: hidden;
    }

    img { display: block; max-width: 100%; }
    a   { color: inherit; text-decoration: none; }
    button { cursor: pointer; border: none; background: none; font: inherit; }

    /* ─── Top Announcement Bar ──────────────────────────────────────────── */
    .top-bar {
      background: var(--fifa-red);
      text-align: center;
      padding: 8px 16px;
      font-size: 0.78rem;
      font-weight: 600;
      letter-spacing: 0.08em;
      text-transform: uppercase;
    }

    /* ─── Navigation ────────────────────────────────────────────────────── */
    .nav {
      position: sticky;
      top: 0;
      z-index: 900;
      background: rgba(0, 0, 0, 0.92);
      backdrop-filter: blur(12px);
      -webkit-backdrop-filter: blur(12px);
      border-bottom: 1px solid var(--border-subtle);
    }

    .nav__inner {
      max-width: 1440px;
      margin: 0 auto;
      padding: 0 24px;
      height: 68px;
      display: flex;
      align-items: center;
      justify-content: space-between;
      gap: 24px;
    }

    .nav__logo {
      display: flex;
      align-items: center;
      gap: 12px;
      flex-shrink: 0;
    }

    .nav__logo-emblem {
      width: 42px;
      height: 42px;
      background: var(--fifa-red);
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      font-family: 'Bebas Neue', sans-serif;
      font-size: 1rem;
      letter-spacing: 0.05em;
      color: #fff;
      flex-shrink: 0;
    }

    .nav__logo-text {
      display: flex;
      flex-direction: column;
      line-height: 1;
    }

    .nav__logo-text span:first-child {
      font-family: 'Bebas Neue', sans-serif;
      font-size: 1.5rem;
      letter-spacing: 0.1em;
      color: #fff;
    }

    .nav__logo-text span:last-child {
      font-size: 0.65rem;
      font-weight: 600;
      letter-spacing: 0.18em;
      text-transform: uppercase;
      color: var(--fifa-gold);
    }

    .nav__links {
      display: flex;
      align-items: center;
      gap: 2px;
      list-style: none;
    }

    .nav__links a {
      display: block;
      padding: 8px 14px;
      font-size: 0.82rem;
      font-weight: 600;
      letter-spacing: 0.06em;
      text-transform: uppercase;
      color: var(--text-secondary);
      border-radius: var(--radius-sm);
      transition: color var(--transition), background var(--transition);
    }

    .nav__links a:hover,
    .nav__links a.active {
      color: #fff;
      background: rgba(255,255,255,0.06);
    }

    .nav__links a.active { color: var(--fifa-red); }

    .nav__actions {
      display: flex;
      align-items: center;
      gap: 12px;
    }

    .btn-tickets {
      padding: 9px 20px;
      background: var(--fifa-red);
      color: #fff;
      font-size: 0.78rem;
      font-weight: 700;
      letter-spacing: 0.08em;
      text-transform: uppercase;
      border-radius: var(--radius-sm);
      transition: background var(--transition), transform var(--transition);
    }

    .btn-tickets:hover {
      background: var(--fifa-red-dark);
      transform: translateY(-1px);
    }

    /* ─── Hero Section ──────────────────────────────────────────────────── */
    .hero {
      position: relative;
      height: 100vh;
      min-height: 600px;
      max-height: 900px;
      overflow: hidden;
      display: flex;
      align-items: flex-end;
    }

    /* Fallback gradient when no video */
    .hero__bg-fallback {
      position: absolute;
      inset: 0;
      background:
        radial-gradient(ellipse at 30% 50%, rgba(0,31,91,0.6) 0%, transparent 60%),
        radial-gradient(ellipse at 80% 20%, rgba(204,0,0,0.3) 0%, transparent 50%),
        linear-gradient(160deg, #001030 0%, #050c24 50%, #0d0000 100%);
    }

    /*
      Embedded YouTube iframe as hero background.
      autoplay=1 and mute=1 ensure the video starts automatically on page load.
    */
    .hero__yt-bg {
      position: absolute;
      inset: 0;
      width: 100%;
      height: 100%;
      pointer-events: none;
      overflow: hidden;
    }

    .hero__yt-bg iframe {
      position: absolute;
      top: 50%;
      left: 50%;
      /* 16:9 ratio; oversized to cover container */
      width: 177.78vh;
      min-width: 100%;
      height: 56.25vw;
      min-height: 100%;
      transform: translate(-50%, -50%);
      pointer-events: none;
      border: none;
    }

    .hero__overlay {
      position: absolute;
      inset: 0;
      background: linear-gradient(
        to top,
        rgba(0,0,0,0.92) 0%,
        rgba(0,0,0,0.55) 40%,
        rgba(0,0,0,0.15) 100%
      );
    }

    .hero__content {
      position: relative;
      z-index: 2;
      max-width: 1440px;
      width: 100%;
      margin: 0 auto;
      padding: 0 24px 72px;
    }

    .hero__eyebrow {
      display: inline-flex;
      align-items: center;
      gap: 8px;
      background: var(--fifa-red);
      color: #fff;
      font-size: 0.7rem;
      font-weight: 700;
      letter-spacing: 0.14em;
      text-transform: uppercase;
      padding: 5px 12px;
      border-radius: var(--radius-sm);
      margin-bottom: 20px;
    }

    .hero__eyebrow::before {
      content: '';
      width: 6px;
      height: 6px;
      background: #fff;
      border-radius: 50%;
      animation: pulse-dot 1.5s ease infinite;
    }

    @keyframes pulse-dot {
      0%, 100% { opacity: 1; transform: scale(1); }
      50%       { opacity: 0.4; transform: scale(0.7); }
    }

    .hero__title {
      font-family: 'Bebas Neue', sans-serif;
      font-size: clamp(3rem, 8vw, 7rem);
      line-height: 0.92;
      letter-spacing: 0.04em;
      text-transform: uppercase;
      max-width: 800px;
      margin-bottom: 24px;
    }

    .hero__title em {
      font-style: normal;
      color: var(--fifa-red);
      display: block;
    }

    .hero__subtitle {
      font-size: clamp(0.9rem, 2vw, 1.1rem);
      color: var(--text-secondary);
      max-width: 520px;
      margin-bottom: 36px;
      line-height: 1.7;
    }

    .hero__ctas {
      display: flex;
      flex-wrap: wrap;
      gap: 14px;
      align-items: center;
    }

    .btn-primary {
      padding: 14px 32px;
      background: var(--fifa-red);
      color: #fff;
      font-size: 0.85rem;
      font-weight: 700;
      letter-spacing: 0.1em;
      text-transform: uppercase;
      border-radius: var(--radius-sm);
      transition: background var(--transition), transform var(--transition), box-shadow var(--transition);
    }

    .btn-primary:hover {
      background: var(--fifa-red-dark);
      transform: translateY(-2px);
      box-shadow: 0 6px 24px rgba(204,0,0,0.4);
    }

    .btn-outline {
      padding: 13px 32px;
      border: 1.5px solid rgba(255,255,255,0.5);
      color: #fff;
      font-size: 0.85rem;
      font-weight: 700;
      letter-spacing: 0.1em;
      text-transform: uppercase;
      border-radius: var(--radius-sm);
      transition: border-color var(--transition), background var(--transition), transform var(--transition);
    }

    .btn-outline:hover {
      border-color: #fff;
      background: rgba(255,255,255,0.08);
      transform: translateY(-2px);
    }

    /* ─── Section Wrapper ───────────────────────────────────────────────── */
    .section {
      max-width: 1440px;
      margin: 0 auto;
      padding: 80px 24px;
    }

    /* ─── Section Header ────────────────────────────────────────────────── */
    .section-header {
      display: flex;
      align-items: flex-end;
      justify-content: space-between;
      gap: 24px;
      margin-bottom: 48px;
      flex-wrap: wrap;
    }

    .section-header__label {
      font-size: 0.7rem;
      font-weight: 700;
      letter-spacing: 0.2em;
      text-transform: uppercase;
      color: var(--fifa-red);
      margin-bottom: 10px;
    }

    .section-header__title {
      font-family: 'Bebas Neue', sans-serif;
      font-size: clamp(2rem, 4vw, 3.2rem);
      letter-spacing: 0.05em;
      text-transform: uppercase;
      line-height: 1;
    }

    .section-header__title span {
      color: var(--fifa-red);
    }

    .btn-view-all {
      display: inline-flex;
      align-items: center;
      gap: 8px;
      padding: 10px 22px;
      border: 1.5px solid var(--border-subtle);
      border-radius: var(--radius-sm);
      font-size: 0.78rem;
      font-weight: 700;
      letter-spacing: 0.1em;
      text-transform: uppercase;
      color: var(--text-secondary);
      transition: border-color var(--transition), color var(--transition), background var(--transition);
      white-space: nowrap;
    }

    .btn-view-all:hover {
      border-color: var(--fifa-red);
      color: var(--fifa-red);
      background: rgba(204,0,0,0.06);
    }

    .btn-view-all svg {
      width: 14px;
      height: 14px;
      transition: transform var(--transition);
    }

    .btn-view-all:hover svg { transform: translateX(3px); }

    /* ─── News Grid — 3 responsive columns ─────────────────────────────── */
    .news-grid {
      display: grid;
      grid-template-columns: repeat(3, 1fr);
      gap: 24px;
    }

    /* Featured card spans 2 columns on large screens */
    .news-grid .news-card:first-child {
      grid-column: span 2;
    }

    /* ─── News Card ─────────────────────────────────────────────────────── */
    .news-card {
      background: var(--bg-card);
      border-radius: var(--radius-lg);
      overflow: hidden;
      border: 1px solid var(--border-subtle);
      box-shadow: var(--shadow-card);
      cursor: pointer;
      transition: transform var(--transition), box-shadow var(--transition), border-color var(--transition);
      display: flex;
      flex-direction: column;
    }

    .news-card:hover {
      transform: translateY(-5px);
      box-shadow: var(--shadow-hover);
      border-color: rgba(204,0,0,0.3);
    }

    .news-card:hover .news-card__play-btn {
      transform: translate(-50%, -50%) scale(1.1);
      background: var(--fifa-red);
    }

    .news-card:hover .news-card__thumb img {
      transform: scale(1.04);
    }

    /* Thumbnail */
    .news-card__thumb {
      position: relative;
      overflow: hidden;
      aspect-ratio: 16 / 9;
      flex-shrink: 0;
    }

    .news-card:first-child .news-card__thumb {
      aspect-ratio: 16 / 8;
    }

    .news-card__thumb img {
      width: 100%;
      height: 100%;
      object-fit: cover;
      transition: transform 0.4s ease;
    }

    .news-card__thumb-overlay {
      position: absolute;
      inset: 0;
      background: linear-gradient(
        to bottom,
        transparent 40%,
        rgba(0,0,0,0.7) 100%
      );
    }

    /* Play button */
    .news-card__play-btn {
      position: absolute;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
      width: 52px;
      height: 52px;
      background: rgba(0,0,0,0.65);
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      transition: background var(--transition), transform var(--transition);
      backdrop-filter: blur(4px);
      -webkit-backdrop-filter: blur(4px);
      border: 2px solid rgba(255,255,255,0.3);
    }

    .news-card:first-child .news-card__play-btn {
      width: 68px;
      height: 68px;
    }

    .news-card__play-btn svg {
      width: 20px;
      height: 20px;
      fill: #fff;
      margin-left: 3px;
    }

    .news-card:first-child .news-card__play-btn svg {
      width: 26px;
      height: 26px;
    }

    /* Duration badge */
    .news-card__duration {
      position: absolute;
      bottom: 10px;
      right: 10px;
      background: rgba(0,0,0,0.8);
      color: #fff;
      font-size: 0.72rem;
      font-weight: 600;
      padding: 3px 7px;
      border-radius: var(--radius-sm);
      letter-spacing: 0.04em;
    }

    /* Card body */
    .news-card__body {
      padding: 20px 22px 24px;
      display: flex;
      flex-direction: column;
      flex: 1;
    }

    .news-card:first-child .news-card__body {
      padding: 24px 28px 28px;
    }

    .news-card__tag {
      display: inline-block;
      background: var(--fifa-red);
      color: #fff;
      font-size: 0.65rem;
      font-weight: 700;
      letter-spacing: 0.14em;
      text-transform: uppercase;
      padding: 4px 10px;
      border-radius: var(--radius-sm);
      margin-bottom: 12px;
      width: fit-content;
    }

    .news-card__headline {
      font-family: 'Inter', sans-serif;
      font-size: 0.98rem;
      font-weight: 700;
      line-height: 1.4;
      color: var(--text-primary);
      margin-bottom: 12px;
      flex: 1;
      display: -webkit-box;
      -webkit-line-clamp: 3;
      -webkit-box-orient: vertical;
      overflow: hidden;
    }

    .news-card:first-child .news-card__headline {
      font-size: 1.25rem;
      -webkit-line-clamp: 4;
    }

    .news-card__meta {
      display: flex;
      align-items: center;
      gap: 10px;
      flex-wrap: wrap;
    }

    .news-card__date {
      font-size: 0.72rem;
      color: var(--text-muted);
      letter-spacing: 0.04em;
    }

    .news-card__views {
      font-size: 0.72rem;
      color: var(--text-muted);
      letter-spacing: 0.04em;
      display: flex;
      align-items: center;
      gap: 4px;
    }

    .news-card__views svg {
      width: 12px;
      height: 12px;
      fill: var(--text-muted);
    }

    .news-card__dot {
      width: 3px;
      height: 3px;
      background: var(--text-muted);
      border-radius: 50%;
    }

    /* ─── Lightbox Modal ────────────────────────────────────────────────── */
    .lightbox {
      position: fixed;
      inset: 0;
      z-index: 9999;
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 20px;
      opacity: 0;
      visibility: hidden;
      transition: opacity 0.3s ease, visibility 0.3s ease;
    }

    .lightbox.is-open {
      opacity: 1;
      visibility: visible;
    }

    .lightbox__backdrop {
      position: absolute;
      inset: 0;
      background: rgba(0,0,0,0.92);
      backdrop-filter: blur(8px);
      -webkit-backdrop-filter: blur(8px);
    }

    .lightbox__container {
      position: relative;
      z-index: 1;
      width: 100%;
      max-width: 1000px;
      transform: scale(0.92) translateY(20px);
      transition: transform 0.35s cubic-bezier(0.34,1.56,0.64,1);
    }

    .lightbox.is-open .lightbox__container {
      transform: scale(1) translateY(0);
    }

    .lightbox__header {
      display: flex;
      align-items: flex-start;
      justify-content: space-between;
      gap: 16px;
      margin-bottom: 16px;
    }

    .lightbox__tag {
      display: inline-block;
      background: var(--fifa-red);
      color: #fff;
      font-size: 0.68rem;
      font-weight: 700;
      letter-spacing: 0.14em;
      text-transform: uppercase;
      padding: 5px 12px;
      border-radius: var(--radius-sm);
    }

    .lightbox__close {
      width: 38px;
      height: 38px;
      background: rgba(255,255,255,0.1);
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      color: #fff;
      font-size: 1.3rem;
      line-height: 1;
      flex-shrink: 0;
      transition: background var(--transition);
    }

    .lightbox__close:hover { background: var(--fifa-red); }

    .lightbox__video-wrapper {
      position: relative;
      padding-bottom: 56.25%; /* 16:9 */
      height: 0;
      overflow: hidden;
      border-radius: var(--radius-lg);
      box-shadow: 0 12px 60px rgba(0,0,0,0.8);
      background: #000;
    }

    .lightbox__video-wrapper iframe {
      position: absolute;
      inset: 0;
      width: 100%;
      height: 100%;
      border: none;
      border-radius: var(--radius-lg);
    }

    .lightbox__info {
      margin-top: 18px;
    }

    .lightbox__headline {
      font-family: 'Inter', sans-serif;
      font-size: 1.05rem;
      font-weight: 700;
      color: var(--text-primary);
      margin-bottom: 6px;
    }

    .lightbox__date {
      font-size: 0.78rem;
      color: var(--text-muted);
    }

    /* ─── Ticker Strip ──────────────────────────────────────────────────── */
    .ticker-strip {
      background: var(--fifa-navy);
      border-top: 2px solid var(--fifa-red);
      overflow: hidden;
    }

    .ticker-strip__inner {
      display: flex;
      align-items: center;
    }

    .ticker-strip__label {
      flex-shrink: 0;
      background: var(--fifa-red);
      color: #fff;
      font-size: 0.72rem;
      font-weight: 700;
      letter-spacing: 0.14em;
      text-transform: uppercase;
      padding: 10px 18px;
    }

    .ticker-strip__track {
      flex: 1;
      overflow: hidden;
      position: relative;
    }

    .ticker-strip__content {
      display: flex;
      align-items: center;
      gap: 48px;
      white-space: nowrap;
      animation: ticker-scroll 30s linear infinite;
      padding: 10px 0;
    }

    .ticker-strip__track:hover .ticker-strip__content {
      animation-play-state: paused;
    }

    @keyframes ticker-scroll {
      0%   { transform: translateX(0); }
      100% { transform: translateX(-50%); }
    }

    .ticker-item {
      font-size: 0.78rem;
      color: var(--text-secondary);
      letter-spacing: 0.02em;
      flex-shrink: 0;
    }

    .ticker-item strong { color: #fff; font-weight: 600; }
    .ticker-item span   { color: var(--text-muted); margin: 0 6px; }

    /* ─── Stats Bar ─────────────────────────────────────────────────────── */
    .stats-bar {
      background: linear-gradient(135deg, var(--fifa-navy) 0%, var(--fifa-navy-light) 100%);
      border-bottom: 1px solid var(--border-subtle);
    }

    .stats-bar__inner {
      max-width: 1440px;
      margin: 0 auto;
      padding: 0 24px;
      display: flex;
      align-items: center;
      justify-content: space-between;
      gap: 24px;
      flex-wrap: wrap;
      min-height: 64px;
    }

    .stats-bar__item {
      display: flex;
      align-items: center;
      gap: 10px;
      padding: 12px 0;
    }

    .stats-bar__icon {
      width: 36px;
      height: 36px;
      border-radius: 50%;
      background: rgba(255,255,255,0.1);
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 1rem;
      flex-shrink: 0;
    }

    .stats-bar__label {
      font-size: 0.65rem;
      color: rgba(255,255,255,0.5);
      text-transform: uppercase;
      letter-spacing: 0.1em;
      font-weight: 600;
    }

    .stats-bar__value {
      font-family: 'Bebas Neue', sans-serif;
      font-size: 1.1rem;
      letter-spacing: 0.06em;
      color: #fff;
    }

    .stats-bar__divider {
      width: 1px;
      height: 36px;
      background: var(--border-subtle);
    }

    /* ─── Footer ────────────────────────────────────────────────────────── */
    .footer {
      background: #080808;
      border-top: 1px solid var(--border-subtle);
    }

    .footer__inner {
      max-width: 1440px;
      margin: 0 auto;
      padding: 60px 24px 32px;
    }

    .footer__top {
      display: grid;
      grid-template-columns: 2fr 1fr 1fr 1fr;
      gap: 48px;
      margin-bottom: 48px;
    }

    .footer__brand p {
      font-size: 0.85rem;
      color: var(--text-muted);
      line-height: 1.7;
      margin-top: 16px;
      max-width: 300px;
    }

    .footer__col-title {
      font-size: 0.72rem;
      font-weight: 700;
      letter-spacing: 0.16em;
      text-transform: uppercase;
      color: var(--text-secondary);
      margin-bottom: 18px;
    }

    .footer__links {
      list-style: none;
      display: flex;
      flex-direction: column;
      gap: 10px;
    }

    .footer__links a {
      font-size: 0.84rem;
      color: var(--text-muted);
      transition: color var(--transition);
    }

    .footer__links a:hover { color: #fff; }

    .footer__bottom {
      padding-top: 24px;
      border-top: 1px solid var(--border-subtle);
      display: flex;
      align-items: center;
      justify-content: space-between;
      gap: 16px;
      flex-wrap: wrap;
    }

    .footer__bottom p {
      font-size: 0.75rem;
      color: var(--text-muted);
    }

    .footer__social {
      display: flex;
      gap: 12px;
    }

    .footer__social a {
      width: 34px;
      height: 34px;
      background: rgba(255,255,255,0.06);
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 0.85rem;
      color: var(--text-muted);
      transition: background var(--transition), color var(--transition);
    }

    .footer__social a:hover {
      background: var(--fifa-red);
      color: #fff;
    }

    /* ─── Scroll-reveal animation ───────────────────────────────────────── */
    .reveal {
      opacity: 0;
      transform: translateY(30px);
      transition: opacity 0.6s ease, transform 0.6s ease;
    }

    .reveal.is-visible {
      opacity: 1;
      transform: translateY(0);
    }

    /* stagger children */
    .reveal-stagger > * {
      opacity: 0;
      transform: translateY(24px);
      transition: opacity 0.5s ease, transform 0.5s ease;
    }

    .reveal-stagger.is-visible > * {
      opacity: 1;
      transform: translateY(0);
    }

    .reveal-stagger.is-visible > *:nth-child(1) { transition-delay: 0.05s; }
    .reveal-stagger.is-visible > *:nth-child(2) { transition-delay: 0.12s; }
    .reveal-stagger.is-visible > *:nth-child(3) { transition-delay: 0.19s; }
    .reveal-stagger.is-visible > *:nth-child(4) { transition-delay: 0.26s; }
    .reveal-stagger.is-visible > *:nth-child(5) { transition-delay: 0.33s; }
    .reveal-stagger.is-visible > *:nth-child(6) { transition-delay: 0.40s; }

    /* ─── Responsive ────────────────────────────────────────────────────── */
    @media (max-width: 1024px) {
      .news-grid {
        grid-template-columns: repeat(2, 1fr);
      }

      .news-grid .news-card:first-child {
        grid-column: span 2;
      }

      .footer__top {
        grid-template-columns: 1fr 1fr;
      }

      .nav__links { display: none; }
    }

    @media (max-width: 640px) {
      .news-grid {
        grid-template-columns: 1fr;
      }

      .news-grid .news-card:first-child {
        grid-column: span 1;
      }

      .hero__content { padding-bottom: 48px; }

      .section { padding: 56px 16px; }

      .section-header {
        flex-direction: column;
        align-items: flex-start;
      }

      .footer__top {
        grid-template-columns: 1fr;
        gap: 32px;
      }

      .stats-bar__divider { display: none; }

      .stats-bar__inner {
        gap: 0;
        flex-wrap: wrap;
      }

      .stats-bar__item { flex: 1 1 45%; }
    }

    @media (max-width: 480px) {
      .nav__logo-text { display: none; }
      .hero__title { font-size: clamp(2.5rem, 12vw, 4rem); }
    }
  </style>
</head>
<body>

  <!-- ── Top Announcement Bar ────────────────────────────────────────────── -->
  <div class="top-bar">
    &#127942; FIFA World Cup 2026 &mdash; USA &middot; Canada &middot; Mexico | 11 June &ndash; 19 July 2026
  </div>

  <!-- ── Navigation ───────────────────────────────────────────────────────── -->
  <nav class="nav" role="navigation" aria-label="Main navigation">
    <div class="nav__inner">

      <!-- Logo -->
      <a href="#" class="nav__logo" aria-label="FIFA 2026 Home">
        <div class="nav__logo-emblem" aria-hidden="true">FIFA</div>
        <div class="nav__logo-text">
          <span>World Cup</span>
          <span>2026 &mdash; USA &bull; CAN &bull; MEX</span>
        </div>
      </a>

      <!-- Primary Links -->
      <ul class="nav__links" role="list">
        <li><a href="#" class="active">News</a></li>
        <li><a href="#">Matches</a></li>
        <li><a href="#">Teams</a></li>
        <li><a href="#">Stadiums</a></li>
        <li><a href="#">Groups</a></li>
        <li><a href="#">Stats</a></li>
        <li><a href="#">Tickets</a></li>
        <li><a href="#">Fan Zone</a></li>
      </ul>

      <!-- CTA -->
      <div class="nav__actions">
        <a href="#" class="btn-tickets" aria-label="Buy tickets for FIFA World Cup 2026">
          Buy Tickets
        </a>
      </div>

    </div>
  </nav>

  <!-- ── Stats Bar ─────────────────────────────────────────────────────────── -->
  <div class="stats-bar" role="region" aria-label="Tournament statistics">
    <div class="stats-bar__inner">
      <div class="stats-bar__item">
        <div class="stats-bar__icon" aria-hidden="true">&#127757;</div>
        <div class="stats-bar__text">
          <div class="stats-bar__label">Host Nations</div>
          <div class="stats-bar__value">3 Countries</div>
        </div>
      </div>
      <div class="stats-bar__divider" aria-hidden="true"></div>
      <div class="stats-bar__item">
        <div class="stats-bar__icon" aria-hidden="true">&#127967;</div>
        <div class="stats-bar__text">
          <div class="stats-bar__label">Venues</div>
          <div class="stats-bar__value">16 Stadiums</div>
        </div>
      </div>
      <div class="stats-bar__divider" aria-hidden="true"></div>
      <div class="stats-bar__item">
        <div class="stats-bar__icon" aria-hidden="true">&#9917;</div>
        <div class="stats-bar__text">
          <div class="stats-bar__label">Teams</div>
          <div class="stats-bar__value">48 Nations</div>
        </div>
      </div>
      <div class="stats-bar__divider" aria-hidden="true"></div>
      <div class="stats-bar__item">
        <div class="stats-bar__icon" aria-hidden="true">&#127919;</div>
        <div class="stats-bar__text">
          <div class="stats-bar__label">Matches</div>
          <div class="stats-bar__value">104 Games</div>
        </div>
      </div>
      <div class="stats-bar__divider" aria-hidden="true"></div>
      <div class="stats-bar__item">
        <div class="stats-bar__icon" aria-hidden="true">&#128197;</div>
        <div class="stats-bar__text">
          <div class="stats-bar__label">Kick-off</div>
          <div class="stats-bar__value">11 Jun 2026</div>
        </div>
      </div>
    </div>
  </div>

  <!-- ── Hero Section ──────────────────────────────────────────────────────── -->
  <section class="hero" aria-label="Hero — FIFA World Cup 2026">

    <!--
      YouTube auto-play muted background video.
      autoplay=1 starts the video on page load.
      mute=1 is required for autoplay to work in modern browsers.
      controls=0 hides the player controls for a clean background effect.
      loop=1 with playlist param loops the video forever.
    -->
    <div class="hero__yt-bg" aria-hidden="true">
      <iframe
        id="hero-video"
        src="https://www.youtube.com/embed/nhJBhqMkYgQ?autoplay=1&mute=1&controls=0&loop=1&playlist=nhJBhqMkYgQ&playsinline=1&rel=0&modestbranding=1&enablejsapi=1"
        title="FIFA World Cup 2026 Official Promo"
        allow="autoplay; encrypted-media"
        allowfullscreen
      ></iframe>
    </div>

    <div class="hero__overlay" aria-hidden="true"></div>

    <div class="hero__content">
      <div class="hero__eyebrow" aria-label="Live broadcast">LIVE NOW</div>
      <h1 class="hero__title">
        The World's<br/>Greatest<br/><em>Tournament</em>
      </h1>
      <p class="hero__subtitle">
        48 teams. 104 matches. 3 nations united. Experience the biggest FIFA World Cup&#8482; in history &mdash; coming June 2026 to the USA, Canada &amp; Mexico.
      </p>
      <div class="hero__ctas">
        <a href="#latest-news" class="btn-primary">Latest News</a>
        <a href="#latest-news" class="btn-outline">Watch Highlights &#9654;</a>
      </div>
    </div>

  </section>

  <!-- ── Ticker Strip ───────────────────────────────────────────────────────── -->
  <div class="ticker-strip" aria-label="Latest updates ticker" role="marquee">
    <div class="ticker-strip__inner">
      <div class="ticker-strip__label" aria-hidden="true">BREAKING</div>
      <div class="ticker-strip__track">
        <div class="ticker-strip__content" aria-live="off">
          <!-- Items duplicated for seamless loop -->
          <span class="ticker-item"><strong>Group Draw Complete</strong><span>&bull;</span> 48 teams assigned to 12 groups</span>
          <span class="ticker-item"><strong>Messi Confirms Participation</strong><span>&bull;</span> Argentina captain set for 2026</span>
          <span class="ticker-item"><strong>New York/NJ Stadium Ready</strong><span>&bull;</span> MetLife upgrades unveiled</span>
          <span class="ticker-item"><strong>Ronaldo Eyes Record</strong><span>&bull;</span> Portugal star targets World Cup milestone</span>
          <span class="ticker-item"><strong>Ticket Sales Open</strong><span>&bull;</span> Phase 2 available from Jan 2026</span>
          <span class="ticker-item"><strong>Mbapp&eacute; Leads France</strong><span>&bull;</span> Les Bleus defending champions confident</span>
          <!-- Duplicate for infinite scroll -->
          <span class="ticker-item"><strong>Group Draw Complete</strong><span>&bull;</span> 48 teams assigned to 12 groups</span>
          <span class="ticker-item"><strong>Messi Confirms Participation</strong><span>&bull;</span> Argentina captain set for 2026</span>
          <span class="ticker-item"><strong>New York/NJ Stadium Ready</strong><span>&bull;</span> MetLife upgrades unveiled</span>
          <span class="ticker-item"><strong>Ronaldo Eyes Record</strong><span>&bull;</span> Portugal star targets World Cup milestone</span>
          <span class="ticker-item"><strong>Ticket Sales Open</strong><span>&bull;</span> Phase 2 available from Jan 2026</span>
          <span class="ticker-item"><strong>Mbapp&eacute; Leads France</strong><span>&bull;</span> Les Bleus defending champions confident</span>
        </div>
      </div>
    </div>
  </div>

  <!-- ── Latest News Section ───────────────────────────────────────────────── -->
  <main>
    <section id="latest-news" class="section" aria-labelledby="news-heading">

      <div class="section-header reveal">
        <div class="section-header__left">
          <p class="section-header__label">FIFA World Cup 2026</p>
          <h2 class="section-header__title" id="news-heading">
            Latest <span>News</span>
          </h2>
        </div>
        <a href="#" class="btn-view-all" aria-label="View all FIFA 2026 news">
          View All
          <svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
            <path d="M5 12h14M13 6l6 6-6 6" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" fill="none"/>
          </svg>
        </a>
      </div>

      <!-- 3-column responsive card grid -->
      <div class="news-grid reveal-stagger" role="list" aria-label="Latest FIFA 2026 news videos">

        <!-- Card 1 — Featured (spans 2 cols) -->
        <article
          class="news-card"
          role="listitem"
          tabindex="0"
          aria-label="Open video: FIFA World Cup 2026 Official Film"
          data-video-id="nhJBhqMkYgQ"
          data-tag="OFFICIAL FILM"
          data-headline="FIFA World Cup 2026 — The Official Story Begins: One Dream, Three Nations United"
          data-date="December 18, 2024"
        >
          <div class="news-card__thumb">
            <img
              src="https://img.youtube.com/vi/nhJBhqMkYgQ/maxresdefault.jpg"
              alt="FIFA World Cup 2026 Official Film thumbnail"
              loading="eager"
            />
            <div class="news-card__thumb-overlay" aria-hidden="true"></div>
            <div class="news-card__play-btn" aria-hidden="true">
              <svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><polygon points="5,3 19,12 5,21"/></svg>
            </div>
            <span class="news-card__duration">4:32</span>
          </div>
          <div class="news-card__body">
            <span class="news-card__tag">OFFICIAL FILM</span>
            <h3 class="news-card__headline">
              FIFA World Cup 2026 &mdash; The Official Story Begins: One Dream, Three Nations United
            </h3>
            <div class="news-card__meta">
              <span class="news-card__date">December 18, 2024</span>
              <span class="news-card__dot" aria-hidden="true"></span>
              <span class="news-card__views">
                <svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" aria-hidden="true"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/><circle cx="12" cy="12" r="3"/></svg>
                2.4M views
              </span>
            </div>
          </div>
        </article>

        <!-- Card 2 -->
        <article
          class="news-card"
          role="listitem"
          tabindex="0"
          aria-label="Open video: FIFA World Cup 2026 Group Draw Ceremony"
          data-video-id="1T1K1fJRLSA"
          data-tag="GROUP DRAW"
          data-headline="FIFA World Cup 2026 Group Draw: Every Team's Path to Glory Revealed"
          data-date="December 5, 2024"
        >
          <div class="news-card__thumb">
            <img
              src="https://img.youtube.com/vi/1T1K1fJRLSA/maxresdefault.jpg"
              alt="FIFA World Cup 2026 Group Draw thumbnail"
              loading="lazy"
            />
            <div class="news-card__thumb-overlay" aria-hidden="true"></div>
            <div class="news-card__play-btn" aria-hidden="true">
              <svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><polygon points="5,3 19,12 5,21"/></svg>
            </div>
            <span class="news-card__duration">8:15</span>
          </div>
          <div class="news-card__body">
            <span class="news-card__tag">GROUP DRAW</span>
            <h3 class="news-card__headline">
              FIFA World Cup 2026 Group Draw: Every Team's Path to Glory Revealed
            </h3>
            <div class="news-card__meta">
              <span class="news-card__date">December 5, 2024</span>
              <span class="news-card__dot" aria-hidden="true"></span>
              <span class="news-card__views">
                <svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" aria-hidden="true"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/><circle cx="12" cy="12" r="3"/></svg>
                1.1M views
              </span>
            </div>
          </div>
        </article>

        <!-- Card 3 -->
        <article
          class="news-card"
          role="listitem"
          tabindex="0"
          aria-label="Open video: FIFA Best Awards 2024"
          data-video-id="D2M3MmbX25M"
          data-tag="AWARDS"
          data-headline="The Best FIFA Football Awards 2024 — Full Ceremony Highlights"
          data-date="October 21, 2024"
        >
          <div class="news-card__thumb">
            <img
              src="https://img.youtube.com/vi/D2M3MmbX25M/maxresdefault.jpg"
              alt="FIFA Best Awards 2024 thumbnail"
              loading="lazy"
            />
            <div class="news-card__thumb-overlay" aria-hidden="true"></div>
            <div class="news-card__play-btn" aria-hidden="true">
              <svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><polygon points="5,3 19,12 5,21"/></svg>
            </div>
            <span class="news-card__duration">12:40</span>
          </div>
          <div class="news-card__body">
            <span class="news-card__tag">AWARDS</span>
            <h3 class="news-card__headline">
              The Best FIFA Football Awards 2024 &mdash; Full Ceremony Highlights
            </h3>
            <div class="news-card__meta">
              <span class="news-card__date">October 21, 2024</span>
              <span class="news-card__dot" aria-hidden="true"></span>
              <span class="news-card__views">
                <svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" aria-hidden="true"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/><circle cx="12" cy="12" r="3"/></svg>
                890K views
              </span>
            </div>
          </div>
        </article>

        <!-- Card 4 -->
        <article
          class="news-card"
          role="listitem"
          tabindex="0"
          aria-label="Open video: FIFA World Cup 2026 Host Cities Overview"
          data-video-id="cZgYFpVGvRg"
          data-tag="HOST CITIES"
          data-headline="Inside the 16 FIFA World Cup 2026 Stadiums — A Complete Guide to All Host Cities"
          data-date="November 12, 2024"
        >
          <div class="news-card__thumb">
            <img
              src="https://img.youtube.com/vi/cZgYFpVGvRg/maxresdefault.jpg"
              alt="FIFA World Cup 2026 Host Cities thumbnail"
              loading="lazy"
            />
            <div class="news-card__thumb-overlay" aria-hidden="true"></div>
            <div class="news-card__play-btn" aria-hidden="true">
              <svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><polygon points="5,3 19,12 5,21"/></svg>
            </div>
            <span class="news-card__duration">6:55</span>
          </div>
          <div class="news-card__body">
            <span class="news-card__tag">HOST CITIES</span>
            <h3 class="news-card__headline">
              Inside the 16 FIFA World Cup 2026 Stadiums &mdash; A Guide to Every Host City
            </h3>
            <div class="news-card__meta">
              <span class="news-card__date">November 12, 2024</span>
              <span class="news-card__dot" aria-hidden="true"></span>
              <span class="news-card__views">
                <svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" aria-hidden="true"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/><circle cx="12" cy="12" r="3"/></svg>
                670K views
              </span>
            </div>
          </div>
        </article>

        <!-- Card 5 -->
        <article
          class="news-card"
          role="listitem"
          tabindex="0"
          aria-label="Open video: Argentina vs France 2022 FIFA World Cup Final"
          data-video-id="GicHw0OBu4g"
          data-tag="MATCH HIGHLIGHTS"
          data-headline="Argentina vs France — The Greatest World Cup Final Ever Played | Qatar 2022"
          data-date="September 8, 2024"
        >
          <div class="news-card__thumb">
            <img
              src="https://img.youtube.com/vi/GicHw0OBu4g/maxresdefault.jpg"
              alt="Argentina vs France 2022 FIFA World Cup Final thumbnail"
              loading="lazy"
            />
            <div class="news-card__thumb-overlay" aria-hidden="true"></div>
            <div class="news-card__play-btn" aria-hidden="true">
              <svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><polygon points="5,3 19,12 5,21"/></svg>
            </div>
            <span class="news-card__duration">14:08</span>
          </div>
          <div class="news-card__body">
            <span class="news-card__tag">MATCH HIGHLIGHTS</span>
            <h3 class="news-card__headline">
              Argentina vs France &mdash; The Greatest World Cup Final Ever | Qatar 2022 Revisited
            </h3>
            <div class="news-card__meta">
              <span class="news-card__date">September 8, 2024</span>
              <span class="news-card__dot" aria-hidden="true"></span>
              <span class="news-card__views">
                <svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" aria-hidden="true"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/><circle cx="12" cy="12" r="3"/></svg>
                18.7M views
              </span>
            </div>
          </div>
        </article>

        <!-- Card 6 -->
        <article
          class="news-card"
          role="listitem"
          tabindex="0"
          aria-label="Open video: FIFA World Cup 2026 Qualification Recap"
          data-video-id="PnGVH1H0MNU"
          data-tag="QUALIFICATION"
          data-headline="Road to FIFA World Cup 2026 — Full Qualification Recap & Biggest Moments"
          data-date="December 1, 2024"
        >
          <div class="news-card__thumb">
            <img
              src="https://img.youtube.com/vi/PnGVH1H0MNU/maxresdefault.jpg"
              alt="FIFA World Cup 2026 Qualification Recap thumbnail"
              loading="lazy"
            />
            <div class="news-card__thumb-overlay" aria-hidden="true"></div>
            <div class="news-card__play-btn" aria-hidden="true">
              <svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><polygon points="5,3 19,12 5,21"/></svg>
            </div>
            <span class="news-card__duration">9:24</span>
          </div>
          <div class="news-card__body">
            <span class="news-card__tag">QUALIFICATION</span>
            <h3 class="news-card__headline">
              Road to FIFA World Cup 2026 &mdash; Full Qualification Recap &amp; Biggest Moments
            </h3>
            <div class="news-card__meta">
              <span class="news-card__date">December 1, 2024</span>
              <span class="news-card__dot" aria-hidden="true"></span>
              <span class="news-card__views">
                <svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" aria-hidden="true"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/><circle cx="12" cy="12" r="3"/></svg>
                3.2M views
              </span>
            </div>
          </div>
        </article>

      </div><!-- /news-grid -->
    </section>
  </main>

  <!-- ── Lightbox Modal ─────────────────────────────────────────────────────── -->
  <div
    id="lightbox"
    class="lightbox"
    role="dialog"
    aria-modal="true"
    aria-labelledby="lightbox-headline"
    aria-hidden="true"
  >
    <div class="lightbox__backdrop" id="lightbox-backdrop"></div>
    <div class="lightbox__container">

      <div class="lightbox__header">
        <span class="lightbox__tag" id="lightbox-tag">VIDEO</span>
        <button
          class="lightbox__close"
          id="lightbox-close"
          aria-label="Close video"
          title="Close (Esc)"
        >&#x2715;</button>
      </div>

      <div class="lightbox__video-wrapper">
        <iframe
          id="lightbox-iframe"
          src=""
          title="FIFA Video"
          allow="autoplay; fullscreen; encrypted-media"
          allowfullscreen
        ></iframe>
      </div>

      <div class="lightbox__info">
        <p class="lightbox__headline" id="lightbox-headline"></p>
        <p class="lightbox__date"    id="lightbox-date"></p>
      </div>

    </div>
  </div>

  <!-- ── Footer ─────────────────────────────────────────────────────────────── -->
  <footer class="footer" role="contentinfo">
    <div class="footer__inner">
      <div class="footer__top">
        <div class="footer__brand">
          <div style="display:flex;align-items:center;gap:10px;">
            <div class="nav__logo-emblem" style="width:36px;height:36px;font-size:0.85rem;" aria-hidden="true">FIFA</div>
            <span style="font-family:'Bebas Neue',sans-serif;font-size:1.2rem;letter-spacing:0.1em;">World Cup 2026</span>
          </div>
          <p>
            The official source for FIFA World Cup 2026 news, match highlights, team updates, and ticket information. USA &middot; Canada &middot; Mexico.
          </p>
        </div>
        <div>
          <p class="footer__col-title">Tournament</p>
          <ul class="footer__links">
            <li><a href="#">Schedule</a></li>
            <li><a href="#">Groups</a></li>
            <li><a href="#">Teams</a></li>
            <li><a href="#">Stadiums</a></li>
            <li><a href="#">Stats</a></li>
          </ul>
        </div>
        <div>
          <p class="footer__col-title">Media</p>
          <ul class="footer__links">
            <li><a href="#">News</a></li>
            <li><a href="#">Videos</a></li>
            <li><a href="#">Photos</a></li>
            <li><a href="#">Press</a></li>
            <li><a href="#">Broadcasts</a></li>
          </ul>
        </div>
        <div>
          <p class="footer__col-title">About FIFA</p>
          <ul class="footer__links">
            <li><a href="#">About Us</a></li>
            <li><a href="#">Governance</a></li>
            <li><a href="#">Sustainability</a></li>
            <li><a href="#">Privacy Policy</a></li>
            <li><a href="#">Accessibility</a></li>
            <li><a href="#">Contact</a></li>
          </ul>
        </div>
      </div>
      <div class="footer__bottom">
        <p>&copy; 2026 FIFA. All Rights Reserved. FIFA World Cup&#8482; is a registered trademark of FIFA.</p>
        <div class="footer__social" aria-label="Follow FIFA on social media">
          <a href="#" aria-label="FIFA on Twitter / X">&#120143;</a>
          <a href="#" aria-label="FIFA on Facebook">f</a>
          <a href="#" aria-label="FIFA on Instagram">&#128247;</a>
          <a href="#" aria-label="FIFA on YouTube">&#9654;</a>
          <a href="#" aria-label="FIFA on TikTok">&#9836;</a>
        </div>
      </div>
    </div>
  </footer>

  <!-- ──────────────────────────────────────────────────────────────────────── -->
  <!-- JavaScript                                                               -->
  <!-- ──────────────────────────────────────────────────────────────────────── -->
  <script>
    'use strict';

    /* ── Constants ──────────────────────────────────────────────────────────── */

    /** @type {string} YouTube base embed URL */
    var YT_EMBED_BASE = 'https://www.youtube.com/embed/';

    /**
     * YouTube embed params for lightbox (autoplay enabled, no controls clutter).
     * autoplay=1 starts video immediately when modal opens.
     * @type {string}
     */
    var YT_LIGHTBOX_PARAMS =
      '?autoplay=1&mute=0&controls=1&rel=0&modestbranding=1&playsinline=1&enablejsapi=1';

    /* ── Utility helpers ────────────────────────────────────────────────────── */

    /**
     * Build a fully-qualified YouTube embed URL.
     * @param {string} videoId - YouTube video ID
     * @param {string} params  - Query string to append
     * @returns {string}
     */
    function buildYouTubeEmbedUrl(videoId, params) {
      if (!videoId || typeof videoId !== 'string') {
        throw new Error('buildYouTubeEmbedUrl: videoId must be a non-empty string');
      }
      return YT_EMBED_BASE + encodeURIComponent(videoId) + params;
    }

    /**
     * Trap keyboard focus within a container (for modal accessibility).
     * @param {HTMLElement} container
     * @param {KeyboardEvent} event
     */
    function trapFocus(container, event) {
      var focusableSelectors =
        'button, [href], input, select, textarea, [tabindex]:not([tabindex="-1"])';
      var focusables = Array.prototype.slice.call(container.querySelectorAll(focusableSelectors));
      if (focusables.length === 0) return;

      var firstEl = focusables[0];
      var lastEl  = focusables[focusables.length - 1];

      if (event.shiftKey) {
        if (document.activeElement === firstEl) {
          event.preventDefault();
          lastEl.focus();
        }
      } else {
        if (document.activeElement === lastEl) {
          event.preventDefault();
          firstEl.focus();
        }
      }
    }

    /* ── Lightbox Controller ────────────────────────────────────────────────── */

    var Lightbox = (function () {
      var _overlay     = null;
      var _iframe      = null;
      var _tagEl       = null;
      var _headlineEl  = null;
      var _dateEl      = null;
      var _closeBtn    = null;
      var _backdrop    = null;
      var _lastFocused = null;
      var _isOpen      = false;

      function _onKeyDown(e) {
        if (!_isOpen) return;
        if (e.key === 'Escape') { close(); return; }
        if (e.key === 'Tab')    { trapFocus(_overlay, e); }
      }

      function _stopVideo() {
        try {
          if (_iframe) _iframe.src = '';
        } catch (err) {
          console.error('Lightbox: error stopping video', err);
        }
      }

      /**
       * Open the lightbox with the given video data.
       * @param {{videoId:string, tag:string, headline:string, date:string}} data
       */
      function open(data) {
        try {
          if (!data || !data.videoId) throw new Error('Lightbox.open: invalid data');

          _lastFocused = document.activeElement;

          _tagEl.textContent      = data.tag      || 'VIDEO';
          _headlineEl.textContent = data.headline || '';
          _dateEl.textContent     = data.date     || '';
          _iframe.src             = buildYouTubeEmbedUrl(data.videoId, YT_LIGHTBOX_PARAMS);

          _overlay.classList.add('is-open');
          _overlay.setAttribute('aria-hidden', 'false');
          document.body.style.overflow = 'hidden';
          _isOpen = true;

          setTimeout(function() { if (_closeBtn) _closeBtn.focus(); }, 80);
        } catch (err) {
          console.error('Lightbox.open error:', err);
        }
      }

      /**
       * Close the lightbox and stop the video.
       */
      function close() {
        try {
          _stopVideo();
          _overlay.classList.remove('is-open');
          _overlay.setAttribute('aria-hidden', 'true');
          document.body.style.overflow = '';
          _isOpen = false;

          if (_lastFocused && typeof _lastFocused.focus === 'function') {
            _lastFocused.focus();
          }
        } catch (err) {
          console.error('Lightbox.close error:', err);
        }
      }

      /**
       * Initialise lightbox DOM references and event listeners.
       */
      function init() {
        _overlay    = document.getElementById('lightbox');
        _iframe     = document.getElementById('lightbox-iframe');
        _tagEl      = document.getElementById('lightbox-tag');
        _headlineEl = document.getElementById('lightbox-headline');
        _dateEl     = document.getElementById('lightbox-date');
        _closeBtn   = document.getElementById('lightbox-close');
        _backdrop   = document.getElementById('lightbox-backdrop');

        if (!_overlay || !_iframe || !_closeBtn || !_backdrop) {
          console.error('Lightbox.init: required DOM elements missing');
          return;
        }

        _closeBtn.addEventListener('click', close);
        _backdrop.addEventListener('click', close);
        document.addEventListener('keydown', _onKeyDown);
      }

      return { init: init, open: open, close: close };
    })();

    /* ── News Card Interactions ─────────────────────────────────────────────── */

    /**
     * Extract lightbox data from a card element's data attributes.
     * @param {HTMLElement} card
     * @returns {{videoId:string, tag:string, headline:string, date:string}}
     */
    function extractCardData(card) {
      var videoId = card.dataset.videoId;
      if (!videoId) throw new Error('Card is missing data-video-id attribute');

      return {
        videoId:  videoId,
        tag:      card.dataset.tag      || 'VIDEO',
        headline: card.dataset.headline || '',
        date:     card.dataset.date     || ''
      };
    }

    /**
     * Attach click and keyboard (Enter/Space) listeners to all news cards.
     */
    function initNewsCards() {
      var cards = document.querySelectorAll('.news-card');

      cards.forEach(function(card) {
        card.addEventListener('click', function() {
          try {
            var data = extractCardData(card);
            Lightbox.open(data);
          } catch (err) {
            console.error('News card click error:', err);
          }
        });

        card.addEventListener('keydown', function(e) {
          if (e.key === 'Enter' || e.key === ' ') {
            e.preventDefault();
            try {
              var data = extractCardData(card);
              Lightbox.open(data);
            } catch (err) {
              console.error('News card keydown error:', err);
            }
          }
        });
      });
    }

    /* ── Scroll-reveal (Intersection Observer) ──────────────────────────────── */

    /**
     * Observe elements with .reveal / .reveal-stagger and toggle .is-visible
     * when they enter the viewport.
     */
    function initScrollReveal() {
      if (!('IntersectionObserver' in window)) {
        document.querySelectorAll('.reveal, .reveal-stagger').forEach(function(el) {
          el.classList.add('is-visible');
        });
        return;
      }

      var observer = new IntersectionObserver(
        function(entries) {
          entries.forEach(function(entry) {
            if (entry.isIntersecting) {
              entry.target.classList.add('is-visible');
              observer.unobserve(entry.target);
            }
          });
        },
        { threshold: 0.12, rootMargin: '0px 0px -40px 0px' }
      );

      document.querySelectorAll('.reveal, .reveal-stagger').forEach(function(el) {
        observer.observe(el);
      });
    }

    /* ── YouTube thumbnail error handling ──────────────────────────────────── */

    /**
     * Replace failed maxresdefault thumbnails with hqdefault fallback.
     */
    function initThumbnailFallbacks() {
      document.querySelectorAll('.news-card__thumb img').forEach(function(img) {
        img.addEventListener('error', function() {
          var src = img.src;
          if (src.indexOf('maxresdefault') !== -1) {
            img.src = src.replace('maxresdefault', 'hqdefault');
          }
        });
      });
    }

    /* ── Navigation scroll effect ───────────────────────────────────────────── */

    /**
     * Add shadow to nav when user scrolls down for a polished look.
     */
    function initNavScroll() {
      var nav = document.querySelector('.nav');
      if (!nav) return;

      var ticking = false;

      function updateNav() {
        nav.style.boxShadow = window.scrollY > 60
          ? '0 4px 24px rgba(0,0,0,0.7)'
          : 'none';
        ticking = false;
      }

      window.addEventListener('scroll', function() {
        if (!ticking) {
          window.requestAnimationFrame(updateNav);
          ticking = true;
        }
      }, { passive: true });
    }

    /* ── Boot ───────────────────────────────────────────────────────────────── */

    /**
     * Main entry point — initialise all modules once the DOM is ready.
     */
    function boot() {
      try {
        Lightbox.init();
        initNewsCards();
        initScrollReveal();
        initThumbnailFallbacks();
        initNavScroll();
      } catch (err) {
        console.error('FIFA 2026 app boot error:', err);
      }
    }

    if (document.readyState === 'loading') {
      document.addEventListener('DOMContentLoaded', boot);
    } else {
      boot();
    }
  </script>

</body>
</html>
