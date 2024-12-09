# README

## Book A Cab
This is a Ruby on Rails application for a customer to book a cab for rides and admin to manage the cabs.

### Features
- Users need to log in or sign up to book cabs.
- Users must mark the ride as Completed to finalize the ride and update the total fare on the Your Ride Details page.
- Admins can edit or delete users.
- Admins can create, edit, update, and delete cabs.
- Admins can view the status of all cabs, including their current location, total trips, and total fares earned.
- Cab locations are updated after each ride.
- Cabs are available for booking only after the customer marks the ride as Completed.
- The nearest cab is automatically assigned to the user based on their location.
> [!NOTE]
> Currently, the Cab Booking option is hidden for Admins.

### Steps for Initial Setup
- Configure your ```config/database.yml```. Refer the ```config/database.example.yml``` file for guidance. The reference file is not required for the setup.
- Run pending migrations using the ```rails db:migrate``` command.
- Uncomment the code in ```db/seeds.rb``` and run ```rails db:seed``` to generate dummy records.
> [!NOTE]
> This process will take 60–90 seconds, depending on your internet speed.
> An admin user will be created with the following credentials:
  > - email: ```admin@gmail.com```
  > - password: ```admin123```
- Start the application using bin/dev (this is used instead of rails s to load Tailwind CSS).
- Enjoy your Book A Cab application!

### Versions
- Rails :- 7.2.2
- Ruby :- 3.2.2
- PostgreSQL :- 16.4