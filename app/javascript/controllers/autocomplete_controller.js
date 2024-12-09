import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["source", "destination"]

  search(event) {
    const query = event.target.value;
    const targetField = event.target.getAttribute("data-autocomplete-target");

    if (query.length < 2) {
      this.clearSuggestions(targetField);
      return;
    }

    fetch(`/locations/search?q=${query}`)
      .then(response => response.json())
      .then(data => this.showSuggestions(data, targetField))
      .catch(error => console.error("Error fetching suggestions:", error));
  }

  showSuggestions(data, targetField) {
    const resultsElement = document.getElementById(`${targetField}-suggestions`);
    resultsElement.innerHTML = data
      .map(location => 
        `<div class="suggestion-item" data-value="${location.address}" 
          onclick="selectAddress('${targetField}', '${location.address}')">
          ${location.address}
        </div>`)
      .join("");
  }

  clearSuggestions(targetField) {
    document.getElementById(`${targetField}-suggestions`).innerHTML = "";
  }
}

// Add this function globally so it can be called from the HTML
window.selectAddress = function (targetField, address) {
  document.querySelector(`[data-autocomplete-target='${targetField}']`).value = address;
  document.getElementById(`${targetField}-suggestions`).innerHTML = "";
}
