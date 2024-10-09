class MatchMailer < ApplicationMailer
  default from: 'no-reply@baloncestoapp.com'

  def match_assignment(match)
    @match = match
    @anotador = match.anotador
    mail(to: @anotador.email, subject: 'Asignación de Partido para Anotación')
  end
end
