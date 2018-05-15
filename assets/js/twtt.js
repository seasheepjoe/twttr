window.addEventListener('load', () => {
    const data = {};

    const twttContent = $('#twtt-content');

    $('.new-twtt').submit(() => {
        data.content = twttContent.val();
        console.log(twttContent.val());
        newTwtt(data);
        return false;
    })
});

function newTwtt (data) {
    var url = '/newTwtt';
    fetch(url, {
            method: 'post',
            headers: {
                "Content-type": "application/x-www-form-urlencoded; charset=UTF-8"
            },
            body: JSON.stringify(data),
            credentials: 'include'
        })
        .then(json)
        .then(function (response) {
            console.log('Request succeeded with JSON response', response);
            if (response.status == true) {
                $('#twtts').prepend(response.html);
            } else if (response.status === false) {
                console.log(response);
            }
        })
        .catch(function (error) {
            console.log('Request failed', error);
        });
}