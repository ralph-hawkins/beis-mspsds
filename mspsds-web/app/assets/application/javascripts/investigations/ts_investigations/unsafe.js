import $ from 'jquery';
import {simpleAccessibleAutocomplete} from "../../autocomplete";

$(document).ready(() => {
    const addDeleteFunctionality = link => {
        link.addEventListener('click', e => {
            e.preventDefault();
            $(e.target).parent().parent().remove()
        })
    };

    const addHazardLink =  $('.add-hazard-link')[0];
    addDeleteFunctionality($('.delete-hazard-link')[0]);

    addHazardLink.addEventListener('click', e => {
        e.preventDefault();
        const $allHazardsContainer = $('#hazard-type-auto-complete-group-container');
        const $newHazardSelect = $('#hazard-type-auto-complete-container').clone(true);
        addDeleteFunctionality($newHazardSelect.find('a')[0]);
        $allHazardsContainer.append($newHazardSelect)
        // const newSelectId = ("hazard-type-picker" + Math.random()).replace(/\./, '');
        // $newHazardSelect.find('select').attr('id', newSelectId);
        // $("[id^=hazard-type-picker]")
        //     .toArray()
        //     .forEach(elem => simpleAccessibleAutocomplete(elem.id, { showAllValues: true }))
    });
});
