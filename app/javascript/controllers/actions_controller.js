import { Controller } from "@hotwired/stimulus"
import { Turbo } from "@hotwired/turbo-rails"

export default class extends Controller {
  
  static values = {
    id: String
  }


  updatesLike(event) {
    event.preventDefault();
    const listId = document.querySelectorAll(`#${this.idValue}`)
    const id = this.idValue;
    const url = event.target.href;
    const method = event.target.dataset.turboMethod;


    listId.forEach((element) => {
        fetch(url, {
          method: method,
          headers: {
            'Content-Type': 'application/json',
            'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
          },
          body: JSON.stringify({ id })
        })
        .then(response => {
          response.text().then((html) => {
            element.innerHTML = html;
          })
        })
      }
    )
  }
}
