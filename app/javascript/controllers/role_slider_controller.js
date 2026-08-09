import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["range", "value"]

  connect() {
    this.updateDisplay()
  }

  update() {
    this.updateDisplay()
  }

  updateDisplay() {
    let total = 0

    this.rangeTargets.forEach((range, index) => {
      const value = Number(range.value)

      total += value
      this.valueTargets[index].textContent = `${value}%`
    })

    const totalValue = document.querySelector("#total-value")
    const totalMessage = document.querySelector("#total-message")

    totalValue.textContent = total

    if (total === 100) {
      totalMessage.textContent = " 🌱 OK！"
    } else {
      totalMessage.textContent = " ⚠️ 合計を100%にしてください"
    }
  }
}