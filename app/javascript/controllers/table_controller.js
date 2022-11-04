import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["form"]
    static values = {row: Array, counter: Number, type: String}

    connect() {
    }

    createElement() {
        this.counterValue += 1
        const element = document.createElement("tr");
        const rowElements = this.rowValue.filter(word => word != 'reporting_manager' && word != 'project_name' && word != 'relationship_with_employee' && word != 'name_of_patient' && word != 'signature')
        rowElements.forEach(key => {
            const tableData = document.createElement("td");
            const field = document.createElement("input");
            field.classList.add(["border-none"]);
            field.setAttribute("id", "data" + `[${this.counterValue}]` + `[${key}]`)
            field.setAttribute("name", "data" + `[${this.counterValue}]` + `[${key}]`)
            field.setAttribute("required", true)
            if (key == "amount") {
                field.setAttribute("type", "number")
            }
            tableData.appendChild(field);
            element.appendChild(tableData);
        })
        document.getElementById(`${this.typeValue}` + "-table").appendChild(element);
    }
}
