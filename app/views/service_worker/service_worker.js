importScripts(
"https://storage.googleapis.com/workbox-cdn/releases/6.4.1/workbox-sw.js"
);

// app/views/service_worker/service_worker.js
// We first define the strategies we will use and the registerRoute function
const {CacheFirst, NetworkFirst} = workbox.strategies;
const {registerRoute} = workbox.routing;
// If we have critical pages that won't be changing very often, it's a good idea to use cache first with them
registerRoute(
 ({url}) => url.pathname.startsWith('/profile'),
 new CacheFirst({
 cacheName: 'documents',
})
)
// For every other page we use network first to ensure the most up-to-date resources
registerRoute(
({request, url}) => request.destination === "document" ||
 request.destination === ""
 new NetworkFirst({
 cacheName: 'documents',
 })
)
// For assets (scripts and images), we use cache first
registerRoute(
 ({request}) => request.destination === "script" ||
 request.destination === "style",
 new CacheFirst({
 cacheName: 'assets-styles-and-scripts',
 })
)
registerRoute(
 ({request}) => request.destination === "image",
 new CacheFirst({
 cacheName: 'assets-images',
 })
)

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
