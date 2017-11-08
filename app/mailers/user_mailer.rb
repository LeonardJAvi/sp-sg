class UserMailer < ApplicationMailer
	def rol(user)
		@user = user
		if user.rol == "admin"
			mail(to: user.email, subject: " Usuario asignado")
		elsif user.rol =="pending"
			mail(to: user.email, subject: " Usuario en lista de espera")
		elsif user.rol =="bloqueado"
			mail(to: user.email, subject: " Usuario Bloqueado")
		end
	end
end
