export default (
    headers,
    data,
    key
) => {
    const thead = headers.map(header => `<th scope="col">${header}</th>`).join('')
    const tbody = data
        .map(row =>
            `<tr>
            ${headers.map(header => `<td>${row[header]}</td>`).join('')}
            </tr>`
        )
        .join('')
    return `
            <table class="table table-striped table-bordered caption-top my-5" id="${key}">
                <caption class="text-center h2">${key}</caption>
                <thead>${thead}</thead>
                <tbody class="table-group-divider">${tbody}</tbody>
            </table>
            `
}