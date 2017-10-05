
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

puts 'phase has been created'


puts '****Model Task****'

Task.create(price_bolivar:'400.00',price_dolar:'40.00',cost_bolivar:'200.00',cost_dolar:'20.00',phase_id:'1')

Task.create(price_bolivar:'100.00',price_dolar:'10.00',cost_bolivar:'50.00',cost_dolar:'5.00',phase_id:'2')

Task.create(price_bolivar:'600.00',price_dolar:'60.00',cost_bolivar:'300.00',cost_dolar:'30.00',phase_id:'3')


Task.create(price_bolivar:'500.00',price_dolar:'50.00',cost_bolivar:'250.00',cost_dolar:'25.00',phase_id:'4')

Task.create(price_bolivar:'300.00',price_dolar:'30.00',cost_bolivar:'150.00',cost_dolar:'15.00',phase_id:'5')

Task.create(price_bolivar:'300.00',price_dolar:'30.00',cost_bolivar:'150.00',cost_dolar:'15.00',phase_id:'6')

Task.create(price_bolivar:'500.00',price_dolar:'50.00',cost_bolivar:'250.00',cost_dolar:'25.00',phase_id:'7')

Task.create(price_bolivar:'800.00',price_dolar:'80.00',cost_bolivar:'400.00',cost_dolar:'40.00',phase_id:'8')


puts 'task has been created'

puts '****Model Stack States****'

StackState.create(name:'Pending')

StackState.create(name:'In process')

StackState.create(name:'Internal Verification')

StackState.create(name:'Customer Verification')

StackState.create(name:'Paused')

StackState.create(name:'Annulled')

StackState.create(name:'Delivered')

puts 'stack state has been created'


puts '****Model Stack Phases****'


StackPhase.create(name:'Diseño Wireframe')

StackPhase.create(name:'Exportación Assest')

StackPhase.create(name:'Redacción de Contenidos')

StackPhase.create(name:'Implementación de Keppler')

StackPhase.create(name:'Implementación de Catálogos')

StackPhase.create(name:'Implementación de Pruebas')

StackPhase.create(name:'Carga de Contenidos')

StackPhase.create(name:'Subir a Producción')

puts 'stack phase has been created'


puts '****Model Order****'

puts 'order has been created'


