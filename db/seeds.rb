# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.save([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.save(name: 'Emanuel', city: cities.first)
#function Condo
# r = Role.create(role_name: "Super Admin" ,condo_id: nil)
# r1= Role.create(role_name: "Admin" , condo_id: 1)
# r2= Role.create(role_name: "Admin" , condo_id: 2)


 p = Permission.create(per_name: "viewCondo")
 Function.create(action: "index", object: "Condo",permission_id: p.id)
 p = Permission.create(per_name: "editCondo")
 Function.create(action: "edit", object: "Condo",permission_id: p.id)
 Function.create(action: "update", object: "Condo",permission_id: p.id)
 Function.create(action: "create_image", object: "Condo",permission_id: p.id)
 p = Permission.create(per_name: "manageCondo")
 Function.create(action: "manage", object: "Condo",permission_id: p.id)
 #function Facility
 p = Permission.create(per_name: "viewFacility")
 Function.create(action: "index", object: "Facility",permission_id: p.id)
 p = Permission.create(per_name: "manageFacility")
 Function.create(action: "manage", object: "Facility",permission_id: p.id)
 # Function.create(action: "new", object: "Facility",permission_id: p.id)
 # Function.create(action: "edit", object: "Facility",permission_id: p.id)
 # Function.create(action: "timeslot", object: "Facility",permission_id: p.id)
 # Function.create(action: "add_timeslot", object: "Facility",permission_id: p.id)
 # Function.create(action: "update", object: "Facility",permission_id: p.id)
 # Function.create(action: "change_active", object: "Facility",permission_id: p.id)
 # Function.create(action: "confirm", object: "Facility",permission_id: p.id)
 # Function.create(action: "change_peak", object: "Facility",permission_id: p.id)
 # Function.create(action: "destroy", object: "Facility",permission_id: p.id)
 # Function.create(action: "create", object: "Facility",permission_id: p.id)

 #function feedback
 p = Permission.create(per_name: "viewFeedback")
 Function.create(action: "index", object: "Feedback",permission_id: p.id)
 p = Permission.create(per_name: "manageFeedback")
 Function.create(action: "manage", object: "Feedback",permission_id: p.id)
 # Function.create(action: "index_archive", object: "Feedback",permission_id: p.id)
 # Function.create(action: "destroy", object: "Feedback",permission_id: p.id)
 # Function.create(action: "destroy_multiple", object: "Feedback",permission_id: p.id)
 # Function.create(action: "move_multiple", object: "Feedback",permission_id: p.id)
 # Function.create(action: "update_reply", object: "Feedback",permission_id: p.id)
 # Function.create(action: "create_reply", object: "Feedback",permission_id: p.id)
 # Function.create(action: "move_archive", object: "Feedback",permission_id: p.id)
 # Function.create(action: "confirm_delete", object: "Feedback",permission_id: p.id)
 # Function.create(action: "reply", object: "Feedback",permission_id: p.id)
 # Function.create(action: "show_archive", object: "Feedback",permission_id: p.id)

 #function User
  p = Permission.create(per_name: "viewlistUser")
 Function.create(action: "index", object: "User" ,permission_id: p.id)
  p = Permission.create(per_name: "managelistUser")
 Function.create(action: "manage", object: "User",permission_id: p.id)


#function role
  p = Permission.create(per_name: "viewRole")
 Function.create(action: "index", object: "Role" ,permission_id: p.id)
  p = Permission.create(per_name: "manageRole")
 Function.create(action: "manage", object: "Role",permission_id: p.id)
 #function event
   p = Permission.create(per_name: "viewEvent")
 Function.create(action: "index", object: "Event" ,permission_id: p.id)
 Function.create(action: "show", object: "Event" ,permission_id: p.id)
  p = Permission.create(per_name: "manageEvent")
 Function.create(action: "manage", object: "Event",permission_id: p.id)
  #function booking
   p = Permission.create(per_name: "viewBooking")
 Function.create(action: "index", object: "Booking" ,permission_id: p.id)
  p = Permission.create(per_name: "manageBooking")
 Function.create(action: "manage", object: "Booking",permission_id: p.id)
 #function guard house
    p = Permission.create(per_name: "viewGuardHouse")
 Function.create(action: "index", object: "GuardHouse" ,permission_id: p.id)
  p = Permission.create(per_name: "manageGuardHouse")
 Function.create(action: "manage", object: "GuardHouse",permission_id: p.id)
  #function Form
    p = Permission.create(per_name: "viewForm")
 Function.create(action: "index", object: "Form" ,permission_id: p.id)
  p = Permission.create(per_name: "manageForm")
 Function.create(action: "manage", object: "Form",permission_id: p.id)
 #function bulletin
     p = Permission.create(per_name: "viewBulletin")
 Function.create(action: "index", object: "Bulletin" ,permission_id: p.id)
Function.create(action: "show", object: "Bulletin" ,permission_id: p.id)
  p = Permission.create(per_name: "manageBulletin")
 Function.create(action: "manage", object: "Bulletin",permission_id: p.id)
 #function HouseRule
     p = Permission.create(per_name: "viewHouseRule")
 Function.create(action: "index", object: "HouseRule" ,permission_id: p.id)
  p = Permission.create(per_name: "manageHouseRule")
 Function.create(action: "manage", object: "HouseRule",permission_id: p.id)