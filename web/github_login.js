async function initLogin(isLinkOperation){
    var provider = new firebase.auth.GithubAuthProvider();

    provider.addScope('repo');
    provider.addScope('user');
    provider.addScope('gist');
    provider.addScope('user:email');
    provider.setCustomParameters({
      'allow_signup': 'true'
    });

    var result;

    if(!isLinkOperation.value){
        result = await firebase
          .auth()
          .signInWithPopup(provider)
          .then((result) => {
            /** @type {firebase.auth.OAuthCredential} */
            var credential = result.credential;

            // This gives you a GitHub Access Token. You can use it to access the GitHub API.
            var token = credential.accessToken;

            // The signed-in user info.
            var user = result.user;

            return token;

          }).catch((error) => {
            // Handle Errors here.
            var errorCode = error.code;
            var errorMessage = error.message;
            // The email of the user's account used.
            var email = error.email;
            // The firebase.auth.AuthCredential type that was used.
            var credential = error.credential;

            return "error:" + errorMessage;
          });

          return result;
    } else{
     result = await firebase
              .auth()
              .currentUser
              .linkWithPopup(provider)
              .then((result) => {
                /** @type {firebase.auth.OAuthCredential} */
                var credential = result.credential;

                // This gives you a GitHub Access Token. You can use it to access the GitHub API.
                var token = credential.accessToken;

                // The signed-in user info.
                var user = result.user;

                return token;

              }).catch((error) => {
                // Handle Errors here.
                var errorCode = error.code;
                var errorMessage = error.message;
                // The email of the user's account used.
                var email = error.email;
                // The firebase.auth.AuthCredential type that was used.
                var credential = error.credential;

                return "error:" + errorMessage;
              });

              return result;
    }
}
