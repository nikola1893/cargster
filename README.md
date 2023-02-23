# Cargster
*"Effortlessly find the right carrier or shipper for your specific needs"*

www.cargster.co

## Intro & Goal
The Goal of this app is to revolutionize the transportation industry with a simple, user-friendly web app that connects carriers with shippers. This app is more than just a listing page for trucks and loads. We are working on creating a community of industry professionals, where they can easily connect and collaborate.
## Who’s it for?
- **Small carriers** - small businesses providing shipping services with small fleets of trucks or vans.
- **Shippers** - small businesses that need to transport goods.
- **Cargo brokers** - individuals who act as intermediaries between shippers and carriers. They arrange transportation and logistics services on behalf of their clients, typically for a fee.
## What is it?

### User types
- **Registered users** - people that have registered and completed their profile, they can search for both available trucks and loads.

### Registration
Every user must register with Email. Additionally, they must complete their profile with:
- Full name
- Mobile number
- Company Name, full address, VAT, company id.

### Index View

The Index View (homepage) displays the list of the current user recent searches, both active and inactive ones. 

<img width="100%" alt="Index_cargster" src="https://user-images.githubusercontent.com/76739673/220407383-7a7c2671-38e5-487f-adb9-bac9ea03389c.png">

*status

### Detailed View
The Detailed View displays information about the search but expanded with other details.

```ruby
@search.user == current_user ? left_screen : right_screen
```

<p><img width="50%" alt="Show_cargster" src="https://user-images.githubusercontent.com/76739673/220420465-5652b103-5afb-4aa5-b839-cb4f52a1903b.png"><img width="50%" alt="Show_2_cargster" src="https://user-images.githubusercontent.com/76739673/220420457-d9454d52-30cd-4830-bbb6-bbb20dd6d5c5.png"></p>

### Search

<img width="100%" alt="Search_new_cargster" src="https://user-images.githubusercontent.com/76739673/220422281-34a62505-4d07-4c6f-a74f-f833ff2aecef.png">

Each search must contain:
- **Loading date** - preferred date of collecting the load
- **Type of truck** - Multiple select, since a truck can be many types at once
- **Pickup** - Geocoded by country, region, or city
- **Dropoff**  - same type as pickup
- **Length** - in meters
- **Weight** - tons 
- **Comments** - additional info like: truck plates, reference number, working hours, driver’s name, etc. (optional)
  
### Quick search

We understand that mose of the users searches are recurring, they can avoid having to repeat the search process for each date, which can be time-consuming and inconvenient.

<img width="100%" alt="Quick_search_cargster" src="https://user-images.githubusercontent.com/76739673/220422853-84462b4e-91d5-4f0e-b3d5-0be83cc12a38.png">

### DB Schema

<img width="100%" alt="Screenshot 2023-02-22 at 11 53 26" src="https://user-images.githubusercontent.com/76739673/220599890-ba4009c5-006d-4897-874e-c1fbb980985b.png">

## Tech stack
- Rails 7.0.4
- Ruby 3.1.2
- Postgres
- Bootstrap 5
- MapboxGL
- Postmark
- Heroku

### Why mobile first?
At our core, we understand that our users are busy people who are always on the go. As small and medium-sized enterprises, they don't have the time or resources to dedicate to a complicated logistics system because they aren't operating on such a scale. Many of our users are already using mobile apps like WhatsApp and Viber for their business communication, so we wanted to make our app just as easy and accessible.
### Feedbacks and Ideas

nikola@cargster.co




