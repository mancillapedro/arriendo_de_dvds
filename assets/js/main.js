import dictionary from './dictionary.js';
import consultas from './consultas.js';

addEventListener('DOMContentLoaded', () => {
    const navDictionary = document.querySelector('#dictionary');
    const navQuery = document.querySelector('#sql-queries');
    const dictionaryContent = document.querySelector('#dictionary-content');
    const sqlQueriesContent = document.querySelector('#sql-queries-content');


    navQuery.addEventListener('click', () => {
        dictionaryContent.classList.add('d-none')
        sqlQueriesContent.classList.remove('d-none')
        navQuery.classList.add('active');
        navDictionary.classList.remove('active');
    })
    navDictionary.addEventListener('click', () => {
        dictionaryContent.classList.remove('d-none')
        sqlQueriesContent.classList.add('d-none')
        navQuery.classList.remove('active');
        navDictionary.classList.add('active');
    })

    dictionary()
    consultas()
})