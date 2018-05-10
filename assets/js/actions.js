window.addEventListener('load', () => {
    $('.rtwtt').click(function (e) {
        id = this.dataset.twtt;
        var url = 'rtwtt?&id=' + id;
        fetch(url, {
                method: 'post',
                headers: {
                    "Content-type": "application/x-www-form-urlencoded; charset=UTF-8"
                },
                body: 'rtwtt',
                credentials: 'include'
            })
            .then(json)
            .then(function (data) {
                console.log('Request succeeded with JSON response', data);
                if (data.action == 'do') {
                    e.currentTarget.classList.add('text-success');
                } else if (data.action == 'undo') {
                    e.currentTarget.classList.remove('text-success');
                }
                e.currentTarget.firstChild.innerHTML = data.rtwtts;
            })
            .catch(function (error) {
                console.log('Request failed', error);
            });
    });

    $('.fav').click(function (e) {
        id = this.dataset.twtt;
        var url = 'fav?&id=' + id;
        fetch(url, {
                method: 'post',
                headers: {
                    "Content-type": "application/x-www-form-urlencoded; charset=UTF-8"
                },
                body: 'fav',
                credentials: 'include'
            })
            .then(json)
            .then(function (data) {
                console.log('Request succeeded with JSON response', data);
                if (data.action == 'do') {
                    e.currentTarget.classList.add('text-warning');
                } else if (data.action == 'undo') {
                    e.currentTarget.classList.remove('text-warning');
                }
                e.currentTarget.firstChild.innerHTML = data.favs;
            })
            .catch(function (error) {
                console.log('Request failed', error);
            });
    });
})

const json = (response) => {
    return response.json()
}