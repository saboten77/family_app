console.log("🎰 gacha.js 読み込まれた！");
document.addEventListener("turbo:load", () => {
  const video = document.getElementById("gacha-video");
  const result = document.getElementById("reward-result");

  if (!video || !result) return;

  video.addEventListener("ended", () => {
    console.log("🎬 動画終了！");
    result.style.display = "block";
  });
});
