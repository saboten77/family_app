// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
//import "./gacha"

window.copyInviteCode = async function() {
  const code = document.getElementById("invite-code").textContent.trim();

  try {
    await navigator.clipboard.writeText(code);
    alert("招待コードをコピーしました🐹✨");
  } catch (error) {
    console.error(error);
    alert("コピーできませんでした😢");
  }
};
