class Checklist {
  constructor(data) {
    this.id = data.id;
    this.resume = data.resume;
    this.interview = data.interview;
    this.complete = data.complete;
    this.note = data.note;
    this.userId = data.user_id;
    this.companyId = data.company_id;
    this.positionId = data.position_id;
  }
  formatChecklist() {
    return `

    `
  }
}
