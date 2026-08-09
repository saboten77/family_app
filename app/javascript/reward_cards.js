document.addEventListener("turbo:load", () => {
  const tabs = document.querySelectorAll(".reward-tab");
  const contents = document.querySelectorAll(".reward-tab-content");

  if (tabs.length === 0 || contents.length === 0) return;

  tabs.forEach((tab) => {
    tab.addEventListener("click", () => {
      const targetId = tab.dataset.tab;

      // タブの選択状態を切り替える
      tabs.forEach((item) => {
        item.classList.remove("active");
      });

      tab.classList.add("active");

      // 表示するコンテンツを切り替える
      contents.forEach((content) => {
        content.classList.remove("active");

        if (content.id === targetId) {
          content.classList.add("active");
        }
      });
    });
  });
});
