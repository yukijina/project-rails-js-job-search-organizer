$(function() {
  console.log("Loading..!")
  if (window.location.pathname === "/companies") {
    listeningCompaniesLoad()
  } else if (window.location.pathname.includes("/users")) {
    displayChecklist();
  } else if (window.location.pathname.includes("/companies") && /\d/.test(window.location.pathname)) {
    displayCompanyShow();
  }
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
    <a href="/companies/${this.id}" class="js-positions btn btn-info btn-sm" data-id="${this.id}">Check Positions</a>
    </div>
    `
  }
}
// <a href="/companies/${this.id}" class="js-positions btn btn-info btn-sm" data-id="${this.id}">Check Positions</a>

class Position {
  constructor(data) {
    this.id = data.id;
    this.title = data.title;
    this.description = data.description;
    this.salary = data.salary;
    this.fullTime = data.full_time;
    this.created = data.created_at;
    this.updated = data.updated_at;
    this.companyId = data.company_id;
  }
  positionFormatHTML() {
    return `
      <div id="position-wrapper-${this.id}">
        <h2>${this.title}</h2>
        <p>${this.description.substring(0, 5)}...</p>
        <p>Salary: ${this.salary} a year</p>
        <button class="js-position btn btn-info btn-sm" data-id="${this.id}" data-companyid="${this.companyId}">More info</button>
      </div>
    `
  }
  positionDetailsHTML() {
    return `
      <div>
      <h2>${this.title}</h2>
      <p>Description: ${this.description}</p>
      <p>Full Time: ${this.fullTime}</p>
      <p>Position Created: ${this.created}</p>
      <p>Updated: ${this.updated}</p>
      </div>
    `
  }
}


function listeningCompaniesLoad() {
  $.get("/companies" + ".json", function(res) {
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

// Company Show Page
function displayCompanyShow() {
    console.log("Now show")
    let positionsWrapper = document.getElementById("positions-wrapper")
    const id = positionsWrapper.dataset.id;
    $.get("/companies/" + id + ".json", function(res) {
      const company = new Company(res)
      res.positions.forEach(function(positionData) {
        let position = new Position(positionData)
        positionsWrapper.innerHTML += position.positionFormatHTML();
        positionDetails();
      })
  })
}


function positionDetails() {
  $(".js-position").on("click", function(e) {
    e.preventDefault();
    console.log("clicked!")
    const positionId = this.dataset.id;
    const companyId = this.dataset.companyid;
    $.get("/companies/" + companyId + "/positions/" + positionId + ".json", function(res) {
      console.log(res)
        const position = new Position(res)
        const positionDiv = document.getElementById(`position-wrapper-${positionId}`)
        positionDiv.innerHTML = position.positionDetailsHTML();
      })
  })
}
