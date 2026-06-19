/* Example: Apply animation properties to the ball element */

.ball {
  animation:
    pulse 1.5s ease-in-out infinite,
    spin 3s linear infinite;
}

@keyframes pulse {
  0%,
  100% {
    transform: scale(1);
    box-shadow: 0 0 6px rgba(255, 255, 255, 0.4);
  }
  50% {
    transform: scale(1.08);
    box-shadow: 0 0 14px rgba(255, 255, 255, 0.75);
  }
}

@keyframes spin {
  from {
    filter: hue-rotate(0deg);
  }
  to {
    filter: hue-rotate(360deg);
  }
}
