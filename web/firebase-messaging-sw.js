importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js");

firebase.initializeApp({
    apiKey: "AIzaSyBEwYzYqg95xAD1uBVne77mSWAHmSsBikU",
    authDomain: "project-ilu.firebaseapp.com",
    projectId: "project-ilu",
    storageBucket: "project-ilu.appspot.com",
    messagingSenderId: "808420470780",
    appId: "1:808420470780:web:8817bba3c7c660915b8c79",
    measurementId: "G-1WRKYSBERS"
});

//firebase.initializeApp(firebaseConfig);

const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((message) => {
  console.log("onBackgroundMessage", message);
  // Customize notification here
  const notificationTitle = payload.notification.title;
  const notificationOptions = {
    body: payload.notification.body,
    icon: 'favicon.png'
  };

  self.registration.showNotification(notificationTitle, notificationOptions);
});