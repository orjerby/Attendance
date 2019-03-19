export const MISS = 1;
export const LATE = 2;
export const HERE = 3;
export const JUSTIFY = 4
export const ALL_STATUSES = 5

export const LECTURER = 2;
export const STUDENT = 3;
export const LOCATION_MANAGER = 4;

export const FORM_WAITING = 1;
export const FORM_ACCEPTED = 2;
export const FORM_DENIED = 3;

// fetch function
export function fetchData(url, paramsObj) {
    return fetch(url, {
        method: 'POST',
        body: JSON.stringify(paramsObj),
        headers: { "Content-type": "application/json; charset=UTF-8" }
    })
        .then(response => response.json())
        .then(response => response.d)
}

export const WebServiceURL = "http://ruppinmobile.tempdomain.co.il/SITE05/RuppinWebService.asmx/";