importScripts(
"https://storage.googleapis.com/workbox-cdn/releases/6.4.1/workbox-sw.js"
);

const { precacheAndRoute } = workbox.precaching;

// Exclude background sync from the Workbox service worker
const workboxOptions = {
  exclude: [workbox.backgroundSync.Plugin],
};

// Precache and route the assets in your application
precacheAndRoute(self.__WB_MANIFEST, workboxOptions);

function onInstall(event) {
  console.log('[Serviceworker]', "Installing!", event);
}

function onActivate(event) {
  console.log('[Serviceworker]', "Activating!", event);
}

function onFetch(event) {
  console.log('[Serviceworker]', "Fetching!", event);
}
self.addEventListener('install', onInstall);
self.addEventListener('activate', onActivate);
self.addEventListener('fetch', onFetch);
