import $ from 'jquery';
import {simpleAccessibleAutocomplete} from "../../autocomplete";

$(document).ready(() => {
    $("[id^=hazard-type-picker]").toArray().forEach(e => {
        simpleAccessibleAutocomplete(e.id, { showAllValues: true });
    });

    const addHazardLink =  $('.add-hazard-link')[0];

    addHazardLink.addEventListener('click', e => {
            e.preventDefault();
            $('#hazard-type-auto-complete-container.display-none')
                .first()
                .removeClass('display-none')
    });

    $('.delete-hazard-link')
        .toArray()
        .forEach(link => {
            link.addEventListener('click', e => {
                e.preventDefault();
                $(e.target).parent().parent().addClass('display-none')
        })
    });
});
