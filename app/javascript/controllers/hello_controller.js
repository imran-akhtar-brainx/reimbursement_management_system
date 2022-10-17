import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["form"]
    static values = {url: Array, counter: Number, type: String}

    connect() {
        this.formList = [];
    }

    greet() {
        const element = this.nameTarget
        const name = element.value
        console.log(`Hello, ${name}!`)
    }

    createElement() {
        debugger
        this.counterValue+=1
        console.log(this.typeValue)
        const element = document.createElement("tr");
        this.urlValue.forEach(key => {
            if (key != "reporting_manager" && key != "project_name" && key != "relationship_with_employee" && key != "name_of_patient" && key!="signature") {
                const dt = document.createElement("td");
                const field = document.createElement("input");
                field.classList.add(["border-none"]);
                field.setAttribute("id", "data"+`[${this.counterValue}]`+`[${key}]`)
                field.setAttribute("name", "data"+`[${this.counterValue}]`+`[${key}]`)
                dt.appendChild(field);
                element.appendChild(dt);
            }
            console.log(key)
        })
        document.getElementById(`${this.typeValue}`+"-table").appendChild(element);
    }
}
