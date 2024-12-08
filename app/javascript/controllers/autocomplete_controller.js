import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["input", "dropdown"];

  connect() {
    this.inputTarget.addEventListener("input", () => this.onInputChange());
    document.addEventListener("click", (e) => {
      if (!this.dropdownTarget.contains(e.target) && e.target !== this.inputTarget) {
        this.dropdownTarget.style.display = "none";
      }
    });
  }

  onInputChange() {
    const query = this.inputTarget.value;

    if (query.length < 2) {
      this.dropdownTarget.innerHTML = ""; // Clear dropdown if query is too short
      this.dropdownTarget.style.display = "none";
      return;
    }

    fetch(`/locations/search?q=${encodeURIComponent(query)}`)
      .then((response) => response.json())
      .then((data) => {
        this.dropdownTarget.innerHTML = "";

        if (data.length === 0) {
          this.dropdownTarget.style.display = "none";
          return;
        }

        data.forEach((location) => {
          const option = document.createElement("div");
          option.className = "autocomplete-item";
          option.textContent = `${location.name}, ${location.address}`;
          option.dataset.value = location.address;

          option.addEventListener("click", () => {
            this.inputTarget.value = location.address;
            this.dropdownTarget.innerHTML = "";
            this.dropdownTarget.style.display = "none";
          });

          this.dropdownTarget.appendChild(option);
        });

        this.dropdownTarget.style.display = "block";
      });
  }
}
