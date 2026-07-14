import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["range", "value"]

  connect() {
    this.update()
  }

  update(event) {
    const changedRange = event?.target

    let total = 0

    this.rangeTargets.forEach((range) => {
      total += Number(range.value)
    })

    // 動かした人以外を調整
    if (changedRange && total !== 100) {
      const diff = total - 100

      const others = this.rangeTargets.filter(
        (range) => range !== changedRange
      )

      const adjustment = diff / others.length

      others.forEach((range) => {
        range.value = Math.round(Number(range.value) - adjustment)
      })
    }

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