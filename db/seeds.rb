# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Rake::Task['db:drop'].invoke
Rake::Task['db:create'].invoke
Rake::Task['db:migrate'].invoke

def random_brand_id
  Brand.offset(rand(Brand.count)).first.id
end

def upload_fake_image
  uploader = ImageUploader.new(Sneaker.new, :image)
  uploader.cache!(File.open(Dir.glob(File.join(Rails.root, 'lib/tasks/sneakers', '*')).sample))
  uploader
end

def upload_fake_logo
  uploader = LogoUploader.new(Brand.new, :logo)
  uploader.cache!(File.open(Dir.glob(File.join(Rails.root, 'lib/tasks/logo', '*')).sample))
  uploader
end

Brand.create([
  {
    name: 'Nike',
    logo: upload_fake_logo
  }, {
    name: 'Adidas',
    logo: upload_fake_logo
  }, {
    name: 'Puma',
    logo: upload_fake_logo
  }, {
    name: 'Vans',
    logo: upload_fake_logo
  }
])

@sneaker_models = ['NIKE AIR HUARACHE', 'SUPERSTAR BOOST SHOES', 'PUMA BY RIHANNA CREEPER WHITE BLACK', 'AUTHENTIC']

def sneaker_price
  rand(50..2100)
end

def create_sneaker
  Sneaker.create(
    brand_id: random_brand_id,
    model: @sneaker_models.sample,
    sex: 'Female',
    price: sneaker_price,
    image: upload_fake_image
  )
end

20.times do
  sneaker = create_sneaker
  puts "Sneaker #{sneaker.id} created"
end
