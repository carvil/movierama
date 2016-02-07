class VotingNotifier
  attr_reader :movie
  attr_accessor :notifications_worker_class

  def initialize(movie)
    @movie = movie
  end

  def notify(vote)
    notifications_worker_class.perform_async(
      movie.id,
      vote
    ) if _should_notify?
  end

  def notifications_worker_class
    @notifications_worker_class ||= NotificationsWorker
  end

  private

  def _should_notify?
    movie.notify
  end
end
