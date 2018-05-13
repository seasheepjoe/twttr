window.addEventListener('load', () => {

    const data = {};
    const username = $('#username');
    const email = $('#email');
    const password = $('#password');
    const passwordRepeat = $('#password-repeat');
    const emailRegex = /^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$/;

    username.keyup(() => {
        if (username.val().length <= 2 || username.val().length > 25) {
            invalidate(username);
            $('#register-username-error').html('Username must be 3-25');
        } else {
            $('#register-username-error').html('Username ok');
            data.name = username.val();
            validate(username);
        }
    })

    email.keyup(() => {
        if (!emailRegex.test(email.val())) {
            $('#register-email-error').html('Email must be an email');
            invalidate(email);
        } else {
            $('#register-email-error').html('Email ok');
            data.email = email.val();
            validate(email);
        }
    })

    password.keyup(() => {
        if (password.val().length <= 5 || password.val().length > 15) {
            $('#register-password-error').html('Password must be 5-15');
            invalidate(password);
        } else {
            $('#register-password-error').html('Password ok');
            data.password = password.val();
            validate(password);
        }
    })

    passwordRepeat.keyup(() => {
        if (passwordRepeat.val() !== password.val()) {
            $('#register-password-repeat-error').html('Passwords must be the same !');
            invalidate(passwordRepeat);
        } else {
            $('#register-password-repeat-error').html('Passwords ok');
            data.passwordRepeat = passwordRepeat.val();
            validate(passwordRepeat);
        }
    })

    $('.register-form').submit(() => {
        register(data);
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
            body: JSON.stringify(data),
            credentials: 'include'
        })
        .then(json)
        .then(function (response) {
            console.log('Request succeeded with JSON response', response);
            if (response.status == true) {
                window.location = 'home';
            } else if (response.status === false) {
                displayErrMsg(response);
            }
        })
        .catch(function (error) {
            console.log('Request failed', error);
        });
}

const json = (response) => {
    return response.json()
}

const displayErrMsg = (data) => {

    $('.register-errors').html(' ');

    form = $('form[name="register-form"]')[0];   
    
    delete data.status;

    for (var i = 0; i < form.elements.length; i++) {
        form.elements[i].classList.remove('is-valid');
    }
    for (var i in data) {
        form.querySelector(`#register-${i}-error`).innerHTML = data[i];
        form.querySelector(`#register-${i}-error`).parentElement.querySelector('input').classList.add('is-invalid');
    }
}

const validate = (input) => {
    input[0].classList.add('is-valid');
    input[0].classList.remove('is-invalid');
}

const invalidate = (input) => {
    input[0].classList.add('is-invalid');
    input[0].classList.remove('is-valid');
}