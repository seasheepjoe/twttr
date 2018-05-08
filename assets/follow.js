window.addEventListener('load', () => {
    document.querySelector('form[name="follow"]').addEventListener('submit', (e) => {
        e.preventDefault();
        $.ajax({
            method: 'post',
            url: e.target.action,
            data: {
                followed: e.target.elements['follow'].dataset.followed,
                follower: e.target.elements['follow'].dataset.follower
            },
            dataType: 'json',
            success: (response) => {
                console.log(response);
            },
            error: (err, response) => {
                console.log(err);
            }
        });
        return false;
    });
});