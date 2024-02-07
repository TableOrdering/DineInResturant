importScripts("https://www.gstatic.com/firebasejs/8.10.1/firebase-app.js");
importScripts(
  "https://www.gstatic.com/firebasejs/8.10.1/firebase-messaging.js"
);

const firebaseConfig = {
  apiKey: "AIzaSyASe9g9KfPYN_P_9DfRtNwGjYCWY3e_zCs",
  appId: "1:472336418917:web:1810e4e327700153a95e8c",
  messagingSenderId: "472336418917",
  projectId: "dinein-18fe0",
  authDomain: "dinein-18fe0.firebaseapp.com",
  storageBucket: "dinein-18fe0.appspot.com",
  measurementId: "G-PE37PZF35K",
};

firebase.initializeApp(firebaseConfig);

const messaging = firebase.messaging();

messaging.onBackgroundMessage((payload) => {
  console.log("Received background message.");
});

// messaging.setBackgroundMessageHandler(function (payload) {
//     const promiseChain = clients
//         .matchAll({
//             type: "window",
//             includeUncontrolled: true
//         })
//         .then(windowClients => {
//             for (let i = 0; i < windowClients.length; i++) {
//                 const windowClient = windowClients[i];
//                 windowClient.postMessage(payload);
//             }
//         })
//         .then(() => {
//             return registration.showNotification("there is new message!");
//         });
//     return promiseChain;
// });
// self.addEventListener('notificationclick', function (event) {
//     console.log('notification received: ', event);
// });
