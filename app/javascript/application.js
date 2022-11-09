import "@hotwired/turbo-rails"
import "controllers"
import "./plugins/fslightbox"

fsLightbox.props.type = 'image'

 function myFunction() {
    let sum = 0;
    let add = document.querySelectorAll('input[type=number]')
    for(let i = 0; i<add.length; i++){
        sum += add[i].value
    }
    document.getElementById("myspan").textContent=sum;
}