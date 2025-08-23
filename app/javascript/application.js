// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener("turbo:load", function () {
    var body_field = document.getElementById("comment_body.id"),
        submit_button = document.getElementById("comment_submit.id");

    if (body_field && submit_button) {
        body_field.addEventListener("input", function () {
            submit_button.disabled = body_field.value.trim() === "";
        });
    }
});