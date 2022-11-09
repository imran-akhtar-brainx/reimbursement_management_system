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
            let field = document.createElement("input");
            if (key == 'day'){
                field = document.createElement("select");
                var optionElement1 = document.createElement("option");
                var optionElement2 = document.createElement("option");
                var optionElement3 = document.createElement("option");
                optionElement1.value = "Full Day";
                optionElement1.text = "Full Day"
                optionElement2.value = "Half Day"
                optionElement2.text = "Half Day"
                optionElement3.text = "Select Day Type"
                optionElement3.selected = true;
                field.appendChild(optionElement1)
                field.appendChild(optionElement2)
                field.appendChild(optionElement3)
            }
            field.classList.add(["border-none"]);
            field.setAttribute("id", "data" + `[${this.counterValue}]` + `[${key}]`)
            field.setAttribute("name", "data" + `[${this.counterValue}]` + `[${key}]`)
            field.setAttribute("required", true)
            if (key == "amount") {
                field.setAttribute("type", "number")
            }
            if (key == "date") {
                field.setAttribute("type", "date")
            }
            tableData.appendChild(field);
            element.appendChild(tableData);
        })
        document.getElementById(`${this.typeValue}` + "-table").appendChild(element);
    }
}
