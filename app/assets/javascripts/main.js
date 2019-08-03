$(function() {
  console.log("Loading..!")
  listeningCompaniesLoad();
})

class Company {
  constructor(data) {
    this.id = data.id;
    this.name = data.name;
    this.url = data.url;
    this.description = data.description;
  };
  indexHTML() {
    return `
    <div class="card-body">
    <h2 class="card-title">${this.name}</h2>
    <a href="${this.url}" class="card-text" target="_blank"><i class="fas fa-globe"></i> Website</a>
    <p class="card-text js-description-${this.id}">${this.description.substring(0, 20)}...</p>
    <button class="js-read-more btn btn-info btn-sm" data-id="${this.id}"> Read More </button>
    </div>
    `
  }
}

function listeningCompaniesLoad() {
  $.get("/companies" + ".json", function(res) {
    console.log(res)
    const wrapper = document.getElementById("companies-wrapper");
    res.forEach(function(companyData) {
      const company = new Company(companyData)
      wrapper.innerHTML += company.indexHTML();
      clickReadMore();
    })
  })
}

function clickReadMore() {
  $(".js-read-more").on("click", function(e) {
    e.preventDefault();
    const id = this.dataset.id;
    $.get("/companies/" + id + ".json", function(res) {
      const company = new Company(res)
      const descriptionDiv = document.querySelector(`.js-description-${company.id}`);
      descriptionDiv.innerText = company.description
    })
  })
}
