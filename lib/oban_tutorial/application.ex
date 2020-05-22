defmodule ObanTutorial.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      ObanTutorial.Repo,
      # Start the Telemetry supervisor
      ObanTutorialWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: ObanTutorial.PubSub},
      # Start the Endpoint (http/https)
      ObanTutorialWeb.Endpoint,
      {Oban, oban_config()}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ObanTutorial.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp oban_config do
    opts = Application.get_env(:oban_tutorial, Oban)

    if Code.ensure_loaded?(IEx) and IEx.started?() do
      opts
      |> Keyword.put(:crontab, false)
      |> Keyword.put(:queues, false)
    else
      opts
    end
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ObanTutorialWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
