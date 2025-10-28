import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["message"]

  connect() {
    // Auto-dismiss after 5 seconds
    this.timeout = setTimeout(() => {
      this.dismiss()
    }, 5000)
  }

  disconnect() {
    if (this.timeout) {
      clearTimeout(this.timeout)
    }
  }

  close(event) {
    const message = event.currentTarget.closest('[data-flash-target="message"]')
    this.dismissMessage(message)
  }

  dismiss() {
    this.messageTargets.forEach(message => {
      this.dismissMessage(message)
    })
  }

  dismissMessage(message) {
    message.style.animation = 'slide-out-right 0.3s ease-out forwards'
    setTimeout(() => {
      message.remove()
      
      // If no more messages, remove the container
      if (this.messageTargets.length === 0) {
        this.element.remove()
      }
    }, 300)
  }
}
