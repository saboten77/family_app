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

    document.querySelector("#total-value").textContent = total
  }
}
