<!-- This is a CSS snippet to be applied to the watermark in index.html -->
<!-- Replace the existing .watermark or body::before CSS block with the following -->

<style>
  body::before {
    content: "";
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    width: 520px;
    height: 520px;
    background-image: url('https://upload.wikimedia.org/wikipedia/en/thumb/7/7a/2026_FIFA_World_Cup_official_ball.png/220px-2026_FIFA_World_Cup_official_ball.png');
    background-repeat: no-repeat;
    background-position: center center;
    background-size: 520px 520px;
    opacity: 0.08;
    pointer-events: none;
    z-index: 0;
  }
</style>
