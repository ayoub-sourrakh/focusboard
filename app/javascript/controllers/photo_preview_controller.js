import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "preview", "placeholder"]

  preview(event) {
    const file = event.target.files[0]
    
    if (file && file.type.startsWith('image/')) {
      const reader = new FileReader()
      
      reader.onload = (e) => {
        // Hide placeholder and show preview
        if (this.hasPlaceholderTarget) {
          this.placeholderTarget.classList.add('hidden')
        }
        
        if (this.hasPreviewTarget) {
          this.previewTarget.src = e.target.result
          this.previewTarget.classList.remove('hidden')
        } else {
          // Create preview image if it doesn't exist
          const img = document.createElement('img')
          img.src = e.target.result
          img.className = "w-24 h-24 rounded-full object-cover border-4 border-blue-100"
          img.dataset.photoPreviewTarget = "preview"
          
          // Insert before placeholder
          if (this.hasPlaceholderTarget) {
            this.placeholderTarget.parentNode.insertBefore(img, this.placeholderTarget)
          }
        }
      }
      
      reader.readAsDataURL(file)
    }
  }
}
