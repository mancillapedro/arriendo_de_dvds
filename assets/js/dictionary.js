import tableTemplate from './tableTemplate.js';

export default () => fetch('./assets/csv/Diccionario_de_datos.csv')
    .then(response => response.text())
    .then(data => {

        const dataToArray = data.split('\n').map(element => element.split(',')).slice(0, -1);
        const headers = (dataToArray.splice(0, 1)[0]).map(element => element.replace(/"/g, '')).slice(1);

        const dataToObj = dataToArray.reduce((total_data, value_data) => {
            total_data[value_data[0]] ||= []
            total_data[value_data[0]].push(
                value_data
                    .slice(1)
                    .reduce((total, value, index) => {
                        total[headers[index]] = value;
                        return total;
                    }, {})
            )
            return total_data;
        }, {})

        const container = document.querySelector('#dictionary-content')
        Object.keys(dataToObj).forEach(key =>
            container.innerHTML += tableTemplate(headers, dataToObj[key], key)
        )
    })