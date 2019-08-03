$(function() {
  console.log("Loading..!")
  listningCompaniesLoad();
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
    <p class="card-text">${this.description.substring(0, 20)}...</p>
    <button class="js-read-more btn btn-info btn-sm" data-id="${this.id}"> Read More </button>
    </div>
    `
  }
}

function listningCompaniesLoad() {
  $.get("/companies" + ".json", function(res) {
    console.log(res)
    const wrapper = document.getElementById("companies-wrapper");
    res.forEach(function(companyData) {
      const company = new Company(companyData)
      wrapper.innerHTML += company.indexHTML();
    })
  })


}
