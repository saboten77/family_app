import "@hotwired/turbo-rails"
import "controllers"
import "reward_cards"
import "gacha"

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
