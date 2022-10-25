import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["form"]
    static values = {url: Array, counter: Number, type: String}

    connect() {
        this.formList = [];
        $('input[name="daterange"]').daterangepicker(
            {

                locale: {
                    cancelLabel: 'Clear',
                    format: 'YYYY-MM-DD'
                },
                startDate: '2022-10-01',
                endDate: '2022-10-26'
            },
            function(start, end, label) {
                alert("A new date range was chosen: " + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD'));
            });

    }

    greet() {
        const element = this.nameTarget
        const name = element.value
        console.log(`Hello, ${name}!`)
    }

    createElement() {
        this.counterValue += 1
        console.log(this.typeValue)
        const element = document.createElement("tr");
        this.urlValue.forEach(key => {
            if (key != "reporting_manager" && key != "project_name" && key != "relationship_with_employee" && key != "name_of_patient" && key != "signature") {
                const dt = document.createElement("td");
                const field = document.createElement("input");
                field.classList.add(["border-none"]);
                field.setAttribute("id", "data" + `[${this.counterValue}]` + `[${key}]`)
                field.setAttribute("name", "data" + `[${this.counterValue}]` + `[${key}]`)
                field.setAttribute("required", true )
                if (key == "amount"){
                    field.setAttribute("type", "number")
                }
                dt.appendChild(field);
                element.appendChild(dt);
            }
        })
        document.getElementById(`${this.typeValue}` + "-table").appendChild(element);
    }
}
