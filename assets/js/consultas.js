export default () => fetch('./assets/sql/dvdrental_consultas.sql')
    .then(response => response.text())
    .then(data => {
        document.querySelector('#sql-queries-content').innerHTML = `<pre><code>${data}</code></pre>`
    })