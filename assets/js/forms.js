window.addEventListener('load', () => {
    var login = document.querySelector('form[name="login-form"]') ? document.querySelector('form[name="login-form"]') : null;
    if (login != null) {
        login.addEventListener('submit', (e) => {
            e.preventDefault();
            $.ajax({
                method: 'post',
                url: e.target.action,
                data: {
                    email: e.target.elements['email'].value,
                    password: e.target.elements['password'].value
                },
                dataType: 'json',
                success: (response) => {
                    if (response.status == true) {
                        window.location = '/';
                    } else if (response.status === false) {
                        displayErrMsg('login', response);
                    }
                },
                error: (err, response) => {
                    console.log(err);
                }
            });
        })
    }

    var register = document.querySelector('form[name="register-form"]') ? document.querySelector('form[name="register-form"]') : null;
    if (register != null) {
        register.addEventListener('submit', (e) => {
            e.preventDefault();
            $.ajax({
                method: 'post',
                url: e.target.action,
                data: {
                    username: e.target.elements['username'].value,
                    email: e.target.elements['email'].value,
                    password: e.target.elements['password'].value,
                    passwordRepeat: e.target.elements['password-repeat'].value,
                },
                dataType: 'json',
                success: (response) => {
                    if (response.status == true) {
                        window.location = '/';
                    } else if (response.status === false) {
                        displayErrMsg('register', response);
                    }
                },
                error: (err, response) => {
                    console.log(err, response);
                }
            });
        })
    }
});

const displayErrMsg = (action, data) => {
    form = document.querySelector(`form[name="${action}-form"]`);
    delete data.status;
    for (var i = 0; i < form.elements.length; i++) {
        form.elements[i].classList.remove('is-invalid');
    }
    for (var i in data) {
        form.querySelector(`#${action}-${i}-error`).innerHTML = data[i];
        form.querySelector(`#${action}-${i}-error`).parentElement.querySelector('input').classList.add('is-invalid');
    }
}