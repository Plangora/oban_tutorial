defmodule ObanTutorial.Accounts.Jobs.WelcomeEmail do
  use Oban.Worker, queue: :default, max_attempts: 4

  @impl Oban.Worker
  def perform(%{"email" => email}, _job) do
    IO.inspect(email)
    :ok
  end

  def perform(args, _job) do
    Logger.error("#{__MODULE__} not recognizing args: #{inspect(args)}")
    :error
  end
end