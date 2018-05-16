window.addEventListener('load', () => {
    $('.rtwtt').on('click', function (e) {
        if (this.dataset.originalTwtt != '') {
            id = this.dataset.originalTwtt;
        } else {
            id = this.dataset.twtt;
        }
        var url = '/rtwtt?&id=' + id;
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

    $('.fav').on('click', function (e) {
        id = this.dataset.twtt;
        var url = '/fav?&id=' + id;
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

    $(window).scroll(function(e) {

        if($(window).scrollTop() + $(window).height() >= $(document).height()) {

            var nodes = document.querySelectorAll('.last-date');
            var first = nodes[0];
            var last_date = nodes[nodes.length- 1].dataset.last;

            loadMoreData(last_date);
        }

    });


    function loadMoreData(last_date){

        var url = '/home';
        fetch(url, {
                method: 'post',
                headers: {
                    "Content-type": "application/x-www-form-urlencoded; charset=UTF-8"
                },
                body: 'last_date=' + last_date,
                credentials: 'include'
            })
            .then(json)
            .then(function (data) {
                console.log('Request succeeded with JSON response', data);
                document.querySelector('#twtts').innerHTML += data.html;
            })
            .catch(function (error) {
                console.log('Request failed', error);
            });
    }        
})

const json = (response) => {
    return response.json()
}