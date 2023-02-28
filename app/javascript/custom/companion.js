// if (navigator.serviceWorker) {
//   navigator.serviceWorker.register("/service-worker.js", { scope: "/" })
//   .then(() => navigator.serviceWorker.ready)
//   .then((registration) => {
//     if ("SyncManager" in window) {
//       registration.sync.register("sync-forms");
//     } else {
//       window.alert("This browser does not support background sync.")
//     }
//   }).then(() => console.log("[Companion]", "Service worker registered!"));
// }
if (navigator.serviceWorker) {
  navigator.serviceWorker.register("/service-worker.js", { scope: "/" })
  .then(() => navigator.serviceWorker.ready)
  .then((registration) => {
    if ("SyncManager" in window) {
      registration.sync.register("sync-forms");
      console.log("[Companion]", "Background sync registered!");
    } else {
      console.log("[Companion]", "Background sync is not supported.");
    }
  }).then(() => console.log("[Companion]", "Service worker registered!"));
}
