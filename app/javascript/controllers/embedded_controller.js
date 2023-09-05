import { Controller } from "@hotwired/stimulus"

export default class extends Controller { 
  connect() { 
    this.element.addEventListener('turbo:submit-end', (event) => {
      if (event.detail.success) {
        location.reload();
      }
    });
  }

  close() {
    this.element.parentElement.removeAttribute('src');
    this.element.remove();
  }
}