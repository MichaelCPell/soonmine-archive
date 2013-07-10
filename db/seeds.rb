# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


capacitor_hash = {
  name: "Flux Capacitor",
  price: 1000,
  image_url: "/assets/flux_capacitor.jpeg",
  offsite_url: "http://en.wikipedia.org/wiki/Flux_capacitor#Flux_capacitor"
}

banana_hash = {
  name: "Banana Slicer",
  price: 359,
  image_url: "/assets/banana_slicer.jpg",
  offsite_url: "http://www.amazon.com/Hutzler-571-Banana-Slicer/dp/B0047E0EII/"
}

compressor_hash = {
  name: "Canless Air Compressor",
  price: 9999,
  image_url: "/assets/air_compressor.jpg",
  offsite_url: "http://www.thinkgeek.com/product/f162/"
}

boat_hash = {
  name: "Orvis-Edition Croff Craft Driftboat",
  price: 100000,
  image_url: "/assets/boat.jpg",
  offsite_url: "http://www.orvis.com/store/product.aspx?pf_id=8L1T"
}

@user = FactoryGirl.create(:user, firstname: "Stephanie", lastname: "Chase", image_url: "/assets/stephanie.jpg")
@list = @user.primary_list
@list.create_product(capacitor_hash)
@list.create_product(banana_hash)
@list.create_product(compressor_hash)
@list.create_product(boat_hash)





@user = FactoryGirl.create(:user, firstname: "David", lastname: "Pell", image_url: "/assets/david.jpg")
@list.create_product(compressor_hash)
@list.create_product(capacitor_hash)
@list.create_product(banana_hash)
@list.create_product(boat_hash)