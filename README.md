# Cargster
*"Effortlessly find the right carrier or forwarder for your specific needs"*

www.cargster.co
## Tech stack
- Rails 7.0.4
- Ruby 3.1.2
- Postgres
- Bootstrap 5
- MapboxGL
- Postmark
- Heroku
## Intro & Goal
The Goal of this app is to simplify the transportation industry on the Balkans with a simple, user-friendly web app that connects carriers with shippers. This app is more than just a listing page for trucks and loads. We are working on creating a community of industry professionals, where they can easily connect and collaborate.
## Who’s it for?
- **Small carriers** - companies and individuals providing shipping services with small fleets of trucks or vans.
- **Shippers** - businesses that need to transport goods, mostly SME’s.
## What is it?
### Glossary
- **Truck search** - a posting for available truck
- **Load search** - a posting for available load
### User types
- **Registered users** - people that have registered and completed their profile, they can search for both available trucks and loads.
### Index View
The Index View (homepage) displays the list of the current user recent searches, both active and inactive ones. 

<img width="100%" alt="Index_cargster" src="https://user-images.githubusercontent.com/76739673/220407383-7a7c2671-38e5-487f-adb9-bac9ea03389c.png">

### Detailed View
The Detailed View displays information about the search but expanded with other details.
```ruby
if @post.user == current_user
  if @post.status?
    render "edit_search_btn"
    render "share_search_btn"
    render "deactivate_btn"
    if !@post.matches.nil?
      render "matches"
    else
      render "invite_btn"
    end
  else
    render "reactivate_post_btn"
  end
else
  render "contact_buttons"
  render "post_info"
end
```
<img width="100%" alt="Show_cargster" src="https://user-images.githubusercontent.com/76739673/220420465-5652b103-5afb-4aa5-b839-cb4f52a1903b.png">
<img width="100%" alt="Show_2_cargster" src="https://user-images.githubusercontent.com/76739673/220420457-d9454d52-30cd-4830-bbb6-bbb20dd6d5c5.png">

### Search
Each post must contain:
- **Loading date** - preferred date of collecting the load
- **Type of truck** - Multiple select, since a truck can be many types at once
- **Pickup** - Geocoded by country, region, or city
- **Dropoff**  - same type as pickup
- **Length** - Meters that a load takes

Optionally:
- **Weight** - tons
- **Comments** - additional info like: truck plates, reference number, working hours, driver’s name, etc.

<img width="100%" alt="Search_new_cargster" src="https://user-images.githubusercontent.com/76739673/220422281-34a62505-4d07-4c6f-a74f-f833ff2aecef.png">

### Quick search
- Most of the carriers and shippers are making the same searches but only the date is different, so with this feature they can create a search easily and only adjust the loading date.
- Some shippers need the same truck multiple times over different dates.

<img width="100%" alt="Quick_search_cargster" src="https://user-images.githubusercontent.com/76739673/220422853-84462b4e-91d5-4f0e-b3d5-0be83cc12a38.png">

### Registration
Every user must register with Email

Additionally, they must complete their profile with:
- Full name
- Mobile number
- Company Name, full address, VAT, company id.

## DB Schema

<img width="100%" alt="Screenshot 2023-02-22 at 11 53 26" src="https://user-images.githubusercontent.com/76739673/220599890-ba4009c5-006d-4897-874e-c1fbb980985b.png">

