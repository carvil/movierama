class UserMailer < ActionMailer::Base
  default from: 'info@movierama.dev'

  def vote(movie_id, vote)
    movie = Movie[movie_id]
    user = movie.user
    subject = I18n.t('user_mailer.vote.subject', title: movie.title)
    body = I18n.t('user_mailer.vote.body', vote: vote)

    mail(to: user.email, subject: subject) do |format|
      format.text { render text: body }
    end
  end
end
