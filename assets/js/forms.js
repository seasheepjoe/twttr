window.addEventListener('load', () => {

    const data = {};
    const username = document.querySelector('#username');
    const email = document.querySelector('#email');
    const password = document.querySelector('#password');
    const passwordRepeat = document.querySelector('#password-repeat');
    const emailRegex = /^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$/;

    username.onkeyup = () => {
        if (username.value.length <= 2 || username.value.length > 25) {
            $('#err-name').html('Username must be 3-25');
        } else {
            $('#err-name').html('Username ok');
            data.name = username.value;
        }
    }

    email.onkeyup = () => {
        if (!emailRegex.test(email.value)) {
            $('#err-email').html('Email must be an email');
        } else {
            $('#err-email').html('Email ok');
            data.email = email.value;
        }
    }

    password.onkeyup = () => {
        if (password.value.length <= 5 || password.value.length > 15) {
            $('#err-password').html('Password muste be 5-15');
        } else {
            $('#err-password').html('Password ok');
            data.password = password.value;
        }
    }

    passwordRepeat.onkeyup = () => {
        if (passwordRepeat.value !== password.value) {
            $('#err-password-repeat').html('Passwords must be the same !');
        } else {
            $('#err-password-repeat').html('Passwords ok');
            data.passwordRepeat = passwordRepeat.value;
        }
    }

    $('.register-form').submit(() => {
        register(data);
        console.log(data);
        return false;
    });
});

function register(data) {
    var url = '/register';
    fetch(url, {
            method: 'post',
            headers: {
                "Content-type": "application/x-www-form-urlencoded; charset=UTF-8"
            },
            body: 'data=' + JSON.stringify(data),
            credentials: 'include'
        })
        .then(json)
        .then(function (data) {
            console.log('Request succeeded with JSON response', data);
        })
        .catch(function (error) {
            console.log('Request failed', error);
        });
}

const json = (response) => {
    return response.json()
}