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
    <p class="card-text">URL: ${this.url}</p>
    <p class="card-text" id="js-description">${this.description.substring(0, 20)}...</p>
    <button class="js-read-more btn btn-info btn-sm" > Read More </button>
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
  const descriptionDiv = document.getElementById("js-description");
  document.querySelector(".js-read-more").addEventListener("click", function(e) {
    e.preventDefault();
    $.get("/companies" + ".json", function(res) {
      res.forEach(function(companyData) {
        descriptionDiv.innerText = new Company(companyData).description
      })
    })
  })
}
