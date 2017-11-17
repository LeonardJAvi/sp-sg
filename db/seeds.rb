# This file should contain all the record creation needed to seed
# the database with its default values.
# The data can then be loaded with the rake db:seed
# (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# user = CreateAdminService.new.call
# puts 'CREATED ADMIN USER: ' << user.email

[:admin, :pending, :locked].each do |name|
  Role.create name: name
  puts "#{name} has been created"
end

User.create(
  name:'Admin', last_name: 'Keppler', identification:'00000000', email:'admin@keppler.com' , password:'12345678',
  password_confirmation: '12345678', birthdate:'2014-01-30', phone:'02694567809', address:'Urb. Caja de Agua', role_ids:'1'
)

puts 'admin@keppler.com has been created'

User.create(
  name:'Leonardo', last_name: 'Avila', identification:'22607006', email:'leonard_avi@keppler.com' , password:'22607006',
  password_confirmation: '22607006', birthdate:'1995-01-31', phone:'04143452319', address:'Urb. Las Americas', role_ids:'1'
)

User.create(
  name:'renny', last_name: 'petit', identification:'22606261', email:'renny10037@gmail.com' , password:'12345678',
  password_confirmation: '12345678', birthdate:'1995-01-31', phone:'04143452319', address:'Urb. Las Americas', role_ids:'1'
)

puts 'leonard_avi@keppler.com has been created'

Customize.create(file: "", installed: true)
puts 'Keppler Template has been created'
# Create setting deafult
setting = Setting.new(
  name: 'Keppler Admin', description: 'Welcome to Keppler Admin',
  smtp_setting_attributes: {
    address: 'test', port: '25', domain_name: 'keppler.com',
    email: 'info@keppler.com', password: '12345678'
  },
  google_analytics_setting_attributes: {
    ga_account_id: '60688852',
    ga_tracking_id: 'UA-60688852-1',
    ga_status: true
  }
)
setting.social_account = SocialAccount.new
setting.appearance = Appearance.new(theme_name: 'keppler')
setting.save

puts 'Setting default has been created'

puts '****Model Project****'

Project.create(name:'Keppler Starter', group:'05')

Project.create(name:'Keppler Enterprise', group:'05')

Project.create(name:'Keppler Checkin', group:'05')

Project.create(name:'Social Gourmet', group:'04')

Project.create(name:'Social CheckIn', group:'04')

puts 'project has been created'

puts '****Model Phase****'

Phase.create(name:'Diseño Wireframe', description:'Lorem', project_id:'1')

Phase.create(name:'Exportación Assest', description:'Lorem', project_id:'1')

Phase.create(name:'Redacción de Contenidos', description:'Lorem', project_id:'1')

Phase.create(name:'Implementación de Keppler', description:'Lorem', project_id:'1')

Phase.create(name:'Implementación de Catálogos', description:'Lorem', project_id:'1')

Phase.create(name:'Implementación de Pruebas', description:'Lorem', project_id:'1')

Phase.create(name:'Carga de Contenidos', description:'Lorem', project_id:'1')

Phase.create(name:'Subir a Producción', description:'Lorem', project_id:'1')

Phase.create(name:'Diseño Wireframe', description:'Lorem', project_id:'2')

Phase.create(name:'Exportación Assest', description:'Lorem', project_id:'2')

Phase.create(name:'Redacción de Contenidos', description:'Lorem', project_id:'2')

Phase.create(name:'Implementación de Keppler', description:'Lorem', project_id:'2')

Phase.create(name:'Implementación de Catálogos', description:'Lorem', project_id:'2')

Phase.create(name:'Implementación de Pruebas', description:'Lorem', project_id:'2')

Phase.create(name:'Carga de Contenidos', description:'Lorem', project_id:'2')

Phase.create(name:'Subir a Producción', description:'Lorem', project_id:'2')

puts 'phase has been created'

puts '****Model Task****'

Task.create(number_hours:'15',price_bolivar:'400.00',price_dolar:'40.00',cost_bolivar:'200.00',cost_dolar:'20.00',phase_id:'1')

Task.create(number_hours:'15',price_bolivar:'100.00',price_dolar:'10.00',cost_bolivar:'50.00',cost_dolar:'5.00',phase_id:'2')

Task.create(number_hours:'15',price_bolivar:'600.00',price_dolar:'60.00',cost_bolivar:'300.00',cost_dolar:'30.00',phase_id:'3')

Task.create(number_hours:'15',price_bolivar:'500.00',price_dolar:'50.00',cost_bolivar:'250.00',cost_dolar:'25.00',phase_id:'4')

Task.create(number_hours:'15',price_bolivar:'300.00',price_dolar:'30.00',cost_bolivar:'150.00',cost_dolar:'15.00',phase_id:'5')

Task.create(number_hours:'15',price_bolivar:'300.00',price_dolar:'30.00',cost_bolivar:'150.00',cost_dolar:'15.00',phase_id:'6')

Task.create(number_hours:'15',price_bolivar:'500.00',price_dolar:'50.00',cost_bolivar:'250.00',cost_dolar:'25.00',phase_id:'7')

Task.create(number_hours:'15',price_bolivar:'800.00',price_dolar:'80.00',cost_bolivar:'400.00',cost_dolar:'40.00',phase_id:'8')




Task.create(number_hours:'15',price_bolivar:'400.00',price_dolar:'40.00',cost_bolivar:'200.00',cost_dolar:'20.00',phase_id:'9')

Task.create(number_hours:'15',price_bolivar:'100.00',price_dolar:'10.00',cost_bolivar:'50.00',cost_dolar:'5.00',phase_id:'10')

Task.create(number_hours:'15',price_bolivar:'600.00',price_dolar:'60.00',cost_bolivar:'300.00',cost_dolar:'30.00',phase_id:'11')

Task.create(number_hours:'15',price_bolivar:'500.00',price_dolar:'50.00',cost_bolivar:'250.00',cost_dolar:'25.00',phase_id:'12')

Task.create(number_hours:'15',price_bolivar:'300.00',price_dolar:'30.00',cost_bolivar:'150.00',cost_dolar:'15.00',phase_id:'12')

Task.create(number_hours:'15',price_bolivar:'300.00',price_dolar:'30.00',cost_bolivar:'150.00',cost_dolar:'15.00',phase_id:'14')

Task.create(number_hours:'15',price_bolivar:'500.00',price_dolar:'50.00',cost_bolivar:'250.00',cost_dolar:'25.00',phase_id:'15')


puts 'task has been created'

puts '****Model Stack States****'

StackState.create(name:'Pending')

StackState.create(name:'In process')

StackState.create(name:'Internal Verification')

StackState.create(name:'Customer Verification')

StackState.create(name:'Paused')

StackState.create(name:'Annulled')

StackState.create(name:'Culmined')

puts 'stack state has been created'


