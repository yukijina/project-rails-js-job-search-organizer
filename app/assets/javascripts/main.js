$(function() {
  console.log("Loading..!")
  if (window.location.pathname === "/companies") {
    listeningCompaniesLoad()
  } else if (window.location.pathname.includes("/companies") && /\d/.test(window.location.pathname) && !window.location.pathname.includes("/positions")) {
    displayCompanyShow();
  } else if (window.location.pathname.includes("/companies") && /\d/.test(window.location.pathname) && window.location.pathname.includes("/positions")) {
    diplayWholeDescription();
  } else if (window.location.pathname.includes("/companies") && /\d/.test(window.location.pathname) && window.location.pathname.includes("/positions") && /\d/.test(window.location.pathname)) {
    displayPositionShow()
  } else if (window.location.pathname.includes("/positions/new")) {
    diplayCompanyForm()
    postCompanyandPosition()
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
    <button class="js-positions btn btn-info btn-sm" data-id="${this.id}">Check Positions</button>
    <a href="/companies/${this.id}/edit" class="btn btn-outline-warning btn-sm">Edit this company</a>
    <hr style="margin: 30px;">
    <div class="append-positions-${this.id}" style="display:none;"></div>
    </div>
    `
  }
  showHTML() {
    return `
    <a href="${this.url}" target="_blank"><i class="fas fa-globe"></i> Website</a>
    <p class="js-description-${this.id} my-4">${this.description}</p>
    <a href="/companies/${this.id}/edit" class="btn btn-outline-warning">Edit company's information</a>
    `
  }
}

class Position {
  constructor(data) {
    this.id = data.id;
    this.title = data.title;
    this.description = data.description;
    this.salary = data.salary === 0 ? "n/a" : `$${data.salary}`;
    this.fullTime = data.full_time === true ? "Yes" : "n/a" ;
    this.created = data.created_at.slice(0,10);
    this.updated = data.updated_at.slice(0,10);
    this.companyId = data.company_id;
  }
  positionFormatHTML() {
    return `
      <div id="position-wrapper-${this.id}" class="mb-4">
        <h2>${this.title}</h2>
        <p>${this.description.substring(0, 20)}...</p>
        <p>Salary: ${this.salary} a year</p>
        <button class="js-position btn btn-outline-info btn-sm" data-id="${this.id}" data-companyid="${this.companyId}">More info</button>
      </div>
    `
  }
  positionDetailsHTML() {
    return `
      <h2>${this.title}</h2>
      <p>Description: ${this.description}</p>
      <p>Salary: ${this.salary} a year</p>
      <p>Full Time: ${this.fullTime}</p>
      <p>Position Created: ${this.created}</p>
      <p>Updated: ${this.updated}</p>
      <a href="/companies/${this.companyId}/positions" class="js-add-checklist btn btn-outline-info btn-sm" data-id="${this.id}" data-companyid="${this.companyId}">Go to List</a>
      <a href="/companies/${this.companyId}/positions/${this.id}/edit" class="btn btn-outline-warning btn-sm">Edit this position</a>
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
      displayPositions();
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

//Display positions in index page
function displayPositions() {
  $(".js-positions").on("click", function(e) {
    e.preventDefault();
    const companyId = this.dataset.id;
    $.get("/companies/" + companyId + ".json", function(res) {
      let positions = res.positions.map(function(position) {
        return new Position(position).positionFormatHTML()
      }).join("")
      const div = document.querySelector(`.append-positions-${companyId}`)
        div.innerHTML = positions
        if (div.style.display === "none") {
          div.style.display = "block"
        } else {
          div.style.display = "none"
        }
        positionDetails()
    })
  })
}

// Display position Details
function positionDetails() {
  $(".js-position").on("click", function(e) {
    e.preventDefault();
    console.log("clicked!")
    const positionId = this.dataset.id;
    const companyId = this.dataset.companyid;
    $.get("/companies/" + companyId + "/positions/" + positionId + ".json", function(res) {
        const position = new Position(res)
        const positionDiv = document.getElementById(`position-wrapper-${positionId}`)
        positionDiv.innerHTML = position.positionDetailsHTML();
      })
  })
}

// Company Show Page
function displayCompanyShow() {
  console.log("Now company show")
  let companyWrapper = document.getElementById("company-wrapper");
  if (companyWrapper !== null) {
    let positionsWrapper = document.getElementById("positions-wrapper");
    const id = positionsWrapper.dataset.id;

    $.get("/companies/" + id + ".json", function(res) {
      const company = new Company(res)
      companyWrapper.innerHTML += company.showHTML();

      res.positions.forEach(function(positionData) {
        let position = new Position(positionData)
        positionsWrapper.innerHTML += position.positionFormatHTML();
        positionDetails();
      })
    })
  } else {
    return;
  }
}

//Company New page. Post data.
function postCompanyandPosition() {
  $("form").submit(function(e) {
    e.preventDefault();
    const values = $(this).serialize();
    $.post('/positions', values)
    .done(function(data) {
        alert("Successfuly created!")
        window.location.replace(`/companies/${data.company.id}/positions/${data.id}`)
    })
  })
}

function diplayCompanyForm() {
  console.log("want to display company form?")
  document.getElementById("js-create-company-btn").addEventListener("click", function(e) {
    e.preventDefault();
    const div = document.getElementById("js-new-company")
    if (div.style.display === "none") {
      div.style.display = "block";
    } else {
      div.style.display = "none"
    }
  })
}

function diplayWholeDescription() {
  console.log("change descriptin")
  $(".js-truncate").on("click", function(e) {
    e.preventDefault();
    let positionId = this.dataset.id;
    let companyId = this.dataset.companyid;
    $.get("/companies/" + companyId + "/positions/" + positionId + ".json", function(res) {
      let link = document.getElementsByClassName(`link-${positionId}`)[0];
      link.innerText = new Position(res).description;
    })
  })
}

// Render via Ruby
// function listeningPositionsLoad() {
//   console.log("loading all the positions!")
//   $.get("/positions" + ".json", function(res) {
//     const div = document.getElementById("all-positions");
//     res.forEach(function(positionData) {
//
//       let position = new Position(positionData)
//       let companyName = new Company(positionData.company)
//       let text = companyName.name
//       div.innerHTML += text + position.positionFormatHTML();
//       positionDetails()
//     })
//   })
// }
